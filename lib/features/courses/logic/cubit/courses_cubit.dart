import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/features/courses/data/models/courses_model.dart';
import 'package:future_app/features/courses/data/repos/courses_repo.dart';
import 'package:future_app/features/courses/logic/cubit/courses_state.dart';
import 'package:future_app/core/models/banner_model.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit(this._coursesRepo) : super(const CoursesState.initial());

  final CoursesRepo _coursesRepo;

  // Banners state
  List<BannerModel> _banners = [];

  // Pagination state
  int _currentPage = 1;
  final int _limit = 10;
  bool _hasMorePages = true;
  bool _isLoadingMore = false;
  List<CourseModel> _allCourses = [];
  PaginationData? _paginationData;

  // Getters
  List<BannerModel> get banners => _banners;
  List<CourseModel> get allCourses => _allCourses;
  PaginationData? get paginationData => _paginationData;
  bool get hasMorePages => _hasMorePages;
  bool get isLoadingMore => _isLoadingMore;
  int get currentPage => _currentPage;

  // Get banners
  Future<void> getBanners() async {
    print('🚀 CoursesCubit: Starting getBanners...');
    emit(const CoursesState.getBannersLoading());
    final response = await _coursesRepo.getBanners();
    response.when(
      success: (data) {
        print(
            '✅ CoursesCubit: Banners success - ${data.data.banners.length} banners');
        _banners = data.data.banners;
        emit(CoursesState.getBannersSuccess(data));
      },
      failure: (apiErrorModel) {
        print('❌ CoursesCubit: Banners failed - ${apiErrorModel.message}');
        emit(CoursesState.getBannersError(apiErrorModel));
      },
    );
  }

  // Get courses (initial load or refresh)
  Future<void> getCourses({bool refresh = false}) async {
    if (refresh) {
      _resetPagination();
    }

    emit(const CoursesState.getCoursesLoading());
    final response = await _coursesRepo.getCourses(
      page: _currentPage,
      limit: _limit,
    );
    response.when(
      success: (data) {
        _allCourses = data.data;
        _paginationData = data.pagination;
        _hasMorePages = data.pagination.hasNextPage;
        emit(CoursesState.getCoursesSuccess(data));
      },
      failure: (apiErrorModel) {
        emit(CoursesState.getCoursesError(apiErrorModel));
      },
    );
  }

  // Load more courses (pagination)
  Future<void> loadMoreCourses() async {
    // Prevent multiple simultaneous loads
    if (_isLoadingMore || !_hasMorePages) {
      return;
    }

    _isLoadingMore = true;
    _currentPage++;

    emit(const CoursesState.loadMoreCoursesLoading());
    final response = await _coursesRepo.getCourses(
      page: _currentPage,
      limit: _limit,
    );
    response.when(
      success: (data) {
        _allCourses.addAll(data.data);
        _paginationData = data.pagination;
        _hasMorePages = data.pagination.hasNextPage;
        _isLoadingMore = false;
        emit(CoursesState.loadMoreCoursesSuccess(data));
      },
      failure: (apiErrorModel) {
        _currentPage--; // Revert page increment on error
        _isLoadingMore = false;
        emit(CoursesState.loadMoreCoursesError(apiErrorModel));
      },
    );
  }

  // Reset pagination state
  void _resetPagination() {
    _currentPage = 1;
    _hasMorePages = true;
    _isLoadingMore = false;
    _allCourses = [];
    _paginationData = null;
  }

  // Public method to reset and reload
  Future<void> refresh() async {
    await getCourses(refresh: true);
  }

  // Get single course by ID
  Future<void> getSingleCourse(String courseId) async {
    emit(const CoursesState.getSingleCourseLoading());
    final response = await _coursesRepo.getSingleCourse(courseId);
    response.when(
      success: (data) {
        emit(CoursesState.getSingleCourseSuccess(data));
      },
      failure: (apiErrorModel) {
        emit(CoursesState.getSingleCourseError(apiErrorModel));
      },
    );
  }

  // Get course content
  Future<void> getCourseContent(String courseId) async {
    emit(const CoursesState.getCourseContentLoading());
    final response = await _coursesRepo.getCourseContent(courseId);
    response.when(
      success: (data) {
        emit(CoursesState.getCourseContentSuccess(data));
      },
      failure: (apiErrorModel) {
        emit(CoursesState.getCourseContentError(apiErrorModel));
      },
    );
  }
}
