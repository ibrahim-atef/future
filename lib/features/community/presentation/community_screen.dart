import 'package:flutter/material.dart';
import '../../../core/routes/app_routes.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a1a),
        elevation: 0,
        title: const Text(
          'كميونيتي',
          style: TextStyle(
            color: Color(0xFFd4af37),
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Cairo',
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
            const Text(
              'اختر فرقتك',
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
                _buildGradeCard(
                  context,
                  'فرقة أولى',
                  '1',
                  Icons.school,
                ),
                _buildGradeCard(
                  context,
                  'فرقة ثانية',
                  '2',
                  Icons.school,
                ),
                _buildGradeCard(
                  context,
                  'فرقة ثالثة',
                  '3',
                  Icons.school,
                ),
                _buildGradeCard(
                  context,
                  'فرقة رابعة',
                  '4',
                  Icons.school,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradeCard(
    BuildContext context,
    String title,
    String gradeId,
    IconData icon,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppRoutes.communityChat,
          arguments: {
            'gradeId': gradeId,
            'gradeName': title,
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFd4af37), Color(0xFFb8860b)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFd4af37).withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Cairo',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
