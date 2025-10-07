import 'package:flutter/material.dart';
import 'package:future_app/screens/downloads/downloads_screen.dart';
import '../home/home_screen.dart';
import '../courses/courses_screen.dart';
import '../college/college_screen.dart';
import '../blog/blog_screen.dart';
import '../profile/profile_screen.dart';
import '../../widgets/common/bottom_navigation.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const CoursesScreen(),
    const CollegeScreen(),
    const BlogScreen(),
    // const ProfileScreen(
    //   inHome: false,
    // ),
    const DownloadsScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
