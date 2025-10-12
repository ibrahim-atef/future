import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:future_app/core/di/di.dart';
import 'package:future_app/core/routes/app_routes.dart';
import 'package:future_app/features/courses/data/models/courses_model.dart';
import 'package:future_app/features/college/logic/cubit/college_cubit.dart';
import 'package:future_app/features/college/logic/cubit/college_state.dart';

class CourseVideosScreen extends StatelessWidget {
  final String category;
  final String categoryName;

  const CourseVideosScreen({
    super.key,
    required this.category,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CollegeCubit>()..getCourses(category),
      child: Scaffold(
        backgroundColor: const Color(0xFF1a1a1a),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1a1a1a),
          elevation: 0,
          title: Text(
            categoryName,
            style: const TextStyle(
              color: Color(0xFFd4af37),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFd4af37)),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await context.read<CollegeCubit>().getCourses(category);
          },
          color: const Color(0xFFd4af37),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<CollegeCubit, CollegeState>(
              builder: (context, state) {
                return state.maybeWhen(
                  getCoursesLoading: () => _buildSkeletonGrid(),
                  getCoursesSuccess: (data) {
                    if (data.data.isEmpty) {
                      return _buildEmptyState();
                    }
                    return _buildCoursesGrid(data.data);
                  },
                  getCoursesError: (error) => _buildErrorState(error.message),
                  orElse: () => _buildSkeletonGrid(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonGrid({int itemCount = 6}) {
    return Skeletonizer(
      enabled: true,
      effect: const ShimmerEffect(
        baseColor: Color(0xFF2a2a2a),
        highlightColor: Color(0xFF3a3a3a),
        duration: Duration(seconds: 1),
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return _buildCourseCard(
            CourseModel(
              id: '0',
              title: 'Loading Course Title',
              description: 'Loading description',
              excerpt: '',
              teacherName: 'Loading Teacher',
              teacherId: '0',
              imageUrl: '',
              level: 'مبتدئ',
              language: 'العربية',
              totalHours: 10,
              totalDuration: 600,
              rating: 4.5,
              studentsCount: 100,
              isFree: true,
              price: 0,
              categories: [],
              tags: [],
              status: 'publish',
              createdAt: '2024-01-01',
              updatedAt: '2024-01-01',
            ),
          );
        },
      ),
    );
  }

  Widget _buildCoursesGrid(List<CourseModel> courses) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.75,
      ),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return _buildCourseCard(courses[index]);
      },
    );
  }

  Widget _buildCourseCard(CourseModel course) {
    final isPremium = !course.isFree;

    return Builder(
        builder: (context) => GestureDetector(
              onTap: () {
                // Navigate to course details
                Navigator.pushNamed(
                  context,
                  AppRoutes.courseDetail,
                  arguments: {
                    'courseId': course.id,
                    'courseTitle': course.title,
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isPremium
                      ? const Color(0xFF2a2a2a)
                      : const Color(0xFF1a1a1a),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isPremium
                        ? const Color(0xFFd4af37)
                        : const Color(0xFFd4af37).withOpacity(0.3),
                    width: isPremium ? 2 : 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Course Thumbnail
                    Expanded(
                      flex: 2,
                      child: Container(
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Color(0xFF2a2a2a),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: Stack(
                          children: [
                            if (course.imageUrl.isNotEmpty)
                              CachedNetworkImage(
                                imageUrl: course.imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFd4af37),
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Center(
                                  child: Icon(
                                    Icons.play_circle_outline,
                                    size: 50,
                                    color: Color(0xFFd4af37),
                                  ),
                                ),
                              )
                            else
                              const Center(
                                child: Icon(
                                  Icons.play_circle_outline,
                                  size: 50,
                                  color: Color(0xFFd4af37),
                                ),
                              ),
                            if (isPremium)
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFd4af37),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    course.priceText,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            if (course.isFree)
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'مجاني',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    // Course Info
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              course.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              course.teacherName,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (course.studentsCount > 0)
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.people,
                                        size: 14,
                                        color: Color(0xFFd4af37),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${course.studentsCount}',
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                                if (course.totalHours > 0)
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.access_time,
                                        size: 14,
                                        color: Color(0xFFd4af37),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        course.durationText,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.video_library_outlined,
              size: 80,
              color: const Color(0xFFd4af37).withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              'لا توجد كورسات متاحة',
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: TextStyle(
                color: Colors.white.withOpacity(0.7),
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
