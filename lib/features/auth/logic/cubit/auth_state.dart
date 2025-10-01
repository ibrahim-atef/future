import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:future_app/core/network/api_error_model.dart';
import 'package:future_app/features/auth/data/models/login_response_model.dart';
import 'package:future_app/features/auth/data/models/register_response_model.dart';
part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initialAuth() = _InitialAuth;

  // login
  const factory AuthState.loadingLogin() = LoadingLogin;
  const factory AuthState.successLogin(LoginResponseModel data) = SuccessLogin;
  const factory AuthState.errorLogin(ApiErrorModel apiErrorModel) = ErrorLogin;

  // logout
  const factory AuthState.loadingLogout() = LoadingLogout;
  const factory AuthState.successLogout() = SuccessLogout;
  const factory AuthState.errorLogout(ApiErrorModel apiErrorModel) =
      ErrorLogout;

  // register step 1
  const factory AuthState.loadingRegisterStep1() = LoadingRegisterStep1;
  const factory AuthState.successRegisterStep1(RegisterResponseModel data) =
      SuccessRegisterStep1;
  const factory AuthState.errorRegisterStep1(ApiErrorModel apiErrorModel) =
      ErrorRegisterStep1;
}
