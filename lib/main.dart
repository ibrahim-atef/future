import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:future_app/core/di/di.dart';
import 'package:future_app/core/helper/bloc_observer.dart';
import 'package:future_app/core/helper/device_info_helper.dart';
import 'package:future_app/core/helper/shared_pref_helper.dart';
import 'package:future_app/core/helper/shared_pref_keys.dart';
import 'package:future_app/core/network/dio_factory.dart';
import 'package:future_app/features/auth/logic/cubit/auth_cubit.dart';
import 'package:future_app/features/downloads/logic/cubit/download_cubit.dart';
import 'package:future_app/screens/main/main_navigation_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_routes.dart';
import 'core/services/storage_service.dart';
import 'screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/notification/notification_service.dart';
import 'package:future_app/features/downloads/data/service/download_service.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:screen_protector/screen_protector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Hive
  await Hive.initFlutter();

  // Initialize services
  await StorageService.init();

  // Initialize Firebase Notifications
  await FirebaseNotification.initializeNotifications();

  // Initialize WorkManager for flutter_downloader
  await Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: false,
  );

  // Wait a bit for WorkManager to be ready
  await Future.delayed(const Duration(milliseconds: 500));

  // Initialize flutter_downloader
  await FlutterDownloader.initialize(
    debug: true,
    ignoreSsl: true,
  );

  // Initialize Download Service
  await DownloadService().initialize();

  // Initialize Screen Protector
  await _initializeScreenProtector();

  // device id
  UserConstant.deviceId = await DeviceInfoHelper.getDeviceId();
  // Initialize Dependency Injection
  setupGetIt();
  MyBlocObserver();
  await checkIfLoggedInUser();

  runApp(const FutureApp());
}

/// Initialize screen protection on Android/iOS
Future<void> _initializeScreenProtector() async {
  try {
    if (defaultTargetPlatform == TargetPlatform.android) {
      debugPrint('🛡️ Enabling Android screen protection...');
      await ScreenProtector.protectDataLeakageOn();
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      debugPrint('🛡️ Enabling iOS screenshot prevention...');
      await ScreenProtector.preventScreenshotOn();
    }
  } catch (e) {
    debugPrint('❌ ScreenProtector init error: $e');
  }
}

class FutureApp extends StatefulWidget {
  const FutureApp({super.key});

  @override
  State<FutureApp> createState() => _FutureAppState();
}

class _FutureAppState extends State<FutureApp> {
  @override
  void dispose() {
    // Disable screen protection when leaving
    if (defaultTargetPlatform == TargetPlatform.android) {
      ScreenProtector.protectDataLeakageOff();
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      ScreenProtector.preventScreenshotOff();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<AuthCubit>()),
        BlocProvider(create: (_) => getIt<DownloadCubit>()),
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
  UserConstant.userName =
      await SharedPrefHelper.getString(SharedPrefKeys.userName);
  log('token : $userToken');
  if (userToken == null || userToken == '') {
    UserConstant.isLoggedInUser = false;
  } else {
    UserConstant.isLoggedInUser = true;
    // Set token in headers if user is already logged in
    DioFactory.setTokenIntoHeaderAfterLogin(userToken);
  }
}

// Callback dispatcher for WorkManager
@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    // This is where you can handle background tasks
    // For flutter_downloader, this is automatically handled
    return Future.value(true);
  });
}
