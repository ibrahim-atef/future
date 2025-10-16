import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/core/di/di.dart';
import 'package:future_app/features/courses/data/models/quiz_models.dart';
import 'package:future_app/features/courses/logic/cubit/quiz_cubit.dart';
import 'package:future_app/features/courses/logic/cubit/quiz_state.dart';

class QuizScreen extends StatefulWidget {
  final String quizId;
  final String quizTitle;

  const QuizScreen({
    super.key,
    required this.quizId,
    required this.quizTitle,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  final Map<String, String> _answers = {};
  final Map<String, TextEditingController> _textControllers = {};

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = getIt<QuizCubit>();
        // Only start quiz if not already started or if different quiz
        if (cubit.quizData == null ||
            cubit.quizData!.data.id != widget.quizId) {
          cubit.startQuiz(widget.quizId);
        }
        return cubit;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF1a1a1a),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1a1a1a),
          elevation: 0,
          title: Text(
            widget.quizTitle,
            style: const TextStyle(
              color: Color(0xFFd4af37),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFd4af37)),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocConsumer<QuizCubit, QuizState>(
          listener: (context, state) {
            state.whenOrNull(
              quizTimeUp: () {
                _submitQuiz(context);
              },
              sendQuizResultSuccess: (data) {
                _showQuizResult(context, data);
              },
            );
          },
          builder: (context, state) {
            return state.when(
              initial: () => const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFd4af37),
                ),
              ),
              startQuizLoading: () => const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFd4af37),
                ),
              ),
              startQuizSuccess: (data) => _buildQuizContent(context, data),
              startQuizError: (error) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 64,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'حدث خطأ في تحميل الاختبار',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      error.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        context.read<QuizCubit>().resetQuiz();
                        context.read<QuizCubit>().startQuiz(widget.quizId);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFd4af37),
                        foregroundColor: Colors.black,
                      ),
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              ),
              sendQuizResultLoading: () => const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFd4af37),
                ),
              ),
              sendQuizResultSuccess: (data) => _buildQuizResult(context, data),
              sendQuizResultError: (error) => Center(
                child: Text(
                  'خطأ في إرسال النتيجة: ${error.message}',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              quizTimerTick: (remainingSeconds) {
                final cubit = context.read<QuizCubit>();
                return _buildQuizContent(context, cubit.quizData);
              },
              quizTimeUp: () => const Center(
                child: Text(
                  'انتهى الوقت!',
                  style: TextStyle(color: Colors.red, fontSize: 24),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildQuizContent(BuildContext context, StartQuizResponseModel? data) {
    if (data == null) return const SizedBox.shrink();

    final quiz = data.data;
    final currentQuestion = quiz.questions[_currentQuestionIndex];
    final quizCubit = context.read<QuizCubit>();

    return Column(
      children: [
        // Timer and Progress
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Timer
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFd4af37),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: BlocBuilder<QuizCubit, QuizState>(
                  builder: (context, state) {
                    return Text(
                      quizCubit.formattedTime,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    );
                  },
                ),
              ),
              // Progress
              Text(
                '${_currentQuestionIndex + 1} / ${quiz.questions.length}',
                style: const TextStyle(
                  color: Color(0xFFd4af37),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        // Question
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Question Title
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2a2a2a),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFFd4af37)),
                  ),
                  child: Text(
                    currentQuestion.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Question Type and Marks
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFd4af37),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        currentQuestion.type == 'multiple_choice'
                            ? 'اختيار متعدد'
                            : currentQuestion.type == 'short_answer'
                                ? 'إجابة قصيرة'
                                : currentQuestion.type,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${currentQuestion.marks} نقطة',
                      style: const TextStyle(
                        color: Color(0xFFd4af37),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                // Answers - Different UI based on question type
                if (currentQuestion.type == 'multiple_choice')
                  ...currentQuestion.answers.map((answer) {
                    final isSelected =
                        _answers[currentQuestion.id] == answer.id;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _answers[currentQuestion.id] = answer.id;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFd4af37).withOpacity(0.2)
                                : const Color(0xFF2a2a2a),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFFd4af37)
                                  : Colors.grey[700]!,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFFd4af37)
                                        : Colors.grey[700]!,
                                    width: 2,
                                  ),
                                  color: isSelected
                                      ? const Color(0xFFd4af37)
                                      : Colors.transparent,
                                ),
                                child: isSelected
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.black,
                                        size: 12,
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  answer.title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
                else if (currentQuestion.type == 'short_answer')
                  _buildShortAnswerInput(currentQuestion)
                else
                  // Fallback for other question types
                  ...currentQuestion.answers.map((answer) {
                    final isSelected =
                        _answers[currentQuestion.id] == answer.id;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _answers[currentQuestion.id] = answer.id;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? const Color(0xFFd4af37).withOpacity(0.2)
                                : const Color(0xFF2a2a2a),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? const Color(0xFFd4af37)
                                  : Colors.grey[700]!,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? const Color(0xFFd4af37)
                                        : Colors.grey[700]!,
                                    width: 2,
                                  ),
                                  color: isSelected
                                      ? const Color(0xFFd4af37)
                                      : Colors.transparent,
                                ),
                                child: isSelected
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.black,
                                        size: 12,
                                      )
                                    : null,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  answer.title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
              ],
            ),
          ),
        ),

        // Navigation Buttons
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Previous Button
              if (_currentQuestionIndex > 0)
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _currentQuestionIndex--;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[700],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('السابق'),
                  ),
                ),

              if (_currentQuestionIndex > 0) const SizedBox(width: 12),

              // Next/Submit Button
              Expanded(
                child: ElevatedButton(
                  onPressed: _isQuestionAnswered(currentQuestion)
                      ? () {
                          if (_currentQuestionIndex <
                              quiz.questions.length - 1) {
                            setState(() {
                              _currentQuestionIndex++;
                            });
                          } else {
                            _submitQuiz(context);
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFd4af37),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text(
                    _currentQuestionIndex < quiz.questions.length - 1
                        ? 'التالي'
                        : 'إرسال الاختبار',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuizResult(BuildContext context, QuizResultResponseModel data) {
    final result = data.data;
    final isPassed = result.passed;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Result Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isPassed
                    ? Colors.green.withOpacity(0.2)
                    : Colors.red.withOpacity(0.2),
                border: Border.all(
                  color: isPassed ? Colors.green : Colors.red,
                  width: 4,
                ),
              ),
              child: Icon(
                isPassed ? Icons.check_circle : Icons.cancel,
                size: 60,
                color: isPassed ? Colors.green : Colors.red,
              ),
            ),

            const SizedBox(height: 24),

            // Result Title
            Text(
              isPassed
                  ? 'مبروك! لقد نجحت في الاختبار'
                  : 'للأسف لم تنجح في الاختبار',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isPassed ? Colors.green : Colors.red,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // Score Details
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF2a2a2a),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFd4af37)),
              ),
              child: Column(
                children: [
                  const Text(
                    'النتيجة',
                    style: TextStyle(
                      color: Color(0xFFd4af37),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildScoreItem(
                          'الدرجة', '${result.score}/${result.total}'),
                      _buildScoreItem('النسبة', '${result.percentage}%'),
                      _buildScoreItem(
                          'الحالة', result.status == 'passed' ? 'نجح' : 'راسب'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[700],
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('العودة'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _currentQuestionIndex = 0;
                        _answers.clear();
                      });
                      context.read<QuizCubit>().resetQuiz();
                      context.read<QuizCubit>().startQuiz(widget.quizId);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFd4af37),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text('إعادة الاختبار'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _buildShortAnswerInput(QuizQuestionModel question) {
    // Initialize text controller if not exists
    if (!_textControllers.containsKey(question.id)) {
      _textControllers[question.id] = TextEditingController();
      // Set initial value if answer exists
      if (_answers.containsKey(question.id)) {
        _textControllers[question.id]!.text = _answers[question.id]!;
      }
    }

    final hasText = _textControllers[question.id]?.text.isNotEmpty ?? false;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: hasText
            ? const Color(0xFFd4af37).withOpacity(0.1)
            : const Color(0xFF2a2a2a),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: hasText ? const Color(0xFFd4af37) : Colors.grey[700]!,
          width: 2,
        ),
        boxShadow: hasText
            ? [
                BoxShadow(
                  color: const Color(0xFFd4af37).withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            decoration: BoxDecoration(
              color: hasText
                  ? const Color(0xFFd4af37).withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                topRight: Radius.circular(14),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.edit_note,
                  color: hasText ? const Color(0xFFd4af37) : Colors.grey[600],
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'إجابتك',
                  style: TextStyle(
                    color: hasText ? const Color(0xFFd4af37) : Colors.grey[400],
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (hasText)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFd4af37),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '${_textControllers[question.id]!.text.length}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Text Field
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: TextField(
              controller: _textControllers[question.id],
              onChanged: (value) {
                setState(() {
                  _answers[question.id] = value;
                });
              },
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                height: 1.4,
              ),
              decoration: InputDecoration(
                hintText: 'اكتب إجابتك هنا...',
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontSize: 16,
                  height: 1.4,
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                counterText: '',
              ),
              maxLines: 4,
              minLines: 2,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              textAlignVertical: TextAlignVertical.top,
            ),
          ),
        ],
      ),
    );
  }

  bool _isQuestionAnswered(QuizQuestionModel question) {
    if (question.type == 'short_answer') {
      return _answers.containsKey(question.id) &&
          _answers[question.id]!.trim().isNotEmpty;
    } else {
      return _answers.containsKey(question.id);
    }
  }

  @override
  void dispose() {
    // Dispose text controllers
    for (var controller in _textControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _submitQuiz(BuildContext context) {
    if (_answers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى الإجابة على سؤال واحد على الأقل'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    context.read<QuizCubit>().sendQuizResult(widget.quizId, _answers);
  }

  void _showQuizResult(BuildContext context, QuizResultResponseModel data) {
    // The result is already handled in the BlocConsumer listener
  }
}
