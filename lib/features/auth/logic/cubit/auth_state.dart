import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:future_app/core/network/api_error_model.dart';
import 'package:future_app/features/auth/data/models/login_response_model.dart';
part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initialAuth() = _InitialAuth;

  // login
  const factory AuthState.loadingLogin() = LoadingLogin;
  const factory AuthState.successLogin(LoginResponseModel data) = SuccessLogin;
  const factory AuthState.errorLogin(ApiErrorModel apiErrorModel) = ErrorLogin;
}
