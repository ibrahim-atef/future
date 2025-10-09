import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:future_app/core/di/di.dart';
import 'package:future_app/core/helper/bloc_observer.dart';
import 'package:future_app/core/helper/device_info_helper.dart';
import 'package:future_app/core/helper/shared_pref_helper.dart';
import 'package:future_app/core/helper/shared_pref_keys.dart';
import 'package:future_app/features/auth/logic/cubit/auth_cubit.dart';
import 'package:future_app/screens/main/main_navigation_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_routes.dart';
import 'core/services/storage_service.dart';
import 'screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Initialize services
  await StorageService.init();
  // ApiService().init(); // Commented out for MVP - no API calls

  // device id
  UserConstant.deviceId = await DeviceInfoHelper.getDeviceId();
  // Initialize Dependency Injection
  setupGetIt();
  MyBlocObserver();
  await checkIfLoggedInUser();

  runApp(const FutureApp());
}

class FutureApp extends StatelessWidget {
  const FutureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthCubit>()),
      ],
      // providers: [
      //   ChangeNotifierProvider(create: (_) => AuthProvider()),
      //   ChangeNotifierProvider(create: (_) => CourseProvider()),
      //   ChangeNotifierProvider(create: (_) => DownloadProvider()),
      //   ChangeNotifierProvider(create: (_) => SettingsProvider()),
      // ],
      child: MaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,

        // RTL Configuration
        locale: const Locale('ar', 'EG'),
        supportedLocales: const [
          Locale('ar', 'EG'),
          Locale('en', 'US'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        // Force RTL
        builder: (context, child) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          );
        },

        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRoutes.generateRoute,
        home: UserConstant.isLoggedInUser
            ? const MainNavigationScreen()
            : const SplashScreen(),
      ),
    );
  }
}

checkIfLoggedInUser() async {
  String? userToken =
      await SharedPrefHelper.getSecuredString(SharedPrefKeys.userToken);
  UserConstant.userId = await SharedPrefHelper.getString(SharedPrefKeys.userId);
  log('token : $userToken');
  if (userToken == null || userToken == '') {
    UserConstant.isLoggedInUser = false;
  } else {
    UserConstant.isLoggedInUser = true;
  }
}
