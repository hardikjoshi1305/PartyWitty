import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_events.dart';
import '../../domain/usecases/get_filtered_events.dart';
import '../../domain/usecases/get_user_bids.dart';
import 'event_listing_event.dart';
import 'event_listing_state.dart';

/// Event listing BLoC
class EventListingBloc extends Bloc<EventListingEvent, EventListingState> {
  final GetEvents getEvents;
  final GetFilteredEvents getFilteredEvents;
  final GetUserBids getUserBids;

  EventListingBloc({
    required this.getEvents,
    required this.getFilteredEvents,
    required this.getUserBids,
  }) : super(const EventListingInitial()) {
    on<LoadEventsEvent>(_onLoadEvents);
    on<ApplyFilterEvent>(_onApplyFilter);
    on<RemoveFilterEvent>(_onRemoveFilter);
    on<LoadUserBidsEvent>(_onLoadUserBids);
    on<RefreshEventsEvent>(_onRefreshEvents);
    on<ToggleBookmarkEvent>(_onToggleBookmark);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  Future<void> _onLoadEvents(
    LoadEventsEvent event,
    Emitter<EventListingState> emit,
  ) async {
    emit(const EventListingLoading());

    final eventsResult = await getEvents(NoParams());

    eventsResult.fold(
      (failure) =>
          emit(EventListingError(message: _mapFailureToMessage(failure))),
      (events) => emit(
        EventListingLoaded(
          events: events,
          filters: [], // Will be populated from repository
          activeFilters: [],
          userBids: [],
        ),
      ),
    );
  }

  Future<void> _onApplyFilter(
    ApplyFilterEvent event,
    Emitter<EventListingState> emit,
  ) async {
    if (state is EventListingLoaded) {
      final currentState = state as EventListingLoaded;
      final updatedFilters = List.of(currentState.activeFilters)
        ..add(event.filter);

      emit(EventListingLoading());

      final result = await getFilteredEvents(
        FilterParams(filters: updatedFilters),
      );

      result.fold(
        (failure) =>
            emit(EventListingError(message: _mapFailureToMessage(failure))),
        (events) => emit(
          currentState.copyWith(events: events, activeFilters: updatedFilters),
        ),
      );
    }
  }

  Future<void> _onRemoveFilter(
    RemoveFilterEvent event,
    Emitter<EventListingState> emit,
  ) async {
    if (state is EventListingLoaded) {
      final currentState = state as EventListingLoaded;
      final updatedFilters = List.of(currentState.activeFilters)
        ..remove(event.filter);

      emit(EventListingLoading());

      final result = await getFilteredEvents(
        FilterParams(filters: updatedFilters),
      );

      result.fold(
        (failure) =>
            emit(EventListingError(message: _mapFailureToMessage(failure))),
        (events) => emit(
          currentState.copyWith(events: events, activeFilters: updatedFilters),
        ),
      );
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

      final result = await getEvents(NoParams());

      result.fold(
        (failure) =>
            emit(EventListingError(message: _mapFailureToMessage(failure))),
        (events) => emit(currentState.copyWith(events: events)),
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
