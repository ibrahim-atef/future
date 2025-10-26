import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:future_app/core/network/api_error_model.dart';
import 'package:future_app/core/models/banner_model.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;

  // get banners
  const factory HomeState.getBannerLoading() = GetBannerLoading;
  const factory HomeState.getBannerSuccess(BannerResponseModel data) =
      GetBannerSuccess;
  const factory HomeState.getBannerError(ApiErrorModel apiErrorModel) =
      GetBannerError;
}

