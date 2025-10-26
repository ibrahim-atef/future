import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/features/home/data/repos/home_repo.dart';
import 'package:future_app/features/home/logic/cubit/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._homeRepo) : super(const HomeState.initial());

  final HomeRepo _homeRepo;

  // get banners
  Future<void> getBanners() async {
    emit(const HomeState.getBannerLoading());
    final response = await _homeRepo.getBanners();
    response.when(
      success: (data) {
        emit(HomeState.getBannerSuccess(data));
      },
      failure: (apiErrorModel) {
        emit(HomeState.getBannerError(apiErrorModel));
      },
    );
  }
}

