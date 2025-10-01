import 'package:dio/dio.dart';
import 'package:future_app/core/network/api_constants.dart';
import 'package:future_app/features/auth/data/models/login_request_model.dart';
import 'package:future_app/features/auth/data/models/login_response_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.apiBaseUrl)
abstract class ApiService {
  factory ApiService(Dio dio, {String? baseUrl}) = _ApiService;

  // login
  @POST(ApiConstants.login)
  Future<LoginResponseModel> login(@Body() LoginRequestModel request);

  // logout
  @POST(ApiConstants.logout)
  Future<void> logout();
}
