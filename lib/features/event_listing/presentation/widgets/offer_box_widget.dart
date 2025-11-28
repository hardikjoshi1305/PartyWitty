import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../domain/entities/event_detail.dart';

/// Offer/Promotion box widget matching Figma design
class OfferBoxWidget extends StatelessWidget {
  final OfferBox offerBox;

  const OfferBoxWidget({Key? key, required this.offerBox}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
          AppColors.backgroundWhite,
              AppColors.accentYellow,

            ]),
        borderRadius: BorderRadius.circular(8),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon (if available)
              // if (offerBox.iconName != null) _buildIcon(offerBox.iconName!),
              if (offerBox.iconName != null) const SizedBox(height: 8),
              // Title
              Text(
                offerBox.title,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 10
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              // Code (if available)
              if (offerBox.code != null) ...[
                Text(
                  offerBox.code!,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 10
                  ),
                ),
              ],
            ],
          ),
          // Button (if available)
          if (offerBox.buttonText != null)
            Container(
              margin: EdgeInsets.only(top: 8,left: 10,right: 10),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.backgroundGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                offerBox.buttonText!,
                style: AppTextStyles.buttonSmall.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 11
                ),
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildIcon(String iconName) {
    IconData iconData;
    switch (iconName) {
      case 'cheers':
        iconData = Icons.local_bar;
        break;
      case 'dancing':
        iconData = Icons.music_note;
        break;
      default:
        iconData = Icons.card_giftcard;
    }

    return Icon(iconData, size: 32, color: AppColors.primaryPurple);
  }
}
