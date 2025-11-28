import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

/// Artist profile card widget matching Figma design
class ArtistProfileCardWidget extends StatelessWidget {
  final String artistName;
  final double rating;
  final String profession;
  final String eventDate;
  final String eventTime;
  final String eventEndTime;
  final List<String> tags;
  final String availableDate;
  final VoidCallback? onBookNow;
  final VoidCallback? onTopRated;
  final VoidCallback? onNew;

  const ArtistProfileCardWidget({
    Key? key,
    required this.artistName,
    required this.rating,
    required this.profession,
    required this.eventDate,
    required this.eventTime,
    required this.eventEndTime,
    required this.tags,
    required this.availableDate,
    this.onBookNow,
    this.onTopRated,
    this.onNew,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Artist image placeholder
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.backgroundGrey,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Center(
              child: Icon(
                Icons.person,
                size: 60,
                color: AppColors.iconSecondary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Artist name and rating
                Row(
                  children: [
                    Text(artistName, style: AppTextStyles.heading3.copyWith(
                      color: Colors.white
                    )),
                    const SizedBox(width: 8),
                    Icon(Icons.star, size: 16, color: AppColors.accentYellow),
                    const SizedBox(width: 4),
                    Text(
                      rating.toStringAsFixed(1),
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: Colors.white
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  profession,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 16),
                // Event details
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 16,
                      color: AppColors.white,
                    ),
                    const SizedBox(width: 8),
                    Text('Event $eventDate', style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.white
                    )),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: AppColors.white,
                    ),
                    const SizedBox(width: 8),
                    Text('Time $eventTime', style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.white
                    )),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: AppColors.white,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Event End Time $eventEndTime',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Tags
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: tags.map((tag) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundDarkTransperant,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Text(tag, style: AppTextStyles.caption.copyWith(
                        color: Colors.white
                      )),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
