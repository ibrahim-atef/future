// import 'package:flutter/material.dart';
// import '../core/services/api_service.dart';
// import '../core/models/course_model.dart';
// import '../core/models/lecture_model.dart';
// import '../core/models/quiz_model.dart';

// class CourseProvider extends ChangeNotifier {
//   List<CourseModel> _courses = [];
//   List<CourseModel> _myCourses = [];
//   List<LectureModel> _currentCourseLectures = [];
//   List<QuizModel> _currentCourseQuizzes = [];
//   CourseModel? _currentCourse;
//   bool _isLoading = false;
//   String? _error;
//   int _currentPage = 1;
//   bool _hasMoreCourses = true;

//   List<CourseModel> get courses => _courses;
//   List<CourseModel> get myCourses => _myCourses;
//   List<LectureModel> get currentCourseLectures => _currentCourseLectures;
//   List<QuizModel> get currentCourseQuizzes => _currentCourseQuizzes;
//   CourseModel? get currentCourse => _currentCourse;
//   bool get isLoading => _isLoading;
//   String? get error => _error;
//   bool get hasMoreCourses => _hasMoreCourses;

//   Future<void> loadCourses({bool refresh = false}) async {
//     if (refresh) {
//       _currentPage = 1;
//       _courses.clear();
//       _hasMoreCourses = true;
//     }

//     if (!_hasMoreCourses) return;

//     _setLoading(true);
//     _clearError();

//     try {
//       final response = await ApiService().getCourses(page: _currentPage, limit: 10);

//       if (response.success && response.data != null) {
//         if (refresh) {
//           _courses = response.data!;
//         } else {
//           _courses.addAll(response.data!);
//         }

//         if (response.data!.length < 10) {
//           _hasMoreCourses = false;
//         } else {
//           _currentPage++;
//         }

//         notifyListeners();
//       } else {
//         _setError(response.error ?? 'فشل في تحميل الكورسات');
//       }
//     } catch (e) {
//       _setError('حدث خطأ غير متوقع');
//     } finally {
//       _setLoading(false);
//     }
//   }

//   Future<void> loadCourseDetail(String courseId) async {
//     _setLoading(true);
//     _clearError();

//     try {
//       final response = await ApiService().getCourseDetail(courseId);

//       if (response.success && response.data != null) {
//         _currentCourse = response.data;
//         notifyListeners();
//       } else {
//         _setError(response.error ?? 'فشل في تحميل تفاصيل الكورس');
//       }
//     } catch (e) {
//       _setError('حدث خطأ غير متوقع');
//     } finally {
//       _setLoading(false);
//     }
//   }

//   Future<void> loadCourseContent(String courseId) async {
//     _setLoading(true);
//     _clearError();

//     try {
//       final response = await ApiService().getCourseContent(courseId);

//       if (response.success && response.data != null) {
//         _currentCourseLectures = response.data!;
//         notifyListeners();
//       } else {
//         _setError(response.error ?? 'فشل في تحميل محتوى الكورس');
//       }
//     } catch (e) {
//       _setError('حدث خطأ غير متوقع');
//     } finally {
//       _setLoading(false);
//     }
//   }

//   Future<void> loadCourseQuizzes(String courseId) async {
//     _setLoading(true);
//     _clearError();

//     try {
//       final response = await ApiService().getCourseQuizzes(courseId);

//       if (response.success && response.data != null) {
//         _currentCourseQuizzes = response.data!;
//         notifyListeners();
//       } else {
//         _setError(response.error ?? 'فشل في تحميل اختبارات الكورس');
//       }
//     } catch (e) {
//       _setError('حدث خطأ غير متوقع');
//     } finally {
//       _setLoading(false);
//     }
//   }

//   Future<bool> toggleLearningStatus(String webinarId) async {
//     try {
//       final response = await ApiService().toggleLearningStatus(webinarId);
//       return response.success;
//     } catch (e) {
//       return false;
//     }
//   }

//   Future<bool> reportCourse(String courseId, String reason, String message) async {
//     try {
//       final response = await ApiService().reportCourse(courseId, reason, message);
//       return response.success;
//     } catch (e) {
//       return false;
//     }
//   }

//   Future<List<CourseModel>> searchCourses({String? search, String? categoryId}) async {
//     try {
//       final response = await ApiService().searchCourses(search: search, categoryId: categoryId);

//       if (response.success && response.data != null) {
//         return response.data!;
//       } else {
//         _setError(response.error ?? 'فشل في البحث');
//         return [];
//       }
//     } catch (e) {
//       _setError('حدث خطأ غير متوقع');
//       return [];
//     }
//   }

//   void clearCurrentCourse() {
//     _currentCourse = null;
//     _currentCourseLectures.clear();
//     _currentCourseQuizzes.clear();
//     notifyListeners();
//   }

//   void _setLoading(bool loading) {
//     _isLoading = loading;
//     notifyListeners();
//   }

//   void _setError(String error) {
//     _error = error;
//     notifyListeners();
//   }

//   void _clearError() {
//     _error = null;
//     notifyListeners();
//   }

//   void clearError() {
//     _clearError();
//   }
// }
