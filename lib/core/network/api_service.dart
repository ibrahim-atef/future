import 'package:dio/dio.dart';
import 'package:future_app/core/models/banner_model.dart';
import 'package:future_app/core/network/api_constants.dart';
import 'package:future_app/features/auth/data/models/login_request_model.dart';
import 'package:future_app/features/auth/data/models/login_response_model.dart';
import 'package:future_app/features/auth/data/models/register_request_model.dart';
import 'package:future_app/features/auth/data/models/register_response_model.dart';
import 'package:future_app/features/auth/data/models/register_step2_request_model.dart';
import 'package:future_app/features/auth/data/models/register_step2_response_model.dart';
import 'package:future_app/features/courses/data/models/courses_model.dart';
import 'package:future_app/features/notifications/data/models/notifications_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) = _ApiService;

  // login
  @POST(ApiConstants.login)
  Future<LoginResponseModel> login(
    @Body() LoginRequestModel request,
    @Header('x-api-key') int apiKey,
    @Header('X-App-Source') String appSource,
  );

  // logout
  @POST(ApiConstants.logout)
  Future<void> logout(
    @Header('x-api-key') int apiKey,
    @Header('X-App-Source') String appSource,
  );

  // register step 1
  @POST(ApiConstants.registerStep1)
  Future<RegisterResponseModel> registerStep1(
    @Body() RegisterRequestModel request,
    @Header('x-api-key') int apiKey,
    @Header('X-App-Source') String appSource,
  );

  // register step 2
  @POST(ApiConstants.registerStep2)
  Future<RegisterStep2ResponseModel> registerStep2(
    @Body() RegisterStep2RequestModel request,
    @Header('x-api-key') int apiKey,
    @Header('X-App-Source') String appSource,
  );

  // get banners
  @GET(ApiConstants.banners)
  Future<BannerResponseModel> getBanners(
    @Header('x-api-key') int apiKey,
    @Header('X-App-Source') String appSource,
  );

  // get courses with pagination
  @GET(ApiConstants.courses)
  Future<GetCoursesResponseModel> getCourses(
    @Header('x-api-key') int apiKey,
    @Header('X-App-Source') String appSource,
    @Query('page') int page,
    @Query('limit') int limit,
  );

  // get single course by ID
  @GET('courses/{id}')
  Future<GetSingleCourseResponseModel> getSingleCourse(
    @Path('id') String id,
    @Header('x-api-key') int apiKey,
    @Header('X-App-Source') String appSource,
  );

  // get user notifications
  @GET('users/{userId}/notifications')
  Future<GetNotificationsResponseModel> getUserNotifications(
    @Path('userId') String userId,
    @Header('x-api-key') int apiKey,
    @Header('X-App-Source') String appSource,
  );

  // mark notification as read
  @POST('notifications/{notificationId}/read')
  Future<MarkNotificationReadResponseModel> markNotificationAsRead(
    @Path('notificationId') String notificationId,
    @Header('x-api-key') int apiKey,
    @Header('X-App-Source') String appSource,
  );

  // delete notification
  @DELETE('notifications/{notificationId}')
  Future<DeleteNotificationResponseModel> deleteNotification(
    @Path('notificationId') String notificationId,
    @Header('x-api-key') int apiKey,
    @Header('X-App-Source') String appSource,
  );
}
