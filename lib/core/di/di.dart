import 'package:dio/dio.dart';
import 'package:future_app/core/network/api_service.dart';
import 'package:future_app/core/network/dio_factory.dart';
import 'package:future_app/features/auth/data/repos/auth_repo.dart';
import 'package:future_app/features/auth/logic/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // dio and api service
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton(() => ApiService(dio));

  // auth
  getIt.registerLazySingleton(() => AuthRepo(getIt()));
  getIt.registerFactory(() => AuthCubit(getIt()));
}
