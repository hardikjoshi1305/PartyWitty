import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

/// Custom app bar matching Figma design
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String locationName;
  final String? locationSubtext;
  final VoidCallback? onLocationTap;
  final VoidCallback? onNotificationTap;
  final int notificationCount;

  const CustomAppBar({
    Key? key,
    required this.locationName,
    this.locationSubtext,
    this.onLocationTap,
    this.onNotificationTap,
    this.notificationCount = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        color: AppColors.backgroundWhite,
        child: Row(
          children: [
            // Logo
            _buildLogo(),
            const SizedBox(width: 12),

            // Location selector
            Expanded(
              child: GestureDetector(
                onTap: onLocationTap,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Text(
                          locationName,
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.keyboard_arrow_down,
                          size: 20,
                          color: AppColors.iconPrimary,
                        ),
                      ],
                    ),
                    if (locationSubtext != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        locationSubtext!,
                        style: AppTextStyles.caption,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Notification icon
            GestureDetector(
              onTap: onNotificationTap,
              child: Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: Icon(
                      Icons.notifications_outlined,
                      size: 24,
                      color: AppColors.iconPrimary,
                    ),
                  ),
                  if (notificationCount > 0)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.error,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          notificationCount > 9 ? '9+' : '$notificationCount',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textWhite,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.backgroundLightGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          // PlayStation-style logo (simplified representation)
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.accentGreen,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.textPrimary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 8,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.accentBlue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            bottom: 8,
            right: 8,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: AppColors.error,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}
