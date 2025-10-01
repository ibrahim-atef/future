import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTypography {
  // Font Families
  static const String cairoFont = 'Cairo';
  static const String tajawalFont = 'Tajawal';
  
  // Headline Styles
  static const TextStyle h1 = TextStyle(
    fontFamily: cairoFont,
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
    height: 1.2,
  );
  
  static const TextStyle h2 = TextStyle(
    fontFamily: cairoFont,
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.accentGold,
    height: 1.3,
  );
  
  static const TextStyle sectionTitle = TextStyle(
    fontFamily: cairoFont,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.accentGold,
    height: 1.4,
  );
  
  // Body Styles
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: tajawalFont,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textWhite,
    height: 1.5,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontFamily: tajawalFont,
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textWhite,
    height: 1.5,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontFamily: tajawalFont,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textMuted,
    height: 1.4,
  );
  
  // Special Styles
  static const TextStyle caption = TextStyle(
    fontFamily: tajawalFont,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.accentGold,
    height: 1.3,
  );
  
  static const TextStyle buttonText = TextStyle(
    fontFamily: cairoFont,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );
  
  static const TextStyle cardTitle = TextStyle(
    fontFamily: cairoFont,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
    height: 1.3,
  );
  
  static const TextStyle cardCaption = TextStyle(
    fontFamily: tajawalFont,
    fontSize: 11,
    fontWeight: FontWeight.normal,
    color: AppColors.textMuted,
    height: 1.2,
  );
  
  // App Bar Styles
  static const TextStyle appBarTitle = TextStyle(
    fontFamily: cairoFont,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textWhite,
  );
  
  static const TextStyle appBarSubtitle = TextStyle(
    fontFamily: tajawalFont,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.accentGold,
  );
  
  // Form Styles
  static const TextStyle inputLabel = TextStyle(
    fontFamily: tajawalFont,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textWhite,
  );
  
  static const TextStyle inputText = TextStyle(
    fontFamily: tajawalFont,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textWhite,
  );
  
  static const TextStyle inputHint = TextStyle(
    fontFamily: tajawalFont,
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textMuted,
  );
  
  static const TextStyle errorText = TextStyle(
    fontFamily: tajawalFont,
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.error,
  );
}


