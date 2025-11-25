import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/features/courses/data/models/quiz_models.dart';
import 'package:future_app/features/courses/data/repos/quiz_repo.dart';
import 'package:future_app/features/courses/logic/cubit/quiz_state.dart';
import 'package:future_app/core/network/api_error_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit(this._quizRepo) : super(const QuizState.initial());

  final QuizRepo _quizRepo;
  Timer? _timer;
  int _remainingSeconds = 0;
  StartQuizResponseModel? _quizData;
  String? _currentQuizId;

  // Getters
  int get remainingSeconds => _remainingSeconds;
  String get formattedTime {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  StartQuizResponseModel? get quizData => _quizData;
  String? get currentQuizId => _currentQuizId;

  // Helper method to safely emit states
  void _safeEmit(QuizState state) {
    if (!isClosed) {
      emit(state);
    }
  }

  // Check if quiz was already started
  Future<bool> isQuizStarted(String quizId) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('quiz_started_$quizId') ?? false;
  }

  // Mark quiz as started
  Future<void> _markQuizAsStarted(String quizId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('quiz_started_$quizId', true);
  }

  // Mark quiz as completed (allows restart)
  Future<void> markQuizAsCompleted(String quizId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('quiz_started_$quizId');
  }

  // Start quiz
  Future<void> startQuiz(String quizId, {bool forceRestart = false, DateTime? quizCreatedAt}) async {
    // Always stop timer first to prevent conflicts
    _stopTimer();
    
    // If this is a different quiz, reset everything first
    if (_currentQuizId != null && _currentQuizId != quizId) {
      await _clearPreviousQuiz(_currentQuizId!);
      // Reset state completely
      _quizData = null;
      _remainingSeconds = 0;
      _currentQuizId = null;
      _safeEmit(const QuizState.initial());
    }
    
    // If force restart, clear the quiz flag first
    if (forceRestart) {
      await markQuizAsCompleted(quizId);
    }
    
    _currentQuizId = quizId;
    
    // Check if quiz was already started
    final wasStarted = await isQuizStarted(quizId);
    if (wasStarted && !forceRestart) {
      _safeEmit(QuizState.startQuizError(
        ApiErrorModel(message: 'لا يمكن إعادة بدء الاختبار بعد الخروج منه'),
      ));
      return;
    }

    _safeEmit(const QuizState.startQuizLoading());
    final response = await _quizRepo.startQuiz(quizId);
    response.when(
      success: (data) {
        // Make sure timer is stopped before starting new one
        _stopTimer();
        
        // Calculate time limit normally first
        if (data.data.timeLimit == 0) {
          // If time_limit is 0, set 10 seconds per question
          final questionCount = data.data.questions.length;
          _remainingSeconds = questionCount * 10;
        } else {
          // Convert minutes to seconds
          _remainingSeconds = data.data.timeLimit * 60;
        }
        
        // Check if quiz time has expired (if createdAt is provided)
        // Only check if both createdAt and timeLimit are valid
        if (quizCreatedAt != null && data.data.timeLimit > 0) {
          final now = DateTime.now();
          final timeLimitInMinutes = data.data.timeLimit;
          
          // Calculate expiration time: createdAt + timeLimit
          final expirationTime = quizCreatedAt.add(Duration(minutes: timeLimitInMinutes));
          
          // Only check expiration if createdAt is in the past (reasonable date)
          // If createdAt is in the future (more than 1 day), it's likely a timezone/format issue
          final daysSinceCreation = now.difference(quizCreatedAt).inDays;
          final isCreatedAtValid = daysSinceCreation >= -1 && daysSinceCreation <= 365; // Within reasonable range
          
          if (isCreatedAtValid) {
            // Calculate remaining time from now
            final remainingTime = expirationTime.difference(now);
            final remainingSeconds = remainingTime.inSeconds;
            
            // Check if time has expired (only if createdAt is in the past)
            if (quizCreatedAt.isBefore(now) && remainingSeconds <= 0) {
              // Time has expired
              _safeEmit(QuizState.startQuizError(
                ApiErrorModel(message: 'انتهى الوقت المحدد للاختبار'),
              ));
              return;
            }
            
            // If there's remaining time, use it (but don't exceed the original timeLimit)
            if (remainingSeconds > 0 && remainingSeconds <= _remainingSeconds) {
              _remainingSeconds = remainingSeconds;
            }
            // If remainingSeconds > _remainingSeconds, it means createdAt is in the future
            // In this case, use the normal timeLimit (already set above)
          }
          // If createdAt is not valid (future date or too old), use normal timeLimit
        }
        
        _quizData = data; // Save quiz data
        _markQuizAsStarted(quizId);
        _startTimer();
        _safeEmit(QuizState.startQuizSuccess(data));
      },
      failure: (apiErrorModel) {
        _safeEmit(QuizState.startQuizError(apiErrorModel));
      },
    );
  }
  
  // Clear previous quiz data
  Future<void> _clearPreviousQuiz(String previousQuizId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('quiz_started_$previousQuizId');
  }

  // Send quiz result
  Future<void> sendQuizResult(
      String quizId, Map<String, String> answers) async {
    if (isClosed) return;
    _safeEmit(const QuizState.sendQuizResultLoading());
    final request = QuizResultRequestModel(answers: answers);
    final response = await _quizRepo.sendQuizResult(quizId, request);
    response.when(
      success: (data) {
        _stopTimer();
        // Mark quiz as completed so it can be restarted
        markQuizAsCompleted(quizId);
        _safeEmit(QuizState.sendQuizResultSuccess(data));
      },
      failure: (apiErrorModel) {
        _safeEmit(QuizState.sendQuizResultError(apiErrorModel));
      },
    );
  }

  // Start timer
  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (isClosed) {
        timer.cancel();
        return;
      }
      if (_remainingSeconds > 0) {
        _remainingSeconds--;
        _safeEmit(QuizState.quizTimerTick(_remainingSeconds));
      } else {
        _stopTimer();
        _safeEmit(const QuizState.quizTimeUp());
      }
    });
  }

  // Reset quiz data
  void resetQuiz() {
    // Stop timer first
    _stopTimer();
    // Clear all data
    _quizData = null;
    _remainingSeconds = 0;
    _currentQuizId = null;
    // Emit initial state
    _safeEmit(const QuizState.initial());
  }
  
  // Clear all quiz flags (for debugging/reset all)
  Future<void> clearAllQuizFlags() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();
    for (var key in keys) {
      if (key.startsWith('quiz_started_')) {
        await prefs.remove(key);
      }
    }
  }

  // Stop timer
  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  Future<void> close() {
    _stopTimer();
    return super.close();
  }
}
