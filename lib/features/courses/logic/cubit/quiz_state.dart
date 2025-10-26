import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:future_app/core/network/api_error_model.dart';
import 'package:future_app/features/courses/data/models/quiz_models.dart';

part 'quiz_state.freezed.dart';

@freezed
class QuizState with _$QuizState {
  const factory QuizState.initial() = _Initial;

  // start quiz
  const factory QuizState.startQuizLoading() = StartQuizLoading;
  const factory QuizState.startQuizSuccess(StartQuizResponseModel data) =
      StartQuizSuccess;
  const factory QuizState.startQuizError(ApiErrorModel apiErrorModel) =
      StartQuizError;

  // send quiz result
  const factory QuizState.sendQuizResultLoading() = SendQuizResultLoading;
  const factory QuizState.sendQuizResultSuccess(QuizResultResponseModel data) =
      SendQuizResultSuccess;
  const factory QuizState.sendQuizResultError(ApiErrorModel apiErrorModel) =
      SendQuizResultError;

  // quiz timer
  const factory QuizState.quizTimerTick(int remainingSeconds) = QuizTimerTick;
  const factory QuizState.quizTimeUp() = QuizTimeUp;
}
