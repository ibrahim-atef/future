import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/features/profile/data/repos/profile_repo.dart';
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
}
