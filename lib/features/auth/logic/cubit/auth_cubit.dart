import 'package:future_app/core/helper/shared_pref_helper.dart';
import 'package:future_app/core/helper/shared_pref_keys.dart';
import 'package:future_app/core/network/dio_factory.dart';
import 'package:future_app/features/auth/data/models/login_request_model.dart';
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
      saveUserToken(data.data.token);
      emit(AuthState.successLogin(data));
    }, failure: (apiErrorModel) {
      emit(AuthState.errorLogin(apiErrorModel));
    });
  }

  Future<void> saveUserToken(String userToken) async {
    await SharedPrefHelper.setSecuredString(
      SharedPrefKeys.userToken,
      userToken,
    );
    DioFactory.setTokenIntoHeaderAfterLogin(userToken);
  }

  // logout
  Future<void> logout() async {
    emit(const AuthState.loadingLogout());
    final response = await _authRepo.logout();
    response.when(success: (_) {
      SharedPrefHelper.clearAllData();
      SharedPrefHelper.clearAllSecuredData();
      emit(const AuthState.successLogout());
    }, failure: (apiErrorModel) {
      emit(AuthState.errorLogout(apiErrorModel));
    });
  }
}
