import 'package:dio/dio.dart';
import '../constants/app_constants.dart';
import '../models/user_model.dart';
import '../models/course_model.dart';
import '../models/lecture_model.dart';
import '../models/blog_post_model.dart';
import '../models/notification_model.dart';
import '../models/auth_response_model.dart';
import '../models/config_model.dart';
import '../models/quiz_model.dart';
import '../models/cart_model.dart';
import '../models/region_model.dart';
import 'storage_service.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  late Dio _dio;

  void init() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'x-api-key': AppConstants.apiKey,
        'X-App-Source': AppConstants.appSource,
      },
    ));

    // Add interceptors for logging and token management
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      logPrint: (obj) => print(obj.toString()),
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add auth token if available
        final token = _getStoredToken();
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (error, handler) {
        // Handle token expiry and other common errors
        if (error.response?.statusCode == 401) {
          // Token expired, redirect to login
          _handleTokenExpiry();
        }
        handler.next(error);
      },
    ));
  }

  String? _getStoredToken() {
    return StorageService.getToken();
  }

  void _handleTokenExpiry() {
    StorageService.clearToken();
    // TODO: Navigate to login screen
  }

  // ==================== AUTHENTICATION APIs ====================

  Future<ApiResponse<AuthResponseModel>> registerStep1(
      RegisterStep1Request request) async {
    try {
      final response =
          await _dio.post('/register/step/1', data: request.toJson());
      return ApiResponse.success(AuthResponseModel.fromJson(response.data));
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<AuthResponseModel>> registerStep2(
      RegisterStep2Request request) async {
    try {
      final response =
          await _dio.post('/register/step/2', data: request.toJson());
      return ApiResponse.success(AuthResponseModel.fromJson(response.data));
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<AuthResponseModel>> login(LoginRequest request) async {
    try {
      final response = await _dio.post('/login', data: request.toJson());
      final authResponse = AuthResponseModel.fromJson(response.data);

      // Store token if login successful
      if (authResponse.success && authResponse.token != null) {
        StorageService.saveToken(authResponse.token!);
      }

      return ApiResponse.success(authResponse);
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<bool>> logout() async {
    try {
      await _dio.post('/logout');
      StorageService.clearToken();
      return ApiResponse.success(true);
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<bool>> forgotPassword(
      ForgotPasswordRequest request) async {
    try {
      await _dio.post('/forget-password', data: request.toJson());
      return ApiResponse.success(true);
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<bool>> resetPassword(
      String token, ResetPasswordRequest request) async {
    try {
      await _dio.post('/reset-password/$token', data: request.toJson());
      return ApiResponse.success(true);
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<bool>> verifyCode(VerifyCodeRequest request) async {
    try {
      await _dio.post('/verification', data: request.toJson());
      return ApiResponse.success(true);
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  // ==================== CONFIGURATION APIs ====================

  Future<ApiResponse<AppConfig>> getAppConfig() async {
    try {
      final response = await _dio.get('/config');
      return ApiResponse.success(AppConfig.fromJson(response.data));
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<RegisterConfig>> getRegisterConfig(String type) async {
    try {
      final response = await _dio.get('/config/register/$type');
      return ApiResponse.success(RegisterConfig.fromJson(response.data));
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<List<CountryCode>>> getCountriesCode() async {
    try {
      final response = await _dio.get('/regions/countries/code');
      final codes =
          (response.data as List).map((e) => CountryCode.fromJson(e)).toList();
      return ApiResponse.success(codes);
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<List<Currency>>> getCurrencyList() async {
    try {
      final response = await _dio.get('/currency/list');
      final currencies =
          (response.data as List).map((e) => Currency.fromJson(e)).toList();
      return ApiResponse.success(currencies);
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  // ==================== COURSES APIs ====================

  Future<ApiResponse<List<CourseModel>>> getCourses(
      {int page = 1, int limit = 10}) async {
    try {
      final response = await _dio.get('/courses', queryParameters: {
        'page': page,
        'limit': limit,
      });

      final courses = (response.data['data'] as List)
          .map((json) => CourseModel.fromJson(json))
          .toList();

      return ApiResponse.success(courses);
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<CourseModel>> getCourseDetail(String id) async {
    try {
      final response = await _dio.get('/courses/$id');
      return ApiResponse.success(CourseModel.fromJson(response.data));
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<List<LectureModel>>> getCourseContent(String id) async {
    try {
      final response = await _dio.get('/courses/$id/content');

      final lectures = (response.data['lectures'] as List)
          .map((json) => LectureModel.fromJson(json))
          .toList();

      return ApiResponse.success(lectures);
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<List<QuizModel>>> getCourseQuizzes(String id) async {
    try {
      final response = await _dio.get('/courses/$id/quizzes');

      final quizzes = (response.data['quizzes'] as List)
          .map((json) => QuizModel.fromJson(json))
          .toList();

      return ApiResponse.success(quizzes);
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<List<dynamic>>> getCourseCertificates(String id) async {
    try {
      final response = await _dio.get('/courses/$id/certificates');
      return ApiResponse.success(response.data['certificates'] ?? []);
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<bool>> reportCourse(
      String id, String reason, String message) async {
    try {
      await _dio.post('/courses/$id/report', data: {
        'reason': reason,
        'message': message,
      });
      return ApiResponse.success(true);
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<bool>> toggleLearningStatus(String webinarId) async {
    try {
      await _dio.post('/courses/$webinarId/toggle');
      return ApiResponse.success(true);
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  // ==================== USERS & PROVIDERS APIs ====================

  Future<ApiResponse<List<UserModel>>> getInstructors() async {
    try {
      final response = await _dio.get('/providers/instructors');

      final instructors = (response.data['instructors'] as List)
          .map((json) => UserModel.fromJson(json))
          .toList();

      return ApiResponse.success(instructors);
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<List<UserModel>>> getOrganizations() async {
    try {
      final response = await _dio.get('/providers/organizations');

      final organizations = (response.data['organizations'] as List)
          .map((json) => UserModel.fromJson(json))
          .toList();

      return ApiResponse.success(organizations);
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<UserModel>> getUserProfile(String id) async {
    try {
      final response = await _dio.get('/users/$id/profile');
      return ApiResponse.success(UserModel.fromJson(response.data));
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<bool>> sendMessageToUser(String id, String message) async {
    try {
      await _dio.post('/users/$id/send-message', data: {
        'message': message,
      });
      return ApiResponse.success(true);
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  // ==================== PROFILE SETTINGS APIs ====================

  Future<ApiResponse<UserModel>> getProfileSettings() async {
    try {
      final response = await _dio.get('/panel/profile-setting');
      return ApiResponse.success(UserModel.fromJson(response.data));
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<UserModel>> updateProfile(
      Map<String, dynamic> userData) async {
    try {
      final response = await _dio.put('/panel/profile-setting', data: userData);
      return ApiResponse.success(UserModel.fromJson(response.data));
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<bool>> updatePassword(
      Map<String, dynamic> passwordData) async {
    try {
      await _dio.put('/panel/profile-setting/password', data: passwordData);
      return ApiResponse.success(true);
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<bool>> updateProfileImages(FormData formData) async {
    try {
      await _dio.post('/panel/profile-setting/images', data: formData);
      return ApiResponse.success(true);
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<bool>> updateFcmToken(String fcmId) async {
    try {
      await _dio.put('/panel/users/fcm', data: {
        'fcm_id': fcmId,
      });
      return ApiResponse.success(true);
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  // ==================== QUIZZES APIs ====================

  Future<ApiResponse<List<QuizResult>>> getMyQuizResults() async {
    try {
      final response = await _dio.get('/panel/quizzes/results/my-results');

      final results = (response.data['results'] as List)
          .map((json) => QuizResult.fromJson(json))
          .toList();

      return ApiResponse.success(results);
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<QuizModel>> startQuiz(String id) async {
    try {
      final response = await _dio.get('/panel/quizzes/$id/start');
      return ApiResponse.success(QuizModel.fromJson(response.data));
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<QuizResult>> submitQuizResult(
      String id, QuizSubmission submission) async {
    try {
      final response = await _dio.post('/panel/quizzes/$id/store-result',
          data: submission.toJson());
      return ApiResponse.success(QuizResult.fromJson(response.data));
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  // ==================== REGIONS APIs ====================

  Future<ApiResponse<List<Country>>> getCountries() async {
    try {
      final response = await _dio.get('/regions/countries');

      final countries = (response.data['countries'] as List)
          .map((json) => Country.fromJson(json))
          .toList();

      return ApiResponse.success(countries);
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<List<Province>>> getProvinces(String countryId) async {
    try {
      final response = await _dio.get('/regions/provinces/$countryId');

      final provinces = (response.data['provinces'] as List)
          .map((json) => Province.fromJson(json))
          .toList();

      return ApiResponse.success(provinces);
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<List<City>>> getCities(String provinceId) async {
    try {
      final response = await _dio.get('/regions/cities/$provinceId');

      final cities = (response.data['cities'] as List)
          .map((json) => City.fromJson(json))
          .toList();

      return ApiResponse.success(cities);
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<List<District>>> getDistricts(String cityId) async {
    try {
      final response = await _dio.get('/regions/districts/$cityId');

      final districts = (response.data['districts'] as List)
          .map((json) => District.fromJson(json))
          .toList();

      return ApiResponse.success(districts);
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  // ==================== SEARCH APIs ====================

  Future<ApiResponse<List<CourseModel>>> searchCourses(
      {String? search, String? categoryId}) async {
    try {
      final queryParams = <String, dynamic>{};
      if (search != null) queryParams['search'] = search;
      if (categoryId != null) queryParams['category_id'] = categoryId;

      final response =
          await _dio.get('/search/courses', queryParameters: queryParams);

      final courses = (response.data['courses'] as List)
          .map((json) => CourseModel.fromJson(json))
          .toList();

      return ApiResponse.success(courses);
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  // ==================== CART & PURCHASES APIs ====================

  Future<ApiResponse<CartModel>> addToCart(AddToCartRequest request) async {
    try {
      final response =
          await _dio.post('/panel/cart/store', data: request.toJson());
      return ApiResponse.success(CartModel.fromJson(response.data));
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<CouponValidationResponse>> validateCoupon(
      CouponValidationRequest request) async {
    try {
      final response = await _dio.post('/panel/cart/coupon/validate',
          data: request.toJson());
      return ApiResponse.success(
          CouponValidationResponse.fromJson(response.data));
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<CheckoutResponse>> checkout(
      CheckoutRequest request) async {
    try {
      final response =
          await _dio.post('/panel/cart/checkout', data: request.toJson());
      return ApiResponse.success(CheckoutResponse.fromJson(response.data));
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  // ==================== BLOG APIs ====================

  Future<ApiResponse<List<BlogPostModel>>> getBlogPosts() async {
    try {
      final response = await _dio.get('/posts');

      final posts = (response.data['posts'] as List)
          .map((json) => BlogPostModel.fromJson(json))
          .toList();

      return ApiResponse.success(posts);
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  Future<ApiResponse<BlogPostModel>> getBlogPost(String postId) async {
    try {
      final response = await _dio.get('/posts/$postId');
      return ApiResponse.success(BlogPostModel.fromJson(response.data));
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  // ==================== NOTIFICATIONS APIs ====================

  Future<ApiResponse<List<NotificationModel>>> getNotifications(
      String userId) async {
    try {
      final response = await _dio.get('/users/$userId/notifications');

      final notifications = (response.data['notifications'] as List)
          .map((json) => NotificationModel.fromJson(json))
          .toList();

      return ApiResponse.success(notifications);
    } on DioException catch (e) {
      return ApiResponse.error(_handleError(e));
    }
  }

  String _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'انتهت مهلة الاتصال';
      case DioExceptionType.badResponse:
        return error.response?.data['message'] ?? 'حدث خطأ في الخادم';
      case DioExceptionType.cancel:
        return 'تم إلغاء الطلب';
      case DioExceptionType.connectionError:
        return 'خطأ في الاتصال بالإنترنت';
      default:
        return 'حدث خطأ غير متوقع';
    }
  }
}

class ApiResponse<T> {
  final bool success;
  final T? data;
  final String? error;

  ApiResponse.success(this.data)
      : success = true,
        error = null;
  ApiResponse.error(this.error)
      : success = false,
        data = null;
}
