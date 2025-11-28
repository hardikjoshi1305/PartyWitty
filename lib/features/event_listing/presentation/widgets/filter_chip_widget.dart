import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

/// Custom filter chip widget matching Figma design
class FilterChipWidget extends StatelessWidget {
  final String label;
  final int? count;
  final bool isActive;
  final VoidCallback onTap;
  final bool showCloseIcon;

  const FilterChipWidget({
    Key? key,
    required this.label,
    this.count,
    required this.isActive,
    required this.onTap,
    this.showCloseIcon = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryPurple : AppColors.backgroundWhite,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Filter icon for first chip (if needed)
            if (label.toLowerCase().contains('filter'))
              Padding(
                padding: const EdgeInsets.only(right: 6),
                child: Icon(
                  Icons.filter_list,
                  size: 16,
                  color: isActive
                      ? AppColors.chipActiveText
                      : AppColors.chipInactiveText,
                ),
              ),
            // Label text
            Text(
              count != null ? '$label ($count)' : label,
              style: isActive
                  ? AppTextStyles.chipActive
                  : AppTextStyles.chipInactive.copyWith(
                color: AppColors.textPrimary
              ),
            ),
            // Close icon for active chips
            if (isActive && showCloseIcon) ...[
              const SizedBox(width: 6),
              Icon(Icons.close, size: 16, color: AppColors.chipActiveText),
            ],
          ],
        ),
      ),
    );
  }
}
