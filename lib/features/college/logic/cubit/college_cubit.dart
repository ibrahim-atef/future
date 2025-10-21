import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/core/models/banner_model.dart';
import 'package:future_app/features/courses/data/models/courses_model.dart';
import 'package:future_app/features/college/data/repos/college_repo.dart';
import 'package:future_app/features/college/logic/cubit/college_state.dart';
import 'dart:developer';

class CollegeCubit extends Cubit<CollegeState> {
  CollegeCubit(this._collegeRepo) : super(const CollegeState.initial());

  final CollegeRepo _collegeRepo;

  // Local state for banners
  BannerResponseModel? _bannerResponse;
  List<BannerModel> get banners => _bannerResponse?.data.banners ?? [];

  // Local state for courses by category
  final Map<int, List<CourseModel>> _coursesByCategory = {};
  List<CourseModel>? getCoursesByCategory(int category) =>
      _coursesByCategory[category];

  // Get college banners
  Future<void> getBanners() async {
    log('🚀 CollegeCubit: Starting getBanners');
    emit(const CollegeState.getBannersLoading());
    final response = await _collegeRepo.getBanners();
    response.when(
      success: (data) {
        log('✅ CollegeCubit: Get banners success - ${data.data.banners.length} banners');
        _bannerResponse = data;
        emit(CollegeState.getBannersSuccess(data));
      },
      failure: (apiErrorModel) {
        log('❌ CollegeCubit: Get banners failed - ${apiErrorModel.message}');
        emit(CollegeState.getBannersError(apiErrorModel));
      },
    );
  }

  // Get college courses by category
  /*
فيديوهات فيوتشر
GET /courses?category_id=22

الكتب والملاحظات
GET /courses?category_id=23

جداول الدراسة والامتحانات
GET /courses?category_id=24

  */

  Future<void> getCourses(int? categoryId, int filtersLevels) async {
    log('🚀 CollegeCubit: Starting getCourses for category: $categoryId');
    emit(const CollegeState.getCoursesLoading());
    final response = await _collegeRepo.getCourses(
        categoryId: categoryId, filtersLevels: filtersLevels);
    response.when(
      success: (data) {
        log('✅ CollegeCubit: Get courses success - ${data.data.length} courses');
        // _coursesByCategory[category] = data.data;
        emit(CollegeState.getCoursesSuccess(data));
      },
      failure: (apiErrorModel) {
        log('❌ CollegeCubit: Get courses failed - ${apiErrorModel.message}');
        emit(CollegeState.getCoursesError(apiErrorModel));
      },
    );
  }

  // Refresh data
  Future<void> refresh() async {
    await getBanners();
  }
}
