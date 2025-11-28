import 'package:flutter/material.dart';
import 'package:partywitty/features/event_listing/presentation/widgets/event_card_widget.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../domain/entities/event.dart';
import '../../domain/entities/event_detail.dart';
import '../widgets/image_carousel_widget.dart';
import '../widgets/offer_box_widget.dart';
import '../widgets/menu_section_widget.dart';
import '../widgets/purple_tag_widget.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/artist_profile_card_widget.dart';
import '../widgets/user_activity_widget.dart';
import '../widgets/app_download_prompt_widget.dart';
import '../widgets/music_events_section_widget.dart';

/// Event Detail Page - Detailed view of an event matching Figma design exactly
class EventDetailPage extends StatefulWidget {
  final String eventId;

  const EventDetailPage({super.key, required this.eventId});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  late EventDetail _eventDetail;
  late Event _relatedEvent;

  @override
  void initState() {
    super.initState();
    _initializeMockData();
  }

  void _initializeMockData() {
    // Mock venue
    const mockVenue = Venue(
      id: '1',
      name: 'F-Bar',
      address: 'DLP Phase 3, Gurugram, Haryana',
      locationShort: 'DLP Phase 3, Gurugram',
      rating: 4.1,
      reviewCount: 3,
      distanceKm: 1.2,
    );

    // Mock event
    final mockEvent = Event(
      id: widget.eventId,
      name: 'Tuesday Tunes @connaught club house@01 July 2025 (DJ Night)',
      imageUrl: 'https://example.com/event1.jpg',
      dateTime: DateTime(2025, 9, 10),

      timeDisplay: 'Today',
      category: 'Carnival',
      eventType: 'DJ Night',
      artistName: 'Malvika Khanna',
      artistRole: 'Artist',
      venue: mockVenue,
      inclusions: ['3 Starters', '2 Main Course', '1 Dessert'],
      offer: 'Get Flat 25% Off On Food & Bever.',
      attendeeCount: 7,
      recentAttendees: ['Rohit Sharma'],
      isFavorite: false,
      isBookmarked: false,
    );

    // Mock event detail
    _eventDetail = EventDetail(
      event: mockEvent,
      price: 50.0,
      validity: 'Valid For Max 10 Person',
      aboutText:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
      imageUrls: [
        mockEvent.imageUrl,
        'https://example.com/event1-2.jpg',
        'https://example.com/event1-3.jpg',
      ],
      menuCategories: [
        MenuCategory(
          id: '1',
          name: 'STARTERS',
          items: [
            MenuItem(
              id: '1',
              name: 'Chicken Tikka',
              imageUrl: 'https://example.com/chicken.jpg',
              price: 250.0,
            ),
            MenuItem(
              id: '2',
              name: 'Paneer Tikka',
              imageUrl: 'https://example.com/paneer.jpg',
              price: 220.0,
            ),
            MenuItem(
              id: '3',
              name: 'Chicken Tenders',
              imageUrl: 'https://example.com/tenders.jpg',
              price: 280.0,
            ),
            MenuItem(
              id: '4',
              name: 'Caesar Salad',
              imageUrl: 'https://example.com/salad.jpg',
              price: 180.0,
            ),
            MenuItem(
              id: '5',
              name: 'Grilled Chicken',
              imageUrl: 'https://example.com/grilled.jpg',
              price: 450.0,
            ),
            MenuItem(
              id: '6',
              name: 'Pasta',
              imageUrl: 'https://example.com/pasta.jpg',
              price: 320.0,
            ),
          ],
        ),
      ],
      offerBoxes: [
        OfferBox(
          id: '1',
          title: 'Save flat ₹200 on Total Bill',
          code: 'TEASERREWARD20',
          buttonText: 'Watch Teaser',
          iconName: 'cheers',
        ),
        OfferBox(
          id: '2',
          title: 'Upto 50% Off On Food & Beverages Bill',
          buttonText: 'Pre-Booking',
          iconName: 'dancing',
        ),
      ],
    );

    // Mock related event
    _relatedEvent = Event(
      id: '2',
      name: 'Sitar Magic by Rishabh Rikhiram Sharma...',
      imageUrl: 'https://example.com/event2.jpg',
      dateTime: DateTime.now(),
      timeDisplay: 'Today | 10:00 PM Onwards',
      category: 'Music',
      eventType: 'Stand-up Comedy',
      artistName: 'Malvika Khanna',
      artistRole: 'Artist',
      venue: mockVenue,
      inclusions: ['3 Starters', '2 Main Course', '10+ More'],
      offer: 'Get Flat 25% Off On Food & Bever.',
      attendeeCount: 0,
      recentAttendees: [],
      isFavorite: false,
      isBookmarked: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGreyDarker,
      appBar: AppBar(

        backgroundColor: AppColors.backgroundGreyDarker,
        title: Text("Event Details", style: AppTextStyles.heading4.copyWith(
          fontSize: 15,
          color: AppColors.textPrimary,
        )),
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    final event = _eventDetail.event;
    final eventDate = event.dateTime;

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
                    imageUrls: _eventDetail.imageUrls.isNotEmpty
                        ? _eventDetail.imageUrls
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
                                setState(() {
                                  _eventDetail = EventDetail(
                                    event: Event(
                                      id: event.id,
                                      name: event.name,
                                      description: event.description,
                                      imageUrl: event.imageUrl,
                                      dateTime: event.dateTime,
                                      timeDisplay: event.timeDisplay,
                                      category: event.category,
                                      eventType: event.eventType,
                                      artistName: event.artistName,
                                      artistRole: event.artistRole,
                                      venue: event.venue,
                                      inclusions: event.inclusions,
                                      offer: event.offer,
                                      attendeeCount: event.attendeeCount,
                                      recentAttendees: event.recentAttendees,
                                      isFavorite: !event.isFavorite,
                                      isBookmarked: event.isBookmarked,
                                    ),
                                    price: _eventDetail.price,
                                    validity: _eventDetail.validity,
                                    aboutText: _eventDetail.aboutText,
                                    imageUrls: _eventDetail.imageUrls,
                                    menuCategories: _eventDetail.menuCategories,
                                    offerBoxes: _eventDetail.offerBoxes,
                                  );
                                });
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
              margin: const EdgeInsets.only(top: 16,left: 1,right: 1),
              child: Padding(
                padding: const EdgeInsets.all(1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: AppColors.backgroundLightGrey,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                        ),
                      child:
                     Column(
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
                                   '₹${_eventDetail.price?.toStringAsFixed(0) ?? '0'}',
                                   style: AppTextStyles.pricelarge.copyWith(
                                     fontWeight: FontWeight.bold,
                                   ),
                                 ),
                                 if (_eventDetail.validity != null) ...[
                                   const SizedBox(height: 4),
                                   Text(
                                     _eventDetail.validity!,
                                     style: AppTextStyles.purplesmall,
                                   ),
                                 ],
                               ],
                             ),
                           ],
                         ),
                         SizedBox(height: 16),

