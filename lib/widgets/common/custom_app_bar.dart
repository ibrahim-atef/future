import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/theme/app_dimensions.dart';
import '../../core/constants/app_constants.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? userName;
  final VoidCallback? onLogoTap;
  final bool showBackButton;
  final String? title;

  const CustomAppBar({
    super.key,
    this.userName,
    this.onLogoTap,
    this.showBackButton = false,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.appBarHeight,
      decoration: const BoxDecoration(
        color: AppColors.backgroundPrimary,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.space16,
            vertical: AppDimensions.space8,
          ),
          child: Row(
            children: [
              // Right side - User info or title
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (title != null)
                      Text(
                        title!,
                        style: AppTypography.appBarTitle,
                        textAlign: TextAlign.right,
                      )
                    else if (userName != null) ...[
                      Text(
                        '$userName |',
                        style: AppTypography.appBarTitle,
                        textAlign: TextAlign.right,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        AppConstants.appSubtitle,
                        style: AppTypography.appBarSubtitle,
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ],
                ),
              ),
              
              const SizedBox(width: AppDimensions.space16),
              
              // Left side - Logo or back button
              if (showBackButton)
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: AppDimensions.logoSize,
                    height: AppDimensions.logoSize,
                    decoration: const BoxDecoration(
                      color: AppColors.accentGold,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.textBlack,
                      size: AppDimensions.iconSizeMedium,
                    ),
                  ),
                )
              else
                GestureDetector(
                  onTap: onLogoTap,
                  child: Container(
                    width: AppDimensions.logoSize,
                    height: AppDimensions.logoSize,
                    decoration: BoxDecoration(
                      color: AppColors.accentGold,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accentGold.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.school_rounded,
                      color: AppColors.textBlack,
                      size: AppDimensions.iconSizeLarge,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppDimensions.appBarHeight);
}


