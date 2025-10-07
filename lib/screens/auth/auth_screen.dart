import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/routes/app_routes.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 60),

              // Logo and Title
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xFFd4af37),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFd4af37).withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.school,
                        size: 50,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      'فيوتشر',
                      style: TextStyle(
                        color: Color(0xFFd4af37),
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'كل شيء هنا... معمول علشانك',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 80),

              // Auth Buttons
              _buildAuthButton(
                context,
                'تسجيل الدخول',
                Icons.login,
                () => Navigator.pushNamed(context, '/login-form'),
              ),

              const SizedBox(height: 16),

              _buildAuthButton(
                context,
                'إنشاء حساب جديد',
                Icons.person_add,
                () => Navigator.pushNamed(context, '/register-form'),
              ),

              const SizedBox(height: 40),

              // Skip Button
              // TextButton(
              //   onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.home),
              //   child: const Text(
              //     'تخطي - الدخول كزائر',
              //     style: TextStyle(
              //       color: Color(0xFFd4af37),
              //       fontSize: 16,
              //       fontWeight: FontWeight.w600,
              //     ),
              //   ),
              // ),

              const SizedBox(height: 40),

              // Support Section
              // Container(
              //   padding: const EdgeInsets.all(20),
              //   decoration: BoxDecoration(
              //     color: const Color(0xFF2a2a2a),
              //     borderRadius: BorderRadius.circular(16),
              //     border: Border.all(
              //       color: const Color(0xFFd4af37).withOpacity(0.3),
              //       width: 1,
              //     ),
              //   ),
              //   child: Column(
              //     children: [
              //       const Text(
              //         'دعم المنصة',
              //         style: TextStyle(
              //           color: Color(0xFFd4af37),
              //           fontSize: 18,
              //           fontWeight: FontWeight.bold,
              //         ),
              //       ),
              //       const SizedBox(height: 16),
              //       Row(
              //         children: [
              //           Expanded(
              //             child: _buildWhatsAppButton(
              //               'دعم المنصة',
              //               'https://wa.me/201234567890',
              //               Icons.support_agent,
              //             ),
              //           ),
              //           const SizedBox(width: 12),
              //           Expanded(
              //             child: _buildWhatsAppButton(
              //               'مينا دعاء',
              //               'https://wa.me/201234567891',
              //               Icons.person,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAuthButton(
    BuildContext context,
    String text,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 24),
        label: Text(
          text,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFd4af37),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 0,
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
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2a2a2a),
        title: const Text(
          'قريباً',
          style: TextStyle(
            color: Color(0xFFd4af37),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          '$feature سيكون متاحاً قريباً في التحديثات القادمة',
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'موافق',
              style: TextStyle(
                color: Color(0xFFd4af37),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
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
}
