import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/features/blog/data/models/blog_model.dart';
import 'package:future_app/features/blog/data/repos/blog_repo.dart';
import 'package:future_app/features/blog/logic/cubit/blog_state.dart';
import 'dart:developer';

class BlogCubit extends Cubit<BlogState> {
  BlogCubit(this._blogRepo) : super(const BlogState.initial());

  final BlogRepo _blogRepo;

  // Local state for posts
  List<PostModel> _posts = [];
  PaginationModel? _pagination;
  PostDetailsModel? _currentPostDetails;
  bool _isLoadingMore = false;

  // Getters
  List<PostModel> get posts => _posts;
  PaginationModel? get pagination => _pagination;
  PostDetailsModel? get currentPostDetails => _currentPostDetails;
  bool get isLoadingMore => _isLoadingMore;

  // Get posts with pagination
  Future<void> getPosts({
    int page = 1,
    int limit = 10,
  }) async {
    log('🚀 BlogCubit: Starting getPosts - page: $page, limit: $limit');
    emit(const BlogState.getPostsLoading());
    final response = await _blogRepo.getPosts(
      page: page,
      limit: limit,
    );
    response.when(
      success: (data) {
        log('✅ BlogCubit: Get posts success - ${data.data.length} posts');
        _posts = data.data;
        _pagination = data.pagination;
        emit(BlogState.getPostsSuccess(data));
      },
      failure: (apiErrorModel) {
        log('❌ BlogCubit: Get posts failed - ${apiErrorModel.message}');
        emit(BlogState.getPostsError(apiErrorModel));
      },
    );
  }

  // Get post details
  Future<void> getPostDetails(String postId) async {
    log('🚀 BlogCubit: Starting getPostDetails for postId: $postId');
    emit(const BlogState.getPostDetailsLoading());
    final response = await _blogRepo.getPostDetails(postId);
    response.when(
      success: (data) {
        log('✅ BlogCubit: Get post details success');
        _currentPostDetails = data.data;
        emit(BlogState.getPostDetailsSuccess(data));
      },
      failure: (apiErrorModel) {
        log('❌ BlogCubit: Get post details failed - ${apiErrorModel.message}');
        emit(BlogState.getPostDetailsError(apiErrorModel));
      },
    );
  }

  // Load more posts (for pagination)
  Future<void> loadMorePosts() async {
    if (_pagination == null || _isLoadingMore) return;

    final currentPage = _pagination!.currentPage;
    final totalPages = _pagination!.totalPages;

    if (currentPage >= totalPages) return;

    _isLoadingMore = true;
    log('🚀 BlogCubit: Loading more posts - page: ${currentPage + 1}');

    final response = await _blogRepo.getPosts(
      page: currentPage + 1,
      limit: _pagination!.perPage,
    );

    response.when(
      success: (data) {
        log('✅ BlogCubit: Load more posts success - ${data.data.length} posts');
        _posts.addAll(data.data);
        _pagination = data.pagination;
        _isLoadingMore = false;
        emit(BlogState.getPostsSuccess(GetPostsResponseModel(
          success: data.success,
          message: data.message,
          data: _posts,
          pagination: _pagination!,
        )));
      },
      failure: (apiErrorModel) {
        log('❌ BlogCubit: Load more posts failed - ${apiErrorModel.message}');
        _isLoadingMore = false;
        emit(BlogState.getPostsError(apiErrorModel));
      },
    );
  }

  // Refresh posts
  Future<void> refresh() async {
    await getPosts(page: 1, limit: 10);
  }
}
