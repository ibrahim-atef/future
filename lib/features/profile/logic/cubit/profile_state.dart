import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:future_app/core/network/api_error_model.dart';
import 'package:future_app/features/profile/data/models/get_profile_response_model.dart';

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
}