                         // Event title
                         Text(event.name, style: AppTextStyles.heading4.copyWith(
                           fontSize: 13
                         )),
                         const SizedBox(height: 16),

                         // Venue details
                         _buildVenueInfo(event),
                       ],
                     )
                    ),

                    // Offer boxes (side by side)
                    if (_eventDetail.offerBoxes.isNotEmpty) ...[
                      Row(
                        children: [
                          Expanded(
                            child: OfferBoxWidget(
                              offerBox: _eventDetail.offerBoxes[0],
                            ),
                          ),
                          if (_eventDetail.offerBoxes.length > 1) ...[
                            const SizedBox(width: 5),
                            Expanded(
                              child: OfferBoxWidget(
                                offerBox: _eventDetail.offerBoxes[1],
                              ),
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 14),
                    ],
                    // About the Event section
                    if (_eventDetail.aboutText != null) ...[
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: AppColors.backgroundLightGrey,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                        ),
                        child:
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('About the Event', textAlign:TextAlign.left,style: AppTextStyles.heading4.copyWith(
                              fontSize: 15
                            )),
                            const SizedBox(height: 12),
                            Text(
                              _eventDetail.aboutText! + _eventDetail.aboutText!+_eventDetail.aboutText!,
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                                height: 1.6,
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      )
                    ],
                    // Menu section
                    if (_eventDetail.menuCategories.isNotEmpty)
                      MenuSectionWidget(
                        menuCategories: _eventDetail.menuCategories,
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
              tags: ['Popular', 'Rock', 'Followers: 500','Book Now','Top Rated','New','Available 30 Jan'],
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
                  child: Text('Book Now', style: AppTextStyles.buttonLarge.copyWith(
                    fontSize: 16
                  )),
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

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }
}
