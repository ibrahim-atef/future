import 'package:dio/dio.dart';
import 'package:future_app/core/helper/shared_pref_helper.dart';
import 'package:future_app/core/helper/shared_pref_keys.dart';
import 'package:future_app/core/network/api_constants.dart';
import 'dart:convert';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  /// private constructor as I don't want to allow creating an instance of this class
  DioFactory._();

  static Dio? dio;

  static Dio getDio() {
    Duration timeOut = const Duration(seconds: 30);

    if (dio == null) {
      dio = Dio();
      dio!
        ..options.connectTimeout = timeOut
        ..options.receiveTimeout = timeOut;

      addDioHeaders();
      addDioInterceptor();
      return dio!;
    } else {
      return dio!;
    }
  }

  static void addDioHeaders() async {
    dio?.options.headers = {
      'x-api-key': ApiConstants.apiKey,
      'Authorization':
          'Bearer ${await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken)}',
    };
  }

  static void setTokenIntoHeaderAfterLogin(String token) {
    dio?.options.headers = {
      'Authorization': 'Bearer $token',
      'x-api-key': ApiConstants.apiKey,
    };
  }

  static void addDioInterceptor() {
    dio?.interceptors.add(
      PrettyDioLogger(
        requestBody: true,
        requestHeader: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        compact: false,
        maxWidth: 90,
      ),
    );

    // Add custom response body logger
    dio?.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          print('\n╔══════════════════════════════════════════════════════════════════════════════════════════╗');
          print('║ Response Body');
          print('╚══════════════════════════════════════════════════════════════════════════════════════════╝');
          try {
            if (response.data != null) {
              if (response.data is String) {
                print(response.data);
              } else {
                final jsonString = const JsonEncoder.withIndent('  ').convert(response.data);
                print(jsonString);
              }
            } else {
              print('Response body is null');
            }
          } catch (e) {
            print('Error printing response body: $e');
            print('Raw response: ${response.data}');
          }
          print('\n');
          handler.next(response);
        },
      ),
    );

    // Add auth token interceptor
    dio?.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Get the stored token
          String? token =
              await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (error, handler) {
          // Handle token expiry
          if (error.response?.statusCode == 401) {
            // Token expired, clear stored data and redirect to login
            _handleTokenExpiry();
          }
          handler.next(error);
        },
      ),
    );
  }

  static void _handleTokenExpiry() async {
    // Clear stored token and user data
    await SharedPrefHelper.setSecuredString(SharedPrefKeys.userToken, '');
    await SharedPrefHelper.setData(SharedPrefKeys.userId, '');
    await SharedPrefHelper.setData(SharedPrefKeys.userName, '');

    // Clear headers
    dio?.options.headers.remove('Authorization');
  }
}
