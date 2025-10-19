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
import 'package:future_app/features/blog/data/models/blog_model.dart';
import 'package:future_app/features/profile/data/models/get_profile_response_model.dart';
import 'package:future_app/features/profile/data/models/update_profile_response_model.dart';
import 'package:future_app/features/profile/data/models/update_password_response_model.dart';
import 'package:future_app/features/courses/data/models/quiz_models.dart';
import 'package:future_app/core/models/download_model.dart';
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
    @Query('category_id') int? categoryId,
  );

  // get single course by ID
  @GET('courses/{id}')
  Future<GetSingleCourseResponseModel> getSingleCourse(
    @Path('id') String id,
    @Header('x-api-key') int apiKey,
    @Header('X-App-Source') String appSource,
  );

  // get course content
  @GET('courses/{courseId}/content')
  Future<GetCourseContentResponseModel> getCourseContent(
    @Path('courseId') String courseId,
    @Header('x-api-key') int apiKey,
    @Header('X-App-Source') String appSource,
  );

  // get user notifications
  @GET('users/{user_id}/notifications')
  Future<GetNotificationsResponseModel> getUserNotifications(
    @Path('user_id') String userId,
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

  // get posts with pagination
  @GET(ApiConstants.posts)
  Future<GetPostsResponseModel> getPosts(
    @Header('x-api-key') int apiKey,
    @Header('X-App-Source') String appSource,
    @Query('page') int page,
    @Query('limit') int limit,
  );

  // get single post by ID
  @GET('posts/{postId}')
  Future<GetPostDetailsResponseModel> getPostDetails(
    @Path('postId') String postId,
    @Header('x-api-key') int apiKey,
    @Header('X-App-Source') String appSource,
  );

  // get profile settings
  @GET(ApiConstants.profileSetting)
  Future<GetProfileResponseModel> getProfile(
    @Header('x-api-key') int apiKey,
    @Header('X-App-Source') String appSource,
  );

  // update profile settings
  @PUT(ApiConstants.profileSetting)
  Future<UpdateProfileResponseModel> updateProfile(
    @Body() UpdateProfileRequestModel request,
    @Header('x-api-key') int apiKey,
    @Header('X-App-Source') String appSource,
  );

  // update profile settings with image
  @PUT(ApiConstants.profileSetting)
  Future<UpdateProfileResponseModel> updateProfileWithImage(
    @Body() FormData formData,
    @Header('x-api-key') int apiKey,
    @Header('X-App-Source') String appSource,
  );

  // update password
  @PUT(ApiConstants.updatePassword)
  Future<UpdatePasswordResponseModel> updatePassword(
    @Body() UpdatePasswordRequestModel request,
    @Header('x-api-key') int apiKey,
    @Header('X-App-Source') String appSource,
  );

  // start quiz
  @GET('panel/quizzes/{quizId}/start')
  Future<StartQuizResponseModel> startQuiz(
    @Path('quizId') String quizId,
    @Header('x-api-key') int apiKey,
    @Header('X-App-Source') String appSource,
  );

  // send quiz result
  @POST('panel/quizzes/{quizId}/store-result')
  Future<QuizResultResponseModel> sendQuizResult(
    @Path('quizId') String quizId,
    @Body() QuizResultRequestModel request,
    @Header('x-api-key') int apiKey,
    @Header('X-App-Source') String appSource,
  );

  // download lesson
  @GET('lessons/{lessonId}/download')
  Future<DownloadResponseModel> downloadLesson(
    @Path('lessonId') String lessonId,
    @Header('x-api-key') int apiKey,
    @Header('X-App-Source') String appSource,
  );
}
