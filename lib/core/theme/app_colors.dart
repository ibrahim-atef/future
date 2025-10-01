import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color backgroundPrimary = Color(0xFF0D0D0D);
  static const Color cardBackground = Color(0xFF121212);
  static const Color accentGold = Color(0xFFFFD700);
  static const Color accentGoldSecondary = Color(0xFFFFC107);
  
  // Text Colors
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textMuted = Color(0xFFBDBDBD);
  static const Color textBlack = Color(0xFF000000);
  
  // Border & Dividers
  static const Color borderSubtle = Color(0x0FFFFFFF);
  
  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFF9800);
  static const Color info = Color(0xFF2196F3);
  
  // Overlay & Shadow
  static const Color overlayDark = Color(0x99000000);
  static const Color shadowColor = Color(0x99000000);
  
  // Gradient Colors
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0x99000000), // rgba(0,0,0,0.6)
      Color(0xD9000000), // rgba(0,0,0,0.85)
    ],
  );
  
  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1A1A1A),
      Color(0xFF0F0F0F),
    ],
  );
}


