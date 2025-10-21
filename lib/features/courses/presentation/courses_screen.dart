import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:async';
import '../../../core/di/di.dart';
import '../../../core/routes/app_routes.dart';
import '../logic/cubit/courses_cubit.dart';
import '../logic/cubit/courses_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../data/models/courses_model.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key, required this.isBackButton});
  final bool isBackButton;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CoursesCubit>()
        ..getBanners()
        ..getCourses(),
      child: _CoursesScreenContent(isBackButton: isBackButton),
    );
  }
}

class _CoursesScreenContent extends StatefulWidget {
  const _CoursesScreenContent({super.key, required this.isBackButton});
  final bool isBackButton;

  @override
  State<_CoursesScreenContent> createState() => _CoursesScreenContentState();
}

class _CoursesScreenContentState extends State<_CoursesScreenContent> {
  final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();
  Timer? _timer;
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _startAutoScroll();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      context.read<CoursesCubit>().loadMoreCourses();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    _scrollController.dispose();
    if (_pageController.hasClients) {
      _pageController.dispose();
    }
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted && _pageController.hasClients) {
        final cubit = context.read<CoursesCubit>();
        final bannersCount = cubit.banners.length;
        if (bannersCount > 0) {
          setState(() {
            _currentIndex = (_currentIndex + 1) % bannersCount;
          });
          _pageController.animateToPage(
            _currentIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  void _onPageChanged(int index) {
    if (mounted) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a1a),
        elevation: 0,
        title: const Text(
          'كورساتي - طريقك للتميز',
          style: TextStyle(
            color: Color(0xFFd4af37),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: widget.isBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFFd4af37)),
                onPressed: () => Navigator.pop(context),
              )
            : const SizedBox.shrink(),
      ),
      body: BlocListener<CoursesCubit, CoursesState>(
        listener: (context, state) {
          state.maybeWhen(
            getCoursesError: (error) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(error.getAllErrorsAsString()),
                  backgroundColor: Colors.red,
                ),
              );
            },
            orElse: () {},
          );
        },
        child: RefreshIndicator(
          onRefresh: () async {
            await context.read<CoursesCubit>().getBanners();
            await context.read<CoursesCubit>().refresh();
          },
          color: const Color(0xFFd4af37),
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner Carousel
                _buildBannerCarousel(),

                const SizedBox(height: 24),

                // Courses Grid
                const Text(
                  'الكورسات المتاحة',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                _buildCoursesGrid(),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCoursesGrid() {
    return BlocBuilder<CoursesCubit, CoursesState>(
      builder: (context, state) {
        final cubit = context.read<CoursesCubit>();
        final courses = cubit.allCourses;
        final isLoading = state is GetCoursesLoading;

        if (isLoading) {
          // Show skeleton loading
          return _buildSkeletonGrid();
        }

        if (courses.isEmpty && !isLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                'لا توجد كورسات متاحة',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ),
          );
        }

        return Column(
          children: [
            GridView.builder(
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
                return _buildCourseCard(context, courses[index]);
              },
            ),
            if (cubit.isLoadingMore)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: _buildSkeletonGrid(itemCount: 2),
              ),
          ],
        );
      },
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
            context,
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

  Widget _buildCourseCard(BuildContext context, course) {
    final isPremium = !course.isFree;

    return GestureDetector(
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
          color: isPremium ? const Color(0xFF2a2a2a) : const Color(0xFF1a1a1a),
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
                        errorWidget: (context, url, error) => const Center(
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
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      course.teacherName,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // const Spacer(),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     if (course.studentsCount > 0)
                    //       Row(
                    //         children: [
                    //           const Icon(
                    //             Icons.people,
                    //             size: 14,
                    //             color: Color(0xFFd4af37),
                    //           ),
                    //           const SizedBox(width: 4),
                    //           Text(
                    //             '${course.studentsCount}',
                    //             style: const TextStyle(
                    //               color: Color(0xFFd4af37),
                    //               fontSize: 11,
                    //             ),
                    //           ),
                    //         ],
                    //       ),
                    //     if (course.level.isNotEmpty)
                    //       Flexible(
                    //         child: Text(
                    //           course.level,
                    //           style: const TextStyle(
                    //             color: Color(0xFFd4af37),
                    //             fontSize: 10,
                    //           ),
                    //           maxLines: 1,
                    //           overflow: TextOverflow.ellipsis,
                    //         ),
                    //       ),
                    //   ],
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerCarousel() {
    return BlocConsumer<CoursesCubit, CoursesState>(
      listener: (context, state) {
        // Debug listener
        state.maybeWhen(
          getBannersSuccess: (data) {
            print('✅ Banners loaded: ${data.data.banners.length} banners');
            print('Banner URLs: ${data.data.banners}');
          },
          getBannersError: (error) {
            print('❌ Banner error: ${error.getAllErrorsAsString()}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'خطأ في تحميل البنرات: ${error.getAllErrorsAsString()}'),
                backgroundColor: Colors.red,
              ),
            );
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        final cubit = context.read<CoursesCubit>();
        final banners = cubit.banners;
        final isLoading = state is GetBannersLoading;

        print(
            '🔍 Building banner: isLoading=$isLoading, bannersCount=${banners.length}');

        if (isLoading) {
          return _buildSkeletonBanner();
        }

        // Show placeholder if no banners
        if (banners.isEmpty && !isLoading) {
          return Container(
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF2a2a2a),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: const Color(0xFFd4af37).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.image_not_supported_outlined,
                    size: 60,
                    color: const Color(0xFFd4af37).withOpacity(0.5),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'لا توجد بنرات متاحه',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Column(
          children: [
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: banners.length,
                allowImplicitScrolling: false,
                itemBuilder: (context, index) {
                  final banner = banners[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFd4af37).withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: banner.imageUrl != null &&
                              banner.imageUrl!.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: banner.imageUrl!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              placeholder: (context, url) => Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color(0xFFd4af37).withOpacity(0.5),
                                      const Color(0xFFb8860b).withOpacity(0.5),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    color: Color(0xFFd4af37),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) {
                                // Fallback container with gradient if image fails to load
                                return Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color(0xFFd4af37)
                                            .withOpacity(0.8),
                                        const Color(0xFFb8860b)
                                            .withOpacity(0.8),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.image,
                                          size: 50,
                                          color: Colors.white.withOpacity(0.8),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          banner.title ?? 'Banner ${index + 1}',
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.8),
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Cairo',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            )
                          : Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    const Color(0xFFd4af37).withOpacity(0.8),
                                    const Color(0xFFb8860b).withOpacity(0.8),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image,
                                      size: 50,
                                      color: Colors.white.withOpacity(0.8),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      banner.title ?? 'Banner ${index + 1}',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Cairo',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            // Page Indicators
            if (banners.isNotEmpty)
              SmoothPageIndicator(
                controller: _pageController,
                count: banners.length,
                effect: WormEffect(
                  activeDotColor: const Color(0xFFd4af37),
                  dotColor: const Color(0xFFd4af37).withOpacity(0.3),
                  dotHeight: 8,
                  dotWidth: 8,
                  spacing: 8,
                  type: WormType.thinUnderground,
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildSkeletonBanner() {
    return Skeletonizer(
      enabled: true,
      effect: const ShimmerEffect(
        baseColor: Color(0xFF2a2a2a),
        highlightColor: Color(0xFF3a3a3a),
        duration: Duration(seconds: 1),
      ),
      child: Column(
        children: [
          Container(
            height: 200,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF2a2a2a),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: Icon(
                Icons.image,
                size: 60,
                color: Colors.white.withOpacity(0.3),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              3,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFF2a2a2a),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
