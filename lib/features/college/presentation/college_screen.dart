import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:async';
import 'package:future_app/core/di/di.dart';
import 'package:future_app/core/routes/app_routes.dart';
import 'package:future_app/core/models/banner_model.dart';
import 'package:future_app/features/college/logic/cubit/college_cubit.dart';
import 'package:future_app/features/college/logic/cubit/college_state.dart';

class CollegeScreen extends StatefulWidget {
  const CollegeScreen({super.key});

  @override
  State<CollegeScreen> createState() => _CollegeScreenState();
}

class _CollegeScreenState extends State<CollegeScreen> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentIndex = 0;
  late final CollegeCubit _collegeCubit;

  @override
  void initState() {
    super.initState();
    _collegeCubit = getIt<CollegeCubit>();
    _collegeCubit.getBanners();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    if (_pageController.hasClients) {
      _pageController.dispose();
    }
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted && _pageController.hasClients) {
        final bannerCount = _getBannerCount();
        if (bannerCount > 0) {
          setState(() {
            _currentIndex = (_currentIndex + 1) % bannerCount;
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

  int _getBannerCount() {
    final banners = _collegeCubit.banners;
    return banners.isNotEmpty ? banners.length : 0;
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
    return BlocProvider.value(
      value: _collegeCubit,
      child: Scaffold(
        backgroundColor: const Color(0xFF1a1a1a),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1a1a1a),
          elevation: 0,
          title: const Text(
            'الكلية - كل حاجة الكلية في مكان واحد',
            style: TextStyle(
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
          color: const Color(0xFFd4af37),
          backgroundColor: const Color(0xFF2a2a2a),
          onRefresh: () async {
            await _collegeCubit.refresh();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner Carousel
                BlocBuilder<CollegeCubit, CollegeState>(
                  builder: (context, state) {
                    return _buildBannerCarousel();
                  },
                ),

                const SizedBox(height: 24),

                // Main Features
                const Text(
                  'الخدمات المتاحة',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                _buildFeatureCard(
                  context,
                  'فيديوهات فيوتشر',
                  'ملخص اسبوع الكلية بطريقتنا',
                  Icons.video_call,
                  () => _navigateToCourseVideos(
                      'future_videos', 'فيديوهات فيوتشر'),
                ),

                const SizedBox(height: 16),

                _buildFeatureCard(
                  context,
                  'الكتب والمذكرات',
                  'تحميل الكتب والمذكرات الدراسية',
                  Icons.description,
                  () => _navigateToCourseVideos(
                      'books_and_notes', 'الكتب والمذكرات'),
                ),

                const SizedBox(height: 16),

                _buildFeatureCard(
                  context,
                  'جداول الشرح والامتحان',
                  'متابعة الجداول الدراسية والامتحانات',
                  Icons.calendar_today,
                  () => _navigateToCourseVideos(
                      'study_and_exam_tables', 'جداول الشرح والامتحان'),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToCourseVideos(String category, String categoryName) {
    Navigator.pushNamed(
      context,
      AppRoutes.courseVideos,
      arguments: {
        'category': category,
        'categoryName': categoryName,
      },
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF2a2a2a),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFd4af37).withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFFd4af37).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 30,
                color: const Color(0xFFd4af37),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFFd4af37),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerCarousel() {
    final banners = _collegeCubit.banners;

    // Show empty state if no banners available
    if (banners.isEmpty) {
      return _buildEmptyBannersState();
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
                  child: banner.imageUrl != null && banner.imageUrl!.isNotEmpty
                      ? Image.network(
                          banner.imageUrl!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return _buildLoadingBanner();
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return _buildFallbackBanner(index, banner);
                          },
                        )
                      : _buildFallbackBanner(index, banner),
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
  }

  Widget _buildLoadingBanner() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFd4af37).withOpacity(0.3),
            const Color(0xFFb8860b).withOpacity(0.3),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFd4af37)),
        ),
      ),
    );
  }

  Widget _buildFallbackBanner(int index, BannerModel banner) {
    return Container(
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
    );
  }

  Widget _buildEmptyBannersState() {
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
}
