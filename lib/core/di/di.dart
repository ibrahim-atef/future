import 'package:dio/dio.dart';
import 'package:future_app/core/network/api_service.dart';
import 'package:future_app/core/network/dio_factory.dart';
import 'package:future_app/features/auth/data/repos/auth_repo.dart';
import 'package:future_app/features/auth/logic/cubit/auth_cubit.dart';
import 'package:future_app/features/home/data/repos/home_repo.dart';
import 'package:future_app/features/home/logic/cubit/home_cubit.dart';
import 'package:future_app/features/courses/data/repos/courses_repo.dart';
import 'package:future_app/features/courses/logic/cubit/courses_cubit.dart';
import 'package:future_app/features/notifications/data/repos/notifications_repo.dart';
import 'package:future_app/features/notifications/logic/cubit/notifications_cubit.dart';
import 'package:future_app/features/blog/data/repos/blog_repo.dart';
import 'package:future_app/features/blog/logic/cubit/blog_cubit.dart';
import 'package:future_app/features/college/data/repos/college_repo.dart';
import 'package:future_app/features/college/logic/cubit/college_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // dio and api service
  Dio dio = DioFactory.getDio();
  getIt.registerLazySingleton(() => ApiService(dio));

  // auth
  getIt.registerLazySingleton(() => AuthRepo(getIt()));
  getIt.registerFactory(() => AuthCubit(getIt()));

  // home
  getIt.registerLazySingleton(() => HomeRepo(getIt()));
  getIt.registerFactory(() => HomeCubit(getIt()));

  // courses
  getIt.registerLazySingleton(() => CoursesRepo(getIt()));
  getIt.registerFactory(() => CoursesCubit(getIt()));

  // notifications
  getIt.registerLazySingleton(() => NotificationsRepo(getIt()));
  getIt.registerFactory(() => NotificationsCubit(getIt()));

  // blog
  getIt.registerLazySingleton(() => BlogRepo(getIt()));
  getIt.registerFactory(() => BlogCubit(getIt()));

  // college
  getIt.registerLazySingleton(() => CollegeRepo(getIt()));
  getIt.registerFactory(() => CollegeCubit(getIt()));
}
