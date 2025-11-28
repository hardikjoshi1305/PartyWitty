import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

/// Purple tag widget for time/category display
class PurpleTagWidget extends StatelessWidget {
  final String text;

  const PurpleTagWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primaryPurple,
        borderRadius: BorderRadius.circular(6),
      ),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            textAlign: TextAlign.left,
            text,
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textWhite,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            textAlign: TextAlign.left,

            "10:00 PM Onwards",
            style: AppTextStyles.caption.copyWith(
              color: AppColors.textWhite,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
