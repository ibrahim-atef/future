import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:future_app/core/network/api_error_model.dart';
import 'package:future_app/features/courses/data/models/courses_model.dart';
import 'package:future_app/core/models/banner_model.dart';

part 'courses_state.freezed.dart';

@freezed
class CoursesState with _$CoursesState {
  const factory CoursesState.initial() = _Initial;

  // get banners
  const factory CoursesState.getBannersLoading() = GetBannersLoading;
  const factory CoursesState.getBannersSuccess(BannerResponseModel data) =
      GetBannersSuccess;
  const factory CoursesState.getBannersError(ApiErrorModel apiErrorModel) =
      GetBannersError;

  // get courses
  const factory CoursesState.getCoursesLoading() = GetCoursesLoading;
  const factory CoursesState.getCoursesSuccess(GetCoursesResponseModel data) =
      GetCoursesSuccess;
  const factory CoursesState.getCoursesError(ApiErrorModel apiErrorModel) =
      GetCoursesError;

  // load more courses (pagination)
  const factory CoursesState.loadMoreCoursesLoading() = LoadMoreCoursesLoading;
  const factory CoursesState.loadMoreCoursesSuccess(
      GetCoursesResponseModel data) = LoadMoreCoursesSuccess;
  const factory CoursesState.loadMoreCoursesError(ApiErrorModel apiErrorModel) =
      LoadMoreCoursesError;

  // get single course
  const factory CoursesState.getSingleCourseLoading() = GetSingleCourseLoading;
  const factory CoursesState.getSingleCourseSuccess(
      GetSingleCourseResponseModel data) = GetSingleCourseSuccess;
  const factory CoursesState.getSingleCourseError(ApiErrorModel apiErrorModel) =
      GetSingleCourseError;
}
