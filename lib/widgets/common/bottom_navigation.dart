import 'package:flutter/material.dart';
import '../../core/routes/app_routes.dart';

class BottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF2a2a2a),
        border: Border(
          top: BorderSide(
            color: Color(0xFFd4af37),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 'الرئيسية', 0),
              _buildNavItem(Icons.play_circle, 'الكورسات', 1),
              _buildNavItem(Icons.school, 'الكلية', 2),
              _buildNavItem(Icons.article, 'المدونة', 3),
              _buildNavItem(Icons.person, 'البروفايل', 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isActive = currentIndex == index;
    
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xFFd4af37) : Colors.white70,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? const Color(0xFFd4af37) : Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
