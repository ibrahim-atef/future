import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/features/courses/data/models/quiz_models.dart';
import 'package:future_app/features/courses/data/repos/quiz_repo.dart';
import 'package:future_app/features/courses/logic/cubit/quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit(this._quizRepo) : super(const QuizState.initial());

  final QuizRepo _quizRepo;
  Timer? _timer;
  int _remainingSeconds = 0;
  StartQuizResponseModel? _quizData;

  // Getters
  int get remainingSeconds => _remainingSeconds;
  String get formattedTime {
    final minutes = _remainingSeconds ~/ 60;
    final seconds = _remainingSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  StartQuizResponseModel? get quizData => _quizData;

  // Helper method to safely emit states
  void _safeEmit(QuizState state) {
    if (!isClosed) {
      emit(state);
    }
  }

  // Start quiz
  Future<void> startQuiz(String quizId) async {
    _safeEmit(const QuizState.startQuizLoading());
    final response = await _quizRepo.startQuiz(quizId);
    response.when(
      success: (data) {
        _quizData = data; // Save quiz data
        _remainingSeconds =
            data.data.timeLimit * 60; // Convert minutes to seconds
        _startTimer();
        _safeEmit(QuizState.startQuizSuccess(data));
      },
      failure: (apiErrorModel) {
        _safeEmit(QuizState.startQuizError(apiErrorModel));
      },
    );
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
    _quizData = null;
    _remainingSeconds = 0;
    _stopTimer();
    _safeEmit(const QuizState.initial());
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
