import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../domain/entities/event.dart';
import '../../domain/entities/filter.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/filter_chip_widget.dart';
import '../widgets/event_card_widget.dart';
import 'event_detail_page.dart';

/// Event Listing Page - Main screen showing events with filters
class EventListingPage extends StatefulWidget {
  const EventListingPage({Key? key}) : super(key: key);

  @override
  State<EventListingPage> createState() => _EventListingPageState();
}

class _EventListingPageState extends State<EventListingPage> {
  int _currentNavIndex = 0;

  // Mock data for demonstration (will be replaced with BLoC)
  late List<EventFilter> _filters;
  late List<Event> _events;
  late List<Event> _userBids;

  @override
  void initState() {
    super.initState();
    _initializeMockData();
  }

  void _initializeMockData() {
    // Mock filters
    _filters = [
      const EventFilter(
        id: '1',
        name: 'carnival',
        displayName: 'Carnival',
        isActive: true,
      ),
      const EventFilter(
        id: '2',
        name: 'social',
        displayName: 'Social',
        count: 32,
        isActive: true,
      ),
      const EventFilter(
        id: '3',
        name: 'live_music',
        displayName: 'Live Music',
        isActive: false,
      ),
      const EventFilter(
        id: '4',
        name: 'underground',
        displayName: 'Underground',
        isActive: false,
      ),
    ];

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
      id: '1',
      name: 'Sitar Magic by Rishabh Rikhiram Sharma...',
      imageUrl: 'https://example.com/image.jpg',
      dateTime: DateTime.now(),
      timeDisplay: 'Today | 10:00 PM Onwards',
      category: 'Carnival',
      eventType: 'Stand-up Comedy',
      artistName: 'Malvika Khanna',
      artistRole: 'Artist',
      venue: mockVenue,
      inclusions: [
        '3 Starters',
        '2 Main Course',
        '1 Dessert',
        '2 Drinks',
        '1 Appetizer',
        'Live Music',
        'DJ',
        'Dance Floor',
        'Valet Parking',
        'Air Conditioning',
        '10+ More',
      ],
      offer: 'Get Flat 25% Off On Food & Bever.',
      attendeeCount: 7,
      recentAttendees: ['Rohit Sharma'],
      isFavorite: false,
      isBookmarked: false,
    );

    _events = [mockEvent];
    _userBids = List.generate(3, (index) => mockEvent);
  }

  void _onFilterTap(int index) {
    setState(() {
      _filters[index] = _filters[index].copyWith(
        isActive: !_filters[index].isActive,
      );
    });
  }

  void _onNavTap(int index) {
    setState(() {
      _currentNavIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGrey,
      appBar: CustomAppBar(
        locationName: 'Vasant Kunj',
        locationSubtext: 'Vasant Kunj Comes Under...',
        onLocationTap: () {
          // Handle location tap
        },
        onNotificationTap: () {
          // Handle notification tap
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page title
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
              child: Text('Event Listing', style: AppTextStyles.heading3),
            ),

            // Filter chips
            _buildFilterChips(),

            const SizedBox(height: 16),

            // Events list
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: _events.map((event) {
                  return EventCardWidget(
                    event: event,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EventDetailPage(eventId: event.id),
                        ),
                      );
                    },
                    onBookmarkTap: () {
                      // Handle bookmark tap
                    },
                    onShareTap: () {
                      // Handle share tap
                    },
                    showAttendeeInfo: true,
                  );
                }).toList(),
              ),
            ),

            // Divider with dots
            _buildDivider(),

            // My Bids section
            _buildMyBidsSection(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentNavIndex,
        onTap: _onNavTap,
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 34,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 11),
        scrollDirection: Axis.horizontal,
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final filter = _filters[index];
          return Padding(
            padding: EdgeInsets.only(
              right: index < _filters.length - 1 ? 8 : 0,
            ),
            child: FilterChipWidget(
              label: filter.displayName,
              count: filter.count,
              isActive: filter.isActive,
              onTap: () => _onFilterTap(index),
              showCloseIcon: true,
            ),
          );
        },
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Expanded(child: Container(height: 1, color: AppColors.borderGrey)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: List.generate(
                3,
                (index) => Container(
                  width: 6,
                  height: 6,
                  margin: EdgeInsets.only(left: index > 0 ? 4 : 0),
                  decoration: BoxDecoration(
                    color: AppColors.borderGrey,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
          Expanded(child: Container(height: 1, color: AppColors.borderGrey)),
        ],
      ),
    );
  }

  Widget _buildMyBidsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'My Bids (${_userBids.length})',
            style: AppTextStyles.heading3,
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: _userBids.map((event) {
              return EventCardWidget(
                event: event,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailPage(eventId: event.id),
                    ),
                  );
                },
                onBookmarkTap: () {
                  // Handle bookmark tap
                },
                onShareTap: () {
                  // Handle share tap
                },
                showAttendeeInfo: false,
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
