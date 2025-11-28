import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

/// App download prompt widget matching Figma design
class AppDownloadPromptWidget extends StatelessWidget {
  final String rewardText; // e.g., "Get 500 carrots instantly"
  final VoidCallback? onPlayStoreTap;
  final VoidCallback? onAppStoreTap;

  const AppDownloadPromptWidget({
    Key? key,
    this.rewardText = 'Get 500 carrots instantly',
    this.onPlayStoreTap,
    this.onAppStoreTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            rewardText,
            style: AppTextStyles.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: onPlayStoreTap,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.android, color: AppColors.iconSecondary),
                ),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: onAppStoreTap,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    Icons.phone_iphone,
                    color: AppColors.iconSecondary,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Download the App',
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
