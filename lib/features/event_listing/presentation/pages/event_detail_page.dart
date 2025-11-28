import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:partywitty/features/event_listing/presentation/widgets/event_card_widget.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../domain/entities/event_detail.dart';
import '../widgets/image_carousel_widget.dart';
import '../widgets/offer_box_widget.dart';
import '../widgets/menu_section_widget.dart';
import '../widgets/purple_tag_widget.dart';
import '../widgets/artist_profile_card_widget.dart';
import '../widgets/app_download_prompt_widget.dart';
import '../widgets/music_events_section_widget.dart';
import '../bloc/event_detail_bloc.dart';
import '../bloc/event_detail_event.dart';
import '../bloc/event_detail_state.dart';

/// Event Detail Page - Detailed view of an event matching Figma design exactly
class EventDetailPage extends StatefulWidget {
  final String eventId;
  final String? slug1;
  final String? slug2;

  const EventDetailPage({
    super.key,
    required this.eventId,
    this.slug1,
    this.slug2,
  });

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  void initState() {
    super.initState();
    // Load event details when page is initialized
    context.read<EventDetailBloc>().add(
      LoadEventDetailEvent(
        eventId: widget.eventId,
        slug1: widget.slug1,
        slug2: widget.slug2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGreyDarker,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundGreyDarker,
        title: Text(
          'Event Details',
          style: AppTextStyles.heading4.copyWith(
            fontSize: 15,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: BlocBuilder<EventDetailBloc, EventDetailState>(
        builder: (context, state) {
          if (state is EventDetailLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is EventDetailError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style: AppTextStyles.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<EventDetailBloc>().add(
                        LoadEventDetailEvent(
                          eventId: widget.eventId,
                          slug1: widget.slug1,
                          slug2: widget.slug2,
                        ),
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is EventDetailLoaded) {
            return _buildContent(context, state.eventDetail);
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, EventDetail eventDetail) {
    final event = eventDetail.event;

    return Container(
      color: AppColors.backgroundGreyDarker,
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date display at top
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(16, 6, 16, 8),
            //   child: Text(
            // '${eventDate.day} ${_getMonthName(eventDate.month)} ${eventDate.year}',
            // style: AppTextStyles.bodyMedium.copyWith(
            //   color: AppColors.textPrimary,
            //   fontWeight: FontWeight.w500,
            // ),
            //   ),
            // ),

            // Image carousel with overlay icons
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ImageCarouselWidget(
                    imageUrls: eventDetail.imageUrls.isNotEmpty
                        ? eventDetail.imageUrls
                        : [event.imageUrl],
                    height: 230,
                    overlayWidgets: [
                      // Top right icons
                      Positioned(
                        top: 6,
                        right: 12,
                        child: Row(
                          children: [
                            // Heart icon
                            GestureDetector(
                              onTap: () {
                                context.read<EventDetailBloc>().add(
                                  ToggleFavoriteEvent(event.id),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundWhite.withValues(
                                    alpha: 0.9,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  event.isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  size: 20,
                                  color: AppColors.iconPrimary,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // Share icon
                            GestureDetector(
                              onTap: () {
                                // Handle share
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.backgroundWhite.withValues(
                                    alpha: 0.9,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
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
                  ),
                ),
              ],
            ),

            // Main content card
            Container(
              margin: const EdgeInsets.only(top: 16, left: 1, right: 1),
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: AppColors.backgroundLightGrey,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                      ),
                      child: Column(
                        children: [
                          // Time tag and price
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PurpleTagWidget(text: event.timeDisplay),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    '₹${eventDetail.price?.toStringAsFixed(0) ?? '0'}',
                                    style: AppTextStyles.pricelarge.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  if (eventDetail.validity != null) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      eventDetail.validity!,
                                      style: AppTextStyles.purplesmall,
                                    ),
                                  ],
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 16),

                          // Event title
                          Text(
                            event.name,
                            style: AppTextStyles.heading4.copyWith(
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Venue details
                          _buildVenueInfo(event),
                        ],
                      ),
                    ),

                    // Offer boxes (side by side)
                    if (eventDetail.offerBoxes.isNotEmpty) ...[
                      Row(
                        children: [
                          Expanded(
                            child: OfferBoxWidget(
                              offerBox: eventDetail.offerBoxes[0],
                            ),
                          ),
                          if (eventDetail.offerBoxes.length > 1) ...[
                            const SizedBox(width: 5),
                            Expanded(
                              child: OfferBoxWidget(
                                offerBox: eventDetail.offerBoxes[1],
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 14),
                    ],
                    // About the Event section
                    if (eventDetail.aboutText != null &&
                        eventDetail.aboutText!.isNotEmpty) ...[
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: AppColors.backgroundLightGrey,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About the Event',
                              textAlign: TextAlign.left,
                              style: AppTextStyles.heading4.copyWith(
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              eventDetail.aboutText!,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                                height: 1.6,
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ],
                    // Menu section
                    if (eventDetail.menuCategories.isNotEmpty)
                      MenuSectionWidget(
                        menuCategories: eventDetail.menuCategories,
                      ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text('Artists', style: AppTextStyles.heading4),
            ),

            // Artist profile card
            ArtistProfileCardWidget(
              artistName: 'Sarah Martinez',
              rating: 4.8,
              profession: 'Singer',
              eventDate: '20 Sep 25',
              eventTime: '07:00 AM',
              eventEndTime: '10:00 AM',
              tags: [
                'Popular',
                'Rock',
                'Followers: 500',
                'Book Now',
                'Top Rated',
                'New',
                'Available 30 Jan',
              ],
              availableDate: '30 Jan',
              onBookNow: () {
                // Handle book now
              },
              onTopRated: () {
                // Handle top rated
              },
              onNew: () {
                // Handle new
              },
            ),
            SizedBox(height: 16),
            EventCardWidget(event: event),

            // App download prompt
            AppDownloadPromptWidget(
              rewardText: 'Get 500 carrots instantly',
              onPlayStoreTap: () {
                // Handle Play Store tap
              },
              onAppStoreTap: () {
                // Handle App Store tap
              },
            ),

            // Music Events section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.backgroundWhite,
                borderRadius: BorderRadius.circular(12),
              ),
              child: MusicEventsSectionWidget(
                content:
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
              ),
            ),

            // Bottom Book Now button
            Container(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle book now
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentBlue,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Book Now',
                    style: AppTextStyles.buttonLarge.copyWith(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVenueInfo(event) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.diamond, size: 16, color: AppColors.accentBlue),
              const SizedBox(width: 4),
              Text(
                event.venue.name,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
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
        ],
      ),
    );
  }
}
