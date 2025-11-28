import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/event.dart';
import '../../domain/entities/filter.dart';
import '../../domain/usecases/get_paginated_events.dart';
import '../../domain/usecases/get_filtered_events.dart';
import '../../domain/usecases/get_user_bids.dart';
import 'event_listing_event.dart';
import 'event_listing_state.dart';

/// Event listing BLoC
class EventListingBloc extends Bloc<EventListingEvent, EventListingState> {
  final GetPaginatedEvents getPaginatedEvents;
  final GetFilteredEvents getFilteredEvents;
  final GetUserBids getUserBids;

  EventListingBloc({
    required this.getPaginatedEvents,
    required this.getFilteredEvents,
    required this.getUserBids,
  }) : super(const EventListingInitial()) {
    on<LoadEventsEvent>(_onLoadEvents);
    on<LoadMoreEventsEvent>(_onLoadMoreEvents);
    on<ApplyFilterEvent>(_onApplyFilter);
    on<RemoveFilterEvent>(_onRemoveFilter);
    on<LoadUserBidsEvent>(_onLoadUserBids);
    on<RefreshEventsEvent>(_onRefreshEvents);
    on<ToggleBookmarkEvent>(_onToggleBookmark);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  /// Get default filters
  List<EventFilter> _getDefaultFilters() {
    return [
      const EventFilter(
        id: 'today',
        name: 'today',
        displayName: 'Today',
        isActive: false,
      ),
      const EventFilter(
        id: 'tomorrow',
        name: 'tomorrow',
        displayName: 'Tomorrow',
        isActive: false,
      ),
      const EventFilter(
        id: 'carnival',
        name: 'carnival',
        displayName: 'Carnival',
        isActive: false,
      ),
    ];
  }

  Future<void> _onLoadEvents(
    LoadEventsEvent event,
    Emitter<EventListingState> emit,
  ) async {
    emit(const EventListingLoading());

    final result = await getPaginatedEvents(
      GetPaginatedEventsParams(
        latitude: ApiConstants.defaultLatitude,
        longitude: ApiConstants.defaultLongitude,
        page: 1,
        limit: ApiConstants.defaultLimit,
      ),
    );

    result.fold(
      (failure) =>
          emit(EventListingError(message: _mapFailureToMessage(failure))),
      (paginatedResponse) {
        final defaultFilters = _getDefaultFilters();
        final filteredEvents = _applyFilters(paginatedResponse.events, []);
        emit(
          EventListingLoaded(
            events: filteredEvents,
            filters: defaultFilters,
            activeFilters: [],
            userBids: [],
            currentPage: paginatedResponse.page,
            totalPages: paginatedResponse.totalPages,
            hasMore: paginatedResponse.hasMore,
          ),
        );
      },
    );
  }

  Future<void> _onLoadMoreEvents(
    LoadMoreEventsEvent event,
    Emitter<EventListingState> emit,
  ) async {
    if (state is EventListingLoaded) {
      final currentState = state as EventListingLoaded;

      // Don't load more if already loading or no more pages
      if (currentState.isLoadingMore || !currentState.hasMore) {
        return;
      }

      // Don't load more if filters are active (filters fetch all pages at once)
      if (currentState.activeFilters.isNotEmpty) {
        return;
      }

      emit(currentState.copyWith(isLoadingMore: true));

      final nextPage = currentState.currentPage + 1;
      final result = await getPaginatedEvents(
        GetPaginatedEventsParams(
          latitude: ApiConstants.defaultLatitude,
          longitude: ApiConstants.defaultLongitude,
          page: nextPage,
          limit: ApiConstants.defaultLimit,
        ),
      );

      result.fold(
        (failure) => emit(
          currentState.copyWith(isLoadingMore: false),
        ), // Keep current state on error
        (paginatedResponse) => emit(
          currentState.copyWith(
            events: [...currentState.events, ...paginatedResponse.events],
            currentPage: paginatedResponse.page,
            totalPages: paginatedResponse.totalPages,
            hasMore: paginatedResponse.hasMore,
            isLoadingMore: false,
          ),
        ),
      );
    }
  }

  /// Apply filters to events (client-side filtering)
  /// When filters are active, events matching ANY active filter are shown (OR logic)
  /// - "Today" filter: Shows events where date matches today
  /// - "Tomorrow" filter: Shows events where date matches tomorrow
  /// - "Carnival" filter: Shows events with category containing "Carnival"
  List<Event> _applyFilters(
    List<Event> events,
    List<EventFilter> activeFilters,
  ) {
    if (activeFilters.isEmpty) {
      return events; // No filters active, return all events
    }

    return events.where((event) {
      // Check if event matches any active filter (OR logic - show if matches any)
      for (final filter in activeFilters) {
        if (_eventMatchesFilter(event, filter)) {
          return true; // Event matches at least one filter, include it
        }
      }
      return false; // Event doesn't match any filter, exclude it
    }).toList();
  }

  /// Get today's date at midnight for accurate date comparison
  DateTime _getTodayStart() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  /// Get tomorrow's date at midnight for accurate date comparison
  DateTime _getTomorrowStart() {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return DateTime(tomorrow.year, tomorrow.month, tomorrow.day);
  }

  /// Get event date at midnight for accurate date comparison
  DateTime _getEventDateStart(DateTime eventDate) {
    return DateTime(eventDate.year, eventDate.month, eventDate.day);
  }

  /// Check if an event matches a filter
  bool _eventMatchesFilter(Event event, EventFilter filter) {
    switch (filter.name) {
      case 'today':
        final eventDateStart = _getEventDateStart(event.dateTime);
        final todayStart = _getTodayStart();
        return eventDateStart == todayStart;

      case 'tomorrow':
        final eventDateStart = _getEventDateStart(event.dateTime);
        final tomorrowStart = _getTomorrowStart();
        return eventDateStart == tomorrowStart;

      case 'carnival':
        final categoryLower = event.category.toLowerCase();
        return categoryLower.contains('carnival') ||
            categoryLower == 'carnival';

      default:
        return false;
    }
  }

  Future<void> _onApplyFilter(
    ApplyFilterEvent event,
    Emitter<EventListingState> emit,
  ) async {
    if (state is EventListingLoaded) {
      final currentState = state as EventListingLoaded;

      // Update filter active status in filters list
      final updatedFilters = currentState.filters.map((filter) {
        if (filter.id == event.filter.id) {
          return filter.copyWith(isActive: true);
        }
        return filter;
      }).toList();

      final updatedActiveFilters = List<EventFilter>.from(
        currentState.activeFilters,
      );
      if (!updatedActiveFilters.contains(event.filter)) {
        updatedActiveFilters.add(event.filter.copyWith(isActive: true));
      }

      // Re-fetch events from API to get fresh data, then apply filters
      emit(currentState.copyWith(filters: updatedFilters, isLoadingMore: true));

      final result = await getPaginatedEvents(
        GetPaginatedEventsParams(
          latitude: ApiConstants.defaultLatitude,
          longitude: ApiConstants.defaultLongitude,
          page: 1,
          limit:
              ApiConstants.defaultLimit * 10, // Get more events for filtering
        ),
      );

      result.fold(
        (failure) => emit(
          currentState.copyWith(filters: updatedFilters, isLoadingMore: false),
        ),
        (paginatedResponse) {
          final filteredEvents = _applyFilters(
            paginatedResponse.events,
            updatedActiveFilters,
          );
          emit(
            currentState.copyWith(
              events: filteredEvents,
              filters: updatedFilters,
              activeFilters: updatedActiveFilters,
              isLoadingMore: false,
            ),
          );
        },
      );
    }
  }

  Future<void> _onRemoveFilter(
    RemoveFilterEvent event,
    Emitter<EventListingState> emit,
  ) async {
    if (state is EventListingLoaded) {
      final currentState = state as EventListingLoaded;

      // Update filter active status in filters list
      final updatedFilters = currentState.filters.map((filter) {
        if (filter.id == event.filter.id) {
          return filter.copyWith(isActive: false);
        }
        return filter;
      }).toList();

      final updatedActiveFilters = List<EventFilter>.from(
        currentState.activeFilters,
      )..removeWhere((f) => f.id == event.filter.id);

      // If no active filters, reload all events
      if (updatedActiveFilters.isEmpty) {
        emit(
          currentState.copyWith(filters: updatedFilters, isLoadingMore: true),
        );

        final result = await getPaginatedEvents(
          GetPaginatedEventsParams(
            latitude: ApiConstants.defaultLatitude,
            longitude: ApiConstants.defaultLongitude,
            page: 1,
            limit: ApiConstants.defaultLimit,
          ),
        );

        result.fold(
          (failure) => emit(
            currentState.copyWith(
              filters: updatedFilters,
              isLoadingMore: false,
            ),
          ),
          (paginatedResponse) => emit(
            currentState.copyWith(
              events: paginatedResponse.events,
              filters: updatedFilters,
              activeFilters: updatedActiveFilters,
              isLoadingMore: false,
              currentPage: paginatedResponse.page,
              totalPages: paginatedResponse.totalPages,
              hasMore: paginatedResponse.hasMore,
            ),
          ),
        );
      } else {
        // Re-fetch and re-apply remaining filters
        emit(
          currentState.copyWith(filters: updatedFilters, isLoadingMore: true),
        );

        final result = await getPaginatedEvents(
          GetPaginatedEventsParams(
            latitude: ApiConstants.defaultLatitude,
            longitude: ApiConstants.defaultLongitude,
            page: 1,
            limit: ApiConstants.defaultLimit * 10,
          ),
        );

        result.fold(
          (failure) => emit(
            currentState.copyWith(
              filters: updatedFilters,
              isLoadingMore: false,
            ),
          ),
          (paginatedResponse) {
            final filteredEvents = _applyFilters(
              paginatedResponse.events,
              updatedActiveFilters,
            );
            emit(
              currentState.copyWith(
                events: filteredEvents,
                filters: updatedFilters,
                activeFilters: updatedActiveFilters,
                isLoadingMore: false,
              ),
            );
          },
        );
      }
    }
  }

  Future<void> _onLoadUserBids(
    LoadUserBidsEvent event,
    Emitter<EventListingState> emit,
  ) async {
    if (state is EventListingLoaded) {
      final currentState = state as EventListingLoaded;

      final result = await getUserBids(UserBidsParams(userId: event.userId));

      result.fold(
        (failure) =>
            emit(EventListingError(message: _mapFailureToMessage(failure))),
        (bids) => emit(currentState.copyWith(userBids: bids)),
      );
    }
  }

  Future<void> _onRefreshEvents(
    RefreshEventsEvent event,
    Emitter<EventListingState> emit,
  ) async {
    if (state is EventListingLoaded) {
      final currentState = state as EventListingLoaded;
      emit(
        EventListingRefreshing(
          events: currentState.events,
          filters: currentState.filters,
          activeFilters: currentState.activeFilters,
          userBids: currentState.userBids,
        ),
      );

      final result = await getPaginatedEvents(
        GetPaginatedEventsParams(
          latitude: ApiConstants.defaultLatitude,
          longitude: ApiConstants.defaultLongitude,
          page: 1,
          limit: currentState.activeFilters.isNotEmpty
              ? ApiConstants.defaultLimit * 10
              : ApiConstants.defaultLimit,
        ),
      );

      result.fold(
        (failure) =>
            emit(EventListingError(message: _mapFailureToMessage(failure))),
        (paginatedResponse) {
          final filteredEvents = currentState.activeFilters.isNotEmpty
              ? _applyFilters(
                  paginatedResponse.events,
                  currentState.activeFilters,
                )
              : paginatedResponse.events;
          emit(
            currentState.copyWith(
              events: filteredEvents,
              currentPage: paginatedResponse.page,
              totalPages: paginatedResponse.totalPages,
              hasMore: paginatedResponse.hasMore,
            ),
          );
        },
      );
    }
  }

  void _onToggleBookmark(
    ToggleBookmarkEvent event,
    Emitter<EventListingState> emit,
  ) {
    if (state is EventListingLoaded) {
      final currentState = state as EventListingLoaded;
      // Update event bookmark status in the list
      // This is a simplified version - in production, you'd call a repository method
      emit(currentState);
    }
  }

  void _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<EventListingState> emit,
  ) {
    if (state is EventListingLoaded) {
      final currentState = state as EventListingLoaded;
      // Update event favorite status in the list
      // This is a simplified version - in production, you'd call a repository method
      emit(currentState);
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error. Please try again later.';
      case CacheFailure:
        return 'Failed to load cached data.';
      case NetworkFailure:
        return 'No internet connection. Please check your network.';
      default:
        return 'Unexpected error occurred. Please try again.';
    }
  }
}
