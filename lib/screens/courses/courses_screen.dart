import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:async';
import '../../core/routes/app_routes.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentIndex = 0;

  // Banner images for courses
  final List<String> _bannerImages = [
    'assets/images/hero1.jpg',
    'assets/images/hero2.jpg',
    'assets/images/hero3.jpg',
  ];

  @override
  void initState() {
    super.initState();
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
        setState(() {
          _currentIndex = (_currentIndex + 1) % _bannerImages.length;
        });
        _pageController.animateToPage(
          _currentIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFd4af37)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
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

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: 6,
              itemBuilder: (context, index) {
                return _buildCourseCard(context, index);
              },
            ),

            const SizedBox(height: 24),

            // // Description
            // Container(
            //   padding: const EdgeInsets.all(16),
            //   decoration: BoxDecoration(
            //     color: const Color(0xFF2a2a2a),
            //     borderRadius: BorderRadius.circular(12),
            //     border: Border.all(
            //       color: const Color(0xFFd4af37).withOpacity(0.3),
            //       width: 1,
            //     ),
            //   ),
            //   child: const Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         'محتوى الفيديوهات',
            //         style: TextStyle(
            //           color: Color(0xFFd4af37),
            //           fontSize: 16,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       SizedBox(height: 8),
            //       Text(
            //         'جميع الفيديوهات متاحة مجاناً للطلاب المسجلين في المنصة. يمكنك الوصول إلى المحتوى التعليمي في أي وقت ومن أي مكان.',
            //         style: TextStyle(
            //           color: Colors.white70,
            //           fontSize: 14,
            //           height: 1.5,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context, int index) {
    final courses = [
      {
        'title': 'قانون مدني',
        'subtitle': 'أساسيات القانون المدني',
        'type': 'premium'
      },
      {
        'title': 'قانون جنائي',
        'subtitle': 'مبادئ القانون الجنائي',
        'type': 'free'
      },
      {
        'title': 'قانون تجاري',
        'subtitle': 'القوانين التجارية',
        'type': 'premium'
      },
      {'title': 'قانون دستوري', 'subtitle': 'القانون الدستوري', 'type': 'free'},
      {
        'title': 'قانون إداري',
        'subtitle': 'القانون الإداري',
        'type': 'premium'
      },
      {'title': 'قانون دولي', 'subtitle': 'القانون الدولي', 'type': 'free'},
    ];

    final course = courses[index];
    final isPremium = course['type'] == 'premium';

    return GestureDetector(
      onTap: () {
        // Navigate to video player
        Navigator.pushNamed(
          context,
          AppRoutes.lecturePlayer,
          arguments: {
            'courseTitle': course['title'],
            'videoUrl':
                'https://www.youtube.com/watch?v=dQw4w9WgXcQ', // Sample YouTube URL
            'videoType': 'youtube',
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
                          child: const Text(
                            'مميز',
                            style: TextStyle(
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
                      course['title']!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Expanded(
                      child: Text(
                        course['subtitle']!,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Icon(
                          Icons.play_circle,
                          size: 16,
                          color: Color(0xFFd4af37),
                        ),
                        SizedBox(width: 4),
                        Text(
                          '12 محاضرة',
                          style: TextStyle(
                            color: Color(0xFFd4af37),
                            fontSize: 12,
                          ),
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
    );
  }

  Widget _buildBannerCarousel() {
    if (_bannerImages.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: _bannerImages.length,
            allowImplicitScrolling: false,
            itemBuilder: (context, index) {
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
                  child: Image.asset(
                    _bannerImages[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback container with gradient if image fails to load
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
                                'Banner ${index + 1}',
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
                    },
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        // Page Indicators
        if (_bannerImages.isNotEmpty)
          SmoothPageIndicator(
            controller: _pageController,
            count: _bannerImages.length,
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
}
