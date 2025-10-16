import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:future_app/core/network/api_error_model.dart';
import 'package:future_app/features/profile/data/models/get_profile_response_model.dart';
import 'package:future_app/features/profile/data/models/update_profile_response_model.dart';
import 'package:future_app/features/profile/data/models/update_password_response_model.dart';

part 'profile_state.freezed.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.initialProfile() = _InitialProfile;

  // get profile
  const factory ProfileState.loadingGetProfile() = LoadingGetProfile;
  const factory ProfileState.successGetProfile(GetProfileResponseModel data) =
      SuccessGetProfile;
  const factory ProfileState.errorGetProfile(ApiErrorModel apiErrorModel) =
      ErrorGetProfile;

  // update profile
  const factory ProfileState.loadingUpdateProfile() = LoadingUpdateProfile;
  const factory ProfileState.successUpdateProfile(
      UpdateProfileResponseModel data) = SuccessUpdateProfile;
  const factory ProfileState.errorUpdateProfile(ApiErrorModel apiErrorModel) =
      ErrorUpdateProfile;

  // update password
  const factory ProfileState.loadingUpdatePassword() = LoadingUpdatePassword;
  const factory ProfileState.successUpdatePassword(
      UpdatePasswordResponseModel data) = SuccessUpdatePassword;
  const factory ProfileState.errorUpdatePassword(ApiErrorModel apiErrorModel) =
      ErrorUpdatePassword;
}
