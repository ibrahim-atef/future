import 'package:flutter/material.dart';
import '../../screens/splash/splash_screen.dart';
import '../../screens/auth/auth_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../screens/auth/register_screen.dart';
import '../../screens/auth/forgot_password_screen.dart';
import '../../screens/auth/verify_code_screen.dart';
import '../../screens/main/main_navigation_screen.dart';
import '../../screens/courses/courses_screen.dart';
import '../../screens/courses/course_detail_screen.dart';
import '../../screens/courses/lecture_player_screen.dart';
import '../../screens/downloads/downloads_screen.dart';
import '../../screens/college/college_screen.dart';
import '../../screens/blog/blog_screen.dart';
import '../../screens/blog/blog_detail_screen.dart';
import '../../screens/notifications/notifications_screen.dart';
import '../../screens/profile/profile_screen.dart';
import '../../screens/profile/edit_profile_screen.dart';
import '../../screens/profile/settings_screen.dart';
import '../../screens/quiz/quiz_screen.dart';
import '../../screens/quiz/quiz_result_screen.dart';

class AppRoutes {
  // Route names
  static const String splash = '/';
  static const String login = '/login';
  static const String loginForm = '/login-form';
  static const String register = '/register';
  static const String registerForm = '/register-form';
  static const String forgotPassword = '/forgot-password';
  static const String verifyCode = '/verify-code';
  static const String home = '/home';
  static const String courses = '/courses';
  static const String courseDetail = '/course-detail';
  static const String lecturePlayer = '/lecture-player';
  static const String downloads = '/downloads';
  static const String college = '/college';
  static const String blog = '/blog';
  static const String blogDetail = '/blog-detail';
  static const String notifications = '/notifications';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String settings = '/settings';
  static const String quiz = '/quiz';
  static const String quizResult = '/quiz-result';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );

      case login:
        return MaterialPageRoute(
          builder: (_) => const AuthScreen(),
          settings: settings,
        );

      case loginForm:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );

      case register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
          settings: settings,
        );

      case registerForm:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
          settings: settings,
        );

      case forgotPassword:
        return MaterialPageRoute(
          builder: (_) => const ForgotPasswordScreen(),
          settings: settings,
        );

      case verifyCode:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => VerifyCodeScreen(
            email: args?['email'] ?? '',
            type: args?['type'] ?? 'register',
          ),
          settings: settings,
        );

      case home:
        return MaterialPageRoute(
          builder: (_) => const MainNavigationScreen(),
          settings: settings,
        );

      case courses:
        return MaterialPageRoute(
          builder: (_) => const CoursesScreen(),
          settings: settings,
        );

      case courseDetail:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => CourseDetailScreen(
            courseId: args?['courseId'] ?? '',
            courseTitle: args?['courseTitle'] ?? '',
          ),
          settings: settings,
        );

      case lecturePlayer:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => LecturePlayerScreen(
            courseTitle: args?['courseTitle'] ?? '',
            videoUrl: args?['videoUrl'] ?? '',
            videoType: args?['videoType'] ?? 'youtube',
          ),
          settings: settings,
        );

      case downloads:
        return MaterialPageRoute(
          builder: (_) => const DownloadsScreen(),
          settings: settings,
        );

      case college:
        return MaterialPageRoute(
          builder: (_) => const CollegeScreen(),
          settings: settings,
        );

      case blog:
        return MaterialPageRoute(
          builder: (_) => const BlogScreen(),
          settings: settings,
        );

      case blogDetail:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => BlogDetailScreen(
            postId: args?['postId'] ?? '',
            postTitle: args?['postTitle'] ?? '',
          ),
          settings: settings,
        );

      case notifications:
        return MaterialPageRoute(
          builder: (_) => const NotificationsScreen(),
          settings: settings,
        );

      case profile:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
          settings: settings,
        );

      case editProfile:
        return MaterialPageRoute(
          builder: (_) => const EditProfileScreen(),
          settings: settings,
        );

      case AppRoutes.settings:
        return MaterialPageRoute(
          builder: (_) => const SettingsScreen(),
          settings: settings,
        );

      case quiz:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => QuizScreen(
            quizId: args?['quizId'] ?? '',
            quizTitle: args?['quizTitle'] ?? '',
          ),
          settings: settings,
        );

      case quizResult:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => QuizResultScreen(
            result: args?['result'],
          ),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('الصفحة غير موجودة'),
            ),
          ),
          settings: settings,
        );
    }
  }
}
