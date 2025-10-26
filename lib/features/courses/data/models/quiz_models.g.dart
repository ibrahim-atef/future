// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuizAnswerModel _$QuizAnswerModelFromJson(Map<String, dynamic> json) =>
    QuizAnswerModel(
      id: json['id'] as String,
      title: json['title'] as String,
      isCorrect: json['is_correct'] as bool,
    );

Map<String, dynamic> _$QuizAnswerModelToJson(QuizAnswerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'is_correct': instance.isCorrect,
    };

QuizQuestionModel _$QuizQuestionModelFromJson(Map<String, dynamic> json) =>
    QuizQuestionModel(
      id: json['id'] as String,
      title: json['title'] as String,
      type: json['type'] as String,
      marks: (json['marks'] as num).toInt(),
      answers: (json['answers'] as List<dynamic>)
          .map((e) => QuizAnswerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuizQuestionModelToJson(QuizQuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'type': instance.type,
      'marks': instance.marks,
      'answers': instance.answers,
    };

QuizDataModel _$QuizDataModelFromJson(Map<String, dynamic> json) =>
    QuizDataModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      timeLimit: (json['time_limit'] as num).toInt(),
      questions: (json['questions'] as List<dynamic>)
          .map((e) => QuizQuestionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuizDataModelToJson(QuizDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'time_limit': instance.timeLimit,
      'questions': instance.questions,
    };

StartQuizResponseModel _$StartQuizResponseModelFromJson(
        Map<String, dynamic> json) =>
    StartQuizResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: QuizDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StartQuizResponseModelToJson(
        StartQuizResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

QuizResultRequestModel _$QuizResultRequestModelFromJson(
        Map<String, dynamic> json) =>
    QuizResultRequestModel(
      answers: Map<String, String>.from(json['answers'] as Map),
    );

Map<String, dynamic> _$QuizResultRequestModelToJson(
        QuizResultRequestModel instance) =>
    <String, dynamic>{
      'answers': instance.answers,
    };

QuizResultDataModel _$QuizResultDataModelFromJson(Map<String, dynamic> json) =>
    QuizResultDataModel(
      score: (json['score'] as num).toInt(),
      total: (json['total'] as num).toInt(),
      percentage: (json['percentage'] as num).toInt(),
      passed: json['passed'] as bool,
      status: json['status'] as String,
    );

Map<String, dynamic> _$QuizResultDataModelToJson(
        QuizResultDataModel instance) =>
    <String, dynamic>{
      'score': instance.score,
      'total': instance.total,
      'percentage': instance.percentage,
      'passed': instance.passed,
      'status': instance.status,
    };

QuizResultResponseModel _$QuizResultResponseModelFromJson(
        Map<String, dynamic> json) =>
    QuizResultResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: QuizResultDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuizResultResponseModelToJson(
        QuizResultResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
