import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:future_app/core/network/api_error_model.dart';
import 'package:future_app/features/blog/data/models/blog_model.dart';

part 'blog_state.freezed.dart';

@freezed
class BlogState with _$BlogState {
  const factory BlogState.initial() = _Initial;

  // Get posts
  const factory BlogState.getPostsLoading() = GetPostsLoading;
  const factory BlogState.getPostsSuccess(GetPostsResponseModel data) =
      GetPostsSuccess;
  const factory BlogState.getPostsError(ApiErrorModel apiErrorModel) =
      GetPostsError;

  // Get post categories
  const factory BlogState.getCategoriesLoading() = GetCategoriesLoading;
  const factory BlogState.getCategoriesSuccess(
      GetPostCategoriesResponseModel data) = GetCategoriesSuccess;
  const factory BlogState.getCategoriesError(ApiErrorModel apiErrorModel) =
      GetCategoriesError;

  // Get post details
  const factory BlogState.getPostDetailsLoading() = GetPostDetailsLoading;
  const factory BlogState.getPostDetailsSuccess(
      GetPostDetailsResponseModel data) = GetPostDetailsSuccess;
  const factory BlogState.getPostDetailsError(ApiErrorModel apiErrorModel) =
      GetPostDetailsError;
}
