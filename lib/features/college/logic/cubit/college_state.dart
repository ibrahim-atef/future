import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:future_app/core/models/banner_model.dart';
import 'package:future_app/core/network/api_error_model.dart';
import 'package:future_app/features/courses/data/models/courses_model.dart';

part 'college_state.freezed.dart';

@freezed
class CollegeState with _$CollegeState {
  const factory CollegeState.initial() = _Initial;

  // Get banners
  const factory CollegeState.getBannersLoading() = GetBannersLoading;
  const factory CollegeState.getBannersSuccess(BannerResponseModel data) =
      GetBannersSuccess;
  const factory CollegeState.getBannersError(ApiErrorModel apiErrorModel) =
      GetBannersError;

  // Get courses
  const factory CollegeState.getCoursesLoading() = GetCoursesLoading;
  const factory CollegeState.getCoursesSuccess(GetCoursesResponseModel data) =
      GetCoursesSuccess;
  const factory CollegeState.getCoursesError(ApiErrorModel apiErrorModel) =
      GetCoursesError;
}
