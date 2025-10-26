import 'package:json_annotation/json_annotation.dart';

part 'quiz_models.g.dart';

// Quiz Answer Model
@JsonSerializable()
class QuizAnswerModel {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'is_correct')
  final bool isCorrect;

  QuizAnswerModel({
    required this.id,
    required this.title,
    required this.isCorrect,
  });

  factory QuizAnswerModel.fromJson(Map<String, dynamic> json) =>
      _$QuizAnswerModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuizAnswerModelToJson(this);
}

// Quiz Question Model
@JsonSerializable()
class QuizQuestionModel {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'marks')
  final int marks;

  @JsonKey(name: 'answers')
  final List<QuizAnswerModel> answers;

  QuizQuestionModel({
    required this.id,
    required this.title,
    required this.type,
    required this.marks,
    required this.answers,
  });

  factory QuizQuestionModel.fromJson(Map<String, dynamic> json) =>
      _$QuizQuestionModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuizQuestionModelToJson(this);
}

// Quiz Data Model
@JsonSerializable()
class QuizDataModel {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'time_limit')
  final int timeLimit;

  @JsonKey(name: 'questions')
  final List<QuizQuestionModel> questions;

  QuizDataModel({
    required this.id,
    required this.title,
    required this.description,
    required this.timeLimit,
    required this.questions,
  });

  factory QuizDataModel.fromJson(Map<String, dynamic> json) =>
      _$QuizDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuizDataModelToJson(this);
}

// Start Quiz Response Model
@JsonSerializable()
class StartQuizResponseModel {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final QuizDataModel data;

  StartQuizResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory StartQuizResponseModel.fromJson(Map<String, dynamic> json) =>
      _$StartQuizResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$StartQuizResponseModelToJson(this);
}

// Quiz Result Request Model
@JsonSerializable()
class QuizResultRequestModel {
  @JsonKey(name: 'answers')
  final Map<String, String> answers;

  QuizResultRequestModel({
    required this.answers,
  });

  factory QuizResultRequestModel.fromJson(Map<String, dynamic> json) =>
      _$QuizResultRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuizResultRequestModelToJson(this);
}

// Quiz Result Data Model
@JsonSerializable()
class QuizResultDataModel {
  @JsonKey(name: 'score')
  final int score;

  @JsonKey(name: 'total')
  final int total;

  @JsonKey(name: 'percentage')
  final int percentage;

  @JsonKey(name: 'passed')
  final bool passed;

  @JsonKey(name: 'status')
  final String status;

  QuizResultDataModel({
    required this.score,
    required this.total,
    required this.percentage,
    required this.passed,
    required this.status,
  });

  factory QuizResultDataModel.fromJson(Map<String, dynamic> json) =>
      _$QuizResultDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuizResultDataModelToJson(this);
}

// Quiz Result Response Model
@JsonSerializable()
class QuizResultResponseModel {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final QuizResultDataModel data;

  QuizResultResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory QuizResultResponseModel.fromJson(Map<String, dynamic> json) =>
      _$QuizResultResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuizResultResponseModelToJson(this);
}
