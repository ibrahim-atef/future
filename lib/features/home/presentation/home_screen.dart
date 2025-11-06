import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/core/helper/shared_pref_helper.dart';
import 'package:future_app/core/helper/shared_pref_keys.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:async';
import 'dart:io';
import '../../../core/constants/app_constants.dart';
import '../../../core/di/di.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/models/banner_model.dart';
import '../logic/cubit/home_cubit.dart';
import '../logic/cubit/home_state.dart';
import '../../auth/logic/cubit/auth_cubit.dart';
import '../../auth/logic/cubit/auth_state.dart';
import '../../profile/logic/cubit/profile_cubit.dart';
import '../../profile/logic/cubit/profile_state.dart';
import '../../notifications/logic/cubit/notifications_cubit.dart';
import '../../notifications/logic/cubit/notifications_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<HomeCubit>()..getBanners()),
        BlocProvider(create: (context) => getIt<AuthCubit>()),
        BlocProvider(create: (context) => getIt<ProfileCubit>()..getProfile()),
        BlocProvider(create: (context) => getIt<NotificationsCubit>()),
      ],
      child: const _HomeScreenContent(),
    );
  }
}

class _HomeScreenContent extends StatefulWidget {
  const _HomeScreenContent();

  @override
  State<_HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<_HomeScreenContent> {
  final PageController _pageController = PageController();
  Timer? _timer;
  int _currentIndex = 0;

  @override
  void initState() {
    _getUserData();
    super.initState();
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

  void _getUserData() async {
    UserConstant.userId =
        await SharedPrefHelper.getString(SharedPrefKeys.userId);
    UserConstant.userName =
        await SharedPrefHelper.getString(SharedPrefKeys.userName);

    // Load notifications after user data is loaded
    if (mounted &&
        UserConstant.userId != null &&
        UserConstant.userId!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          context
              .read<NotificationsCubit>()
              .getUserNotifications(UserConstant.userId!);
        }
      });
    }
  }

  void _startAutoScroll(int bannersCount) {
    if (bannersCount == 0) return;
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted && _pageController.hasClients) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % bannersCount;
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
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        state.whenOrNull(
          errorGetProfile: (error) {
            // Show error message if profile loading fails
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    'خطأ في تحميل البيانات: ${error.getAllErrorsAsString()}'),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 3),
              ),
            );
          },
        );
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF1a1a1a),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1a1a1a),
          elevation: 0,
          title: const Text(
            AppConstants.appName2,
            style: TextStyle(
              color: Color(0xFFd4af37),
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
          centerTitle: true,
          actions: [
            BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) {
                final unreadCount =
                    context.read<NotificationsCubit>().unreadCount;
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    IconButton(
                      onPressed: () async {
                        await Navigator.pushNamed(
                            context, AppRoutes.notifications);
                        // Refresh notifications when returning from notifications screen
                        if (mounted &&
                            UserConstant.userId != null &&
                            UserConstant.userId!.isNotEmpty) {
                          context
                              .read<NotificationsCubit>()
                              .getUserNotifications(UserConstant.userId!);
                        }
                      },
                      icon: const Icon(Icons.notifications),
                      color: const Color(0xFFd4af37),
                      iconSize: 30,
                    ),
                    if (unreadCount > 0)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF1a1a1a),
                              width: 2,
                            ),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 18,
                            minHeight: 18,
                          ),
                          child: Text(
                            unreadCount > 99 ? '99+' : unreadCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            IconButton(
              onPressed: () => _showLogoutDialog(context),
              icon: const Icon(Icons.logout),
              color: const Color(0xFFd4af37),
              iconSize: 30,
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              InkWell(
                onTap: () => Navigator.pushNamed(context, AppRoutes.profile,
                    arguments: true),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFd4af37), Color(0xFFb8860b)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            successGetProfile: (data) {
                              if (data.data.avatar.isNotEmpty) {
                                return CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      NetworkImage(data.data.avatar),
                                  onBackgroundImageError:
                                      (exception, stackTrace) {
                                    // Handle image loading error
                                  },
                                );
                              }
                              return const CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xFFd4af37),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              );
                            },
                            orElse: () => const SizedBox.shrink(),
                          );
                        },
                      ),
                      const SizedBox(width: 10),
                      BlocBuilder<ProfileCubit, ProfileState>(
                        builder: (context, state) {
                          String userName = UserConstant.userName ?? 'بك';

                          state.maybeWhen(
                            successGetProfile: (data) {
                              userName = data.data.fullName.isNotEmpty
                                  ? data.data.fullName
                                  : 'بك';
                            },
                            orElse: () {
                              // Keep the default userName from UserConstant
                            },
                          );

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'مرحباً بك ي $userName',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'كل شيء هنا... معمول علشانك',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 16,
                                  fontFamily: 'Cairo',
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Banner Carousel - Hidden on iOS devices
              if (!Platform.isIOS) ...[
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => const SizedBox.shrink(),
                      getBannerLoading: () => _buildBannerLoading(),
                      getBannerSuccess: (data) {
                        final banners = data.data.banners;
                        if (banners.isEmpty) {
                          return _buildEmptyBanner();
                        }
                        // Start auto-scroll after banners are loaded
                        if (_timer == null) {
                          Future.delayed(Duration.zero, () {
                            _startAutoScroll(banners.length);
                          });
                        }
                        return _buildBannerCarousel(banners);
                      },
                      getBannerError: (error) =>
                          _buildBannerError(error.getAllErrorsAsString()),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],

              // Main Features Grid
              const Text(
                'الأقسام الرئيسية',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
              const SizedBox(height: 16),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
                children: [
                  _buildFeatureCard(
                    context,
                    'الكورسات',
                    () => Navigator.pushNamed(context, AppRoutes.courses,
                        arguments: true),
                    Image.asset(
                      'assets/images/3.png',
                      width: 40,
                      height: 40,
                      color: const Color(0xFFd4af37),
                    ),
                  ),
                  _buildFeatureCard(
                    context,
                    'الكلية',
                    () => Navigator.pushNamed(context, AppRoutes.college,
                        arguments: true),
                    Image.asset(
                      'assets/images/2.png',
                      width: 40,
                      height: 40,
                      color: const Color(0xFFd4af37),
                    ),
                  ),
                  _buildFeatureCard(
                    context,
                    'المدونة',
                    () => Navigator.pushNamed(context, AppRoutes.blog,
                        arguments: true),
                    Image.asset(
                      'assets/images/1.png',
                      width: 40,
                      height: 40,
                      color: const Color(0xFFd4af37),
                    ),
                  ),
                  _buildFeatureCard(
                    context,
                    'تجربة الامتياز',
                    () => Navigator.pushNamed(
                      context,
                      AppRoutes.emtyazScreen,
                    ),
                    Image.asset(
                      'assets/images/4.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // WhatsApp Support Section
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF2a2a2a),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFFd4af37).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'دعم المنصة',
                      style: TextStyle(
                        color: Color(0xFFd4af37),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildWhatsAppButton(
                            'دعم المنصة',
                            'https://wa.me/201001203624',
                            Icons.support_agent,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildWhatsAppButton(
                            'د مينا عيد',
                            'https://wa.me/201556327193',
                            Icons.person,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWhatsAppButton(String title, String url, IconData icon) {
    return GestureDetector(
      onTap: () => _launchWhatsApp(url),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1a1a1a),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFFd4af37).withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: const Color(0xFFd4af37),
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                fontFamily: 'Cairo',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchWhatsApp(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      // Handle error silently
    }
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    VoidCallback onTap,
    Widget image,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF2a2a2a),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFd4af37).withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image,
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Cairo',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerLoading() {
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
      child: const Center(
        child: CircularProgressIndicator(
          color: Color(0xFFd4af37),
        ),
      ),
    );
  }

  Widget _buildEmptyBanner() {
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
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerError(String? message) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF2a2a2a),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.red.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 40,
            ),
            const SizedBox(height: 8),
            Text(
              message ?? 'حدث خطأ في تحميل البانرات',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                fontFamily: 'Cairo',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerCarousel(List<BannerModel> banners) {
    if (banners.isEmpty) {
      return const SizedBox.shrink();
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
                            return Container(
                              color: const Color(0xFF2a2a2a),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: const Color(0xFFd4af37),
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
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
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2a2a2a),
          title: const Text(
            'تسجيل الخروج',
            style: TextStyle(
              color: Color(0xFFd4af37),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'Cairo',
            ),
          ),
          content: const Text(
            'هل أنت متأكد من أنك تريد تسجيل الخروج؟',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: 'Cairo',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'إلغاء',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontFamily: 'Cairo',
                ),
              ),
            ),
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                state.when(
                  initialAuth: () {},
                  loadingLogin: () {},
                  successLogin: (data) {},
                  errorLogin: (error) {},
                  loadingRegisterStep1: () {},
                  successRegisterStep1: (data) {},
                  errorRegisterStep1: (error) {},
                  loadingRegisterStep2: () {},
                  successRegisterStep2: (data) {},
                  errorRegisterStep2: (error) {},
                  loadingLogout: () {
                    // Show loading indicator
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFd4af37),
                        ),
                      ),
                    );
                  },
                  successLogout: () {
                    // Close loading dialog
                    Navigator.of(context).pop();
                    // Close logout confirmation dialog
                    Navigator.of(context).pop();
                    // Navigate to login screen
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.login,
                      (route) => false,
                    );
                  },
                  errorLogout: (error) {
                    // Close loading dialog
                    Navigator.of(context).pop();
                    // Show error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'حدث خطأ في تسجيل الخروج: ${error.getAllErrorsAsString()}',
                          style: const TextStyle(
                            fontFamily: 'Cairo',
                          ),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                );
              },
              child: TextButton(
                onPressed: () {
                  context.read<AuthCubit>().logout();
                },
                child: const Text(
                  'تسجيل الخروج',
                  style: TextStyle(
                    color: Color(0xFFd4af37),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
