import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

/// User activity widget showing attendee information
class UserActivityWidget extends StatelessWidget {
  final String
  activityText; // e.g., "Rohit Sharma +6 more Attended a party here last m..."

  const UserActivityWidget({Key? key, required this.activityText})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        activityText,
        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
