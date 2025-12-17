import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/core/di/di.dart';
import 'package:future_app/features/downloads/presentation/offline_list_course_page.dart';
import 'package:future_app/features/downloads/logic/cubit/download_cubit.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/courses/presentation/courses_screen.dart';
import '../../features/college/presentation/college_screen.dart';
import '../../features/blog/presentation/blog_screen.dart';
import '../../features/blog/logic/cubit/blog_cubit.dart';
import '../../widgets/common/bottom_navigation.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  List<Widget> _buildScreens(BuildContext context) {
    return [
      const HomeScreen(),
      const CoursesScreen(
        isBackButton: false,
      ),
      const CollegeScreen(
        isBackButton: false,
      ),
      BlocProvider(
        create: (context) => getIt<BlogCubit>()
          ..getPosts(page: 1, limit: 10)
          ..getCategories(),
        child: const BlogScreen(
          isBackButton: false,
        ),
      ),
      const OfflineListCoursePage(
        isBackButton: false,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<DownloadCubit>()),
      ],
      child: Scaffold(
        body: _buildScreens(context)[_currentIndex],
        bottomNavigationBar: BottomNavigation(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
