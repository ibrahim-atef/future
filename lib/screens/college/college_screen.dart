import 'package:flutter/material.dart';

class CollegeScreen extends StatelessWidget {
  const CollegeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Color(0xFF2a2a2a), Color(0xFF1a1a1a)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: const Color(0xFFd4af37).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: 20,
                    top: 20,
                    child: Icon(
                      Icons.school,
                      size: 60,
                      color: const Color(0xFFd4af37).withOpacity(0.3),
                    ),
                  ),
                  const Positioned(
                    left: 20,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'الكلية',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'كل حاجة الكلية في مكان واحد',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
              'تسجيلات الكلية',
              'استمع إلى تسجيلات المحاضرات والندوات',
              Icons.mic,
              () => _showFeatureDialog(context, 'تسجيلات الكلية',
                  'يمكنك الوصول إلى جميع تسجيلات المحاضرات والندوات من خلال هذا القسم.'),
            ),

            const SizedBox(height: 16),

            _buildFeatureCard(
              context,
              'الكتب والمذكرات',
              'تحميل الكتب والمذكرات الدراسية',
              Icons.description,
              () => _showFeatureDialog(context, 'الكتب والمذكرات',
                  'جميع الكتب والمذكرات الدراسية متاحة للتحميل من خلال هذا القسم.'),
            ),

            const SizedBox(height: 16),

            _buildFeatureCard(
              context,
              'جداول الشرح والامتحان',
              'متابعة الجداول الدراسية والامتحانات',
              Icons.calendar_today,
              () => _showFeatureDialog(context, 'جداول الشرح والامتحان',
                  'يمكنك متابعة جميع الجداول الدراسية ومواعيد الامتحانات من هنا.'),
            ),

            const SizedBox(height: 24),

            // Team Selection
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF2a2a2a),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xFFd4af37).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'اختيار الفريق',
                    style: TextStyle(
                      color: Color(0xFFd4af37),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    'يمكنك الوصول إلى المواد التعليمية حسب السنة الدراسية والفريق المختار.',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 16),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: _buildTeamButton('أولى', true),
                  //     ),
                  //     const SizedBox(width: 12),
                  //     Expanded(
                  //       child: _buildTeamButton('ثانية', false),
                  //     ),
                  //     const SizedBox(width: 12),
                  //     Expanded(
                  //       child: _buildTeamButton('ثالثة', false),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
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

  Widget _buildTeamButton(String team, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFd4af37) : const Color(0xFF1a1a1a),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFd4af37),
          width: 1,
        ),
      ),
      child: Text(
        team,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: isSelected ? Colors.black : const Color(0xFFd4af37),
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showFeatureDialog(
      BuildContext context, String title, String description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF2a2a2a),
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFFd4af37),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          description,
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
}
