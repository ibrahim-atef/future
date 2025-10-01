class QuizModel {
  final String id;
  final String courseId;
  final String title;
  final String? description;
  final int timeLimit; // in minutes
  final int totalQuestions;
  final int passingScore;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  QuizModel({
    required this.id,
    required this.courseId,
    required this.title,
    this.description,
    required this.timeLimit,
    required this.totalQuestions,
    required this.passingScore,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'] ?? '',
      courseId: json['course_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'],
      timeLimit: json['time_limit'] ?? 0,
      totalQuestions: json['total_questions'] ?? 0,
      passingScore: json['passing_score'] ?? 0,
      isActive: json['is_active'] ?? true,
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'course_id': courseId,
      'title': title,
      'description': description,
      'time_limit': timeLimit,
      'total_questions': totalQuestions,
      'passing_score': passingScore,
      'is_active': isActive,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

class QuizQuestion {
  final String id;
  final String quizId;
  final String question;
  final String type; // multiple_choice, true_false, text
  final List<QuizOption> options;
  final String? correctAnswer;
  final int points;
  final int order;

  QuizQuestion({
    required this.id,
    required this.quizId,
    required this.question,
    required this.type,
    required this.options,
    this.correctAnswer,
    required this.points,
    required this.order,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      id: json['id'] ?? '',
      quizId: json['quiz_id'] ?? '',
      question: json['question'] ?? '',
      type: json['type'] ?? 'multiple_choice',
      options: json['options'] != null 
          ? (json['options'] as List).map((e) => QuizOption.fromJson(e)).toList()
          : [],
      correctAnswer: json['correct_answer'],
      points: json['points'] ?? 1,
      order: json['order'] ?? 0,
    );
  }
}

class QuizOption {
  final String id;
  final String text;
  final bool isCorrect;

  QuizOption({
    required this.id,
    required this.text,
    required this.isCorrect,
  });

  factory QuizOption.fromJson(Map<String, dynamic> json) {
    return QuizOption(
      id: json['id'] ?? '',
      text: json['text'] ?? '',
      isCorrect: json['is_correct'] ?? false,
    );
  }
}

class QuizResult {
  final String id;
  final String quizId;
  final String userId;
  final int score;
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final double percentage;
  final bool passed;
  final int timeSpent; // in seconds
  final DateTime completedAt;
  final DateTime createdAt;

  QuizResult({
    required this.id,
    required this.quizId,
    required this.userId,
    required this.score,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.percentage,
    required this.passed,
    required this.timeSpent,
    required this.completedAt,
    required this.createdAt,
  });

  factory QuizResult.fromJson(Map<String, dynamic> json) {
    return QuizResult(
      id: json['id'] ?? '',
      quizId: json['quiz_id'] ?? '',
      userId: json['user_id'] ?? '',
      score: json['score'] ?? 0,
      totalQuestions: json['total_questions'] ?? 0,
      correctAnswers: json['correct_answers'] ?? 0,
      wrongAnswers: json['wrong_answers'] ?? 0,
      percentage: (json['percentage'] ?? 0.0).toDouble(),
      passed: json['passed'] ?? false,
      timeSpent: json['time_spent'] ?? 0,
      completedAt: DateTime.parse(json['completed_at'] ?? DateTime.now().toIso8601String()),
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }
}

class QuizSubmission {
  final String quizId;
  final Map<String, String> answers; // question_id -> answer
  final int timeSpent;

  QuizSubmission({
    required this.quizId,
    required this.answers,
    required this.timeSpent,
  });

  Map<String, dynamic> toJson() {
    return {
      'answers': answers,
      'time_spent': timeSpent,
    };
  }
}
