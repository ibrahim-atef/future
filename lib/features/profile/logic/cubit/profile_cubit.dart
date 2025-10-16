import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/features/profile/data/repos/profile_repo.dart';
import 'package:future_app/features/profile/data/models/update_profile_response_model.dart';
import 'package:future_app/features/profile/data/models/update_password_response_model.dart';
import 'package:future_app/features/profile/logic/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this._profileRepo) : super(const ProfileState.initialProfile());

  final ProfileRepo _profileRepo;

  // get profile
  Future<void> getProfile() async {
    emit(const ProfileState.loadingGetProfile());
    final response = await _profileRepo.getProfile();
    response.when(
      success: (data) {
        emit(ProfileState.successGetProfile(data));
      },
      failure: (apiErrorModel) {
        emit(ProfileState.errorGetProfile(apiErrorModel));
      },
    );
  }

  // update profile
  Future<void> updateProfile(UpdateProfileRequestModel request) async {
    emit(const ProfileState.loadingUpdateProfile());
    final response = await _profileRepo.updateProfile(request);
    response.when(
      success: (data) {
        emit(ProfileState.successUpdateProfile(data));
      },
      failure: (apiErrorModel) {
        emit(ProfileState.errorUpdateProfile(apiErrorModel));
      },
    );
  }

  // update password
  Future<void> updatePassword(UpdatePasswordRequestModel request) async {
    emit(const ProfileState.loadingUpdatePassword());
    final response = await _profileRepo.updatePassword(request);
    response.when(
      success: (data) {
        emit(ProfileState.successUpdatePassword(data));
      },
      failure: (apiErrorModel) {
        emit(ProfileState.errorUpdatePassword(apiErrorModel));
      },
    );
  }
}
