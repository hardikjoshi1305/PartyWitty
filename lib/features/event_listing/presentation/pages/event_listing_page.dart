import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../injection_container.dart' as di;
import '../../domain/entities/filter.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/filter_chip_widget.dart';
import '../widgets/event_card_widget.dart';
import '../bloc/event_listing_bloc.dart';
import '../bloc/event_listing_event.dart';
import '../bloc/event_listing_state.dart';
import '../bloc/event_detail_bloc.dart';
import 'event_detail_page.dart';

/// Event Listing Page - Main screen showing events with filters
class EventListingPage extends StatefulWidget {
  const EventListingPage({Key? key}) : super(key: key);

  @override
  State<EventListingPage> createState() => _EventListingPageState();
}

class _EventListingPageState extends State<EventListingPage> {
  int _currentNavIndex = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // Load events when page is initialized
    context.read<EventListingBloc>().add(const LoadEventsEvent());

    // Set up scroll listener for pagination
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<EventListingBloc>().add(const LoadMoreEventsEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }


  void _onFilterTap(int index, List<EventFilter> filters) {
    final filter = filters[index];
    final bloc = context.read<EventListingBloc>();
    final currentState = bloc.state;

    if (currentState is EventListingLoaded) {
      if (filter.isActive) {
        bloc.add(RemoveFilterEvent(filter));
      } else {
        bloc.add(ApplyFilterEvent(filter));
      }
    }
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
      body: BlocBuilder<EventListingBloc, EventListingState>(
        builder: (context, state) {
          if (state is EventListingLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is EventListingError) {
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
                      context.read<EventListingBloc>().add(
                        const LoadEventsEvent(),
                      );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is EventListingLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<EventListingBloc>().add(
                  const RefreshEventsEvent(),
                );
                // Wait a bit for the refresh to complete
                await Future.delayed(const Duration(seconds: 1));
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Page title
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                      child: Text(
                        'Event Listing',
                        style: AppTextStyles.heading3,
                      ),
                    ),

                    // Filter chips
                    if (state.filters.isNotEmpty)
                      _buildFilterChips(state.filters),

                    const SizedBox(height: 16),

                    // Events list
                    if (state.events.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Center(child: Text('No events found')),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: state.events.map((event) {
                            return EventCardWidget(
                              event: event,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (context) =>
                                          di.sl<EventDetailBloc>(),
                                      child: EventDetailPage(
                                        eventId: event.id,
                                        slug1: event.slug1,
                                        slug2: event.slug2,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              onBookmarkTap: () {
                                context.read<EventListingBloc>().add(
                                  ToggleBookmarkEvent(event.id),
                                );
                              },
                              onShareTap: () {
                                // Handle share tap
                              },
                              showAttendeeInfo: true,
                            );
                          }).toList(),
                        ),
                      ),

                    // Loading more indicator
                    if (state.isLoadingMore)
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Center(child: CircularProgressIndicator()),
                      ),

                    // Divider with dots
                    if (state.events.isNotEmpty) _buildDivider(),

                    // My Bids section
                    _buildMyBidsSection(state.userBids),
                  ],
                ),
              ),
            );
          }

          if (state is EventListingRefreshing) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<EventListingBloc>().add(
                  const RefreshEventsEvent(),
                );
                // Wait a bit for the refresh to complete
                await Future.delayed(const Duration(seconds: 1));
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Page title
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                      child: Text(
                        'Event Listing',
                        style: AppTextStyles.heading3,
                      ),
                    ),

                    // Filter chips
                    if (state.filters.isNotEmpty)
                      _buildFilterChips(state.filters),
                    const SizedBox(height: 16),
                    // Events list
                    if (state.events.isEmpty)
                      const Padding(
                        padding: EdgeInsets.all(32.0),
                        child: Center(child: Text('No events found')),
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: state.events.map((event) {
                            return EventCardWidget(
                              event: event,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlocProvider(
                                      create: (context) =>
                                          di.sl<EventDetailBloc>(),
                                      child: EventDetailPage(
                                        eventId: event.id,
                                        slug1: event.slug1,
                                        slug2: event.slug2,
                                      ),
                                    ),
                                  ),
                                );
                              },
                              onBookmarkTap: () {
                                context.read<EventListingBloc>().add(
                                  ToggleBookmarkEvent(event.id),
                                );
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
                    if (state.events.isNotEmpty) _buildDivider(),

                    // My Bids section
                    _buildMyBidsSection(state.userBids),
                  ],
                ),
              ),
            );
          }

          // Initial state
          return const Center(child: CircularProgressIndicator());
        },
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentNavIndex,
        onTap: _onNavTap,
      ),
    );
  }

  Widget _buildFilterChips(List<EventFilter> filters) {
    return SizedBox(
      height: 34,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 11),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          return Padding(
            padding: EdgeInsets.only(right: index < filters.length - 1 ? 8 : 0),
            child: FilterChipWidget(
              label: filter.displayName,
              count: filter.count,
              isActive: filter.isActive,
              onTap: () => _onFilterTap(index, filters),
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

  Widget _buildMyBidsSection(List<dynamic> userBids) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'My Bids (${userBids.length})',
            style: AppTextStyles.heading3,
          ),
        ),
        const SizedBox(height: 16),
        if (userBids.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('No bids yet'),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: userBids.map((bid) {
                // TODO: Replace with proper bid widget when Bid entity is ready
                return const SizedBox.shrink();
              }).toList(),
            ),
          ),
        const SizedBox(height: 20),
      ],
    );
  }
}
