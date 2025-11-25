import 'package:future_app/core/helper/shared_pref_helper.dart';
import 'package:future_app/core/helper/shared_pref_keys.dart';
import 'package:future_app/core/network/api_error_model.dart';
import 'package:future_app/core/network/dio_factory.dart';
import 'package:future_app/features/auth/data/models/login_request_model.dart';
import 'package:future_app/features/auth/data/models/register_request_model.dart';
import 'package:future_app/features/auth/data/models/register_response_model.dart';
import 'package:future_app/features/auth/data/models/register_step2_request_model.dart';
import 'package:future_app/features/auth/data/models/register_step2_response_model.dart';
import 'package:future_app/features/auth/data/repos/auth_repo.dart';
import 'package:future_app/features/auth/logic/cubit/auth_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepo) : super(const AuthState.initialAuth());

  final AuthRepo _authRepo;

  // login
  Future login(LoginRequestModel request) async {
    emit(const AuthState.loadingLogin());
    final response = await _authRepo.login(request);
    response.when(success: (data) {
      // Only proceed if data is not null (successful login)
      if (data.data != null) {
        saveUserToken(
            data.data!.token, data.data!.user.id, data.data!.user.fullName);
        emit(AuthState.successLogin(data));
      } else {
        // This shouldn't happen, but handle it just in case
        emit(AuthState.errorLogin(
          ApiErrorModel(message: 'حدث خطأ غير متوقع في تسجيل الدخول'),
        ));
      }
    }, failure: (apiErrorModel) {
      emit(AuthState.errorLogin(apiErrorModel));
    });
  }

  Future<void> saveUserToken(
      String userToken, String userId, String userName) async {
    await SharedPrefHelper.setSecuredString(
      SharedPrefKeys.userToken,
      userToken,
    );
    await SharedPrefHelper.setData(SharedPrefKeys.userId, userId);
    DioFactory.setTokenIntoHeaderAfterLogin(userToken);
    await SharedPrefHelper.setData(SharedPrefKeys.userName, userName);
  }

  // logout
  Future<void> logout() async {
    emit(const AuthState.loadingLogout());
    final response = await _authRepo.logout();
    response.when(success: (_) {
      SharedPrefHelper.clearAllData();
      SharedPrefHelper.clearAllSecuredData();
      UserConstant.userId = null;
      UserConstant.userName = null;
      // Clear headers in DioFactory
      DioFactory.dio?.options.headers.remove('Authorization');
      emit(const AuthState.successLogout());
    }, failure: (apiErrorModel) {
      emit(AuthState.errorLogout(apiErrorModel));
    });
  }

  // register step 1
  Future registerStep1(RegisterRequestModel request) async {
    emit(const AuthState.loadingRegisterStep1());
    final response = await _authRepo.registerStep1(request);
    response.when(success: (RegisterResponseModel data) {
      saveUserToken(
          data.data.token, data.data.user.id, data.data.user.fullName);
      emit(AuthState.successRegisterStep1(data));
    }, failure: (apiErrorModel) {
      emit(AuthState.errorRegisterStep1(apiErrorModel));
    });
  }

  // register step 2
  Future registerStep2(RegisterStep2RequestModel request) async {
    emit(const AuthState.loadingRegisterStep2());
    final response = await _authRepo.registerStep2(request);
    response.when(success: (RegisterStep2ResponseModel data) {
      saveUserToken(
          data.data!.token, data.data!.userId.toString(), data.data!.fullName);
      emit(AuthState.successRegisterStep2(data));
    }, failure: (apiErrorModel) {
      emit(AuthState.errorRegisterStep2(apiErrorModel));
    });
  }
}
