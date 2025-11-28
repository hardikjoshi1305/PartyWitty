import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../domain/entities/event.dart';

/// Event card widget matching Figma design
class EventCardWidget extends StatelessWidget {
  final Event event;
  final VoidCallback? onTap;
  final VoidCallback? onBookmarkTap;
  final VoidCallback? onShareTap;
  final bool showAttendeeInfo;

  const EventCardWidget({
    Key? key,
    required this.event,
    this.onTap,
    this.onBookmarkTap,
    this.onShareTap,
    this.showAttendeeInfo = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.cardShadow,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Attendee info (if shown)
            if (showAttendeeInfo && event.recentAttendees.isNotEmpty)
              _buildAttendeeInfo(),

            // Event image with overlay icons
            _buildEventImage(),

            // Time and category bar
            _buildTimeCategoryBar(),

            // Event details
            _buildEventDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendeeInfo() {
    final firstAttendee = event.recentAttendees.first;
    final othersCount = event.attendeeCount - 1;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Text(
        '$firstAttendee +$othersCount more Attended a party here last m...',
        style: AppTextStyles.caption,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildEventImage() {
    return Stack(
      children: [
        // Event image (placeholder)
        Container(
          height: 280,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryPurple,
                AppColors.primaryPurpleLight,
                AppColors.accentBlue,
              ],
            ),
          ),
          child: Center(
            child: Icon(
              Icons.image,
              size: 60,
              color: AppColors.iconWhite.withOpacity(0.5),
            ),
          ),
        ),

        // Top left filter icon
        Positioned(
          top: 12,
          left: 12,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.backgroundWhite,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.filter_list,
              size: 20,
              color: AppColors.iconPrimary,
            ),
          ),
        ),

        // Top right icons (bookmark and share)
        Positioned(
          top: 12,
          right: 12,
          child: Row(
            children: [
              // Bookmark icon
              GestureDetector(
                onTap: onBookmarkTap,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundWhite,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    event.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                    size: 20,
                    color: AppColors.iconPrimary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Share icon
              GestureDetector(
                onTap: onShareTap,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundWhite,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.share,
                    size: 20,
                    color: AppColors.iconPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimeCategoryBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(color: AppColors.primaryPurple),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            event.timeDisplay,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textWhite,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            event.category,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textWhite,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventDetails() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event name
          Text(
            event.name,
            style: AppTextStyles.heading4,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),

          // Artist info
          Row(
            children: [
              Icon(Icons.favorite, size: 16, color: AppColors.textPrimary),
              const SizedBox(width: 4),
              Text(
                event.artistName,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.backgroundLightGrey,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(event.artistRole, style: AppTextStyles.caption),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Venue info
          Row(
            children: [
              Icon(Icons.diamond, size: 16, color: AppColors.accentBlue),
              const SizedBox(width: 4),
              Text(event.venue.name, style: AppTextStyles.bodyMedium),
              const SizedBox(width: 12),
              Icon(Icons.star, size: 16, color: AppColors.accentYellow),
              const SizedBox(width: 4),
              Text(
                '${event.venue.rating} Review (${event.venue.reviewCount.toString().padLeft(2, '0')})',
                style: AppTextStyles.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Location info
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  event.venue.locationShort,
                  style: AppTextStyles.bodySmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.diamond, size: 14, color: AppColors.primaryPurple),
              const SizedBox(width: 4),
              Text(
                '${event.venue.distanceKm} Kms',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primaryPurple,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Event type
          Row(
            children: [
              Icon(Icons.mic, size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 4),
              Text(event.eventType, style: AppTextStyles.bodySmall),
            ],
          ),
          const SizedBox(height: 12),

          // Inclusions
          if (event.inclusions.isNotEmpty) ...[
            Wrap(
              spacing: 8,
              children: [
                ...event.inclusions.take(2).map((inclusion) {
                  return Chip(
                    label: Text(inclusion, style: AppTextStyles.caption),
                    backgroundColor: AppColors.backgroundLightGrey,
                    padding: EdgeInsets.zero,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  );
                }),
                if (event.inclusions.length > 2)
                  Chip(
                    label: Text(
                      '${event.inclusions.length - 2}+ More',
                      style: AppTextStyles.caption.copyWith(
                        color: AppColors.primaryPurple,
                      ),
                    ),
                    backgroundColor: AppColors.backgroundLightGrey,
                    padding: EdgeInsets.zero,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
              ],
            ),
            const SizedBox(height: 12),
          ],

          // Offer button
          if (event.offer != null) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.primaryPurple,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                event.offer!,
                style: AppTextStyles.buttonMedium,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 12),
          ],

          // View details link
          GestureDetector(
            onTap: onTap,
            child: Text('View Details', style: AppTextStyles.link),
          ),
        ],
      ),
    );
  }
}
