import 'package:equatable/equatable.dart';
import '../../domain/entities/event.dart';
import '../../domain/entities/filter.dart';
import '../../domain/entities/bid.dart';

/// Event listing states
abstract class EventListingState extends Equatable {
  const EventListingState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class EventListingInitial extends EventListingState {
  const EventListingInitial();
}

/// Loading state
class EventListingLoading extends EventListingState {
  const EventListingLoading();
}

/// Loaded state
class EventListingLoaded extends EventListingState {
  final List<Event> events;
  final List<EventFilter> filters;
  final List<EventFilter> activeFilters;
  final List<Bid> userBids;

  const EventListingLoaded({
    required this.events,
    required this.filters,
    required this.activeFilters,
    required this.userBids,
  });

  EventListingLoaded copyWith({
    List<Event>? events,
    List<EventFilter>? filters,
    List<EventFilter>? activeFilters,
    List<Bid>? userBids,
  }) {
    return EventListingLoaded(
      events: events ?? this.events,
      filters: filters ?? this.filters,
      activeFilters: activeFilters ?? this.activeFilters,
      userBids: userBids ?? this.userBids,
    );
  }

  @override
  List<Object?> get props => [events, filters, activeFilters, userBids];
}

/// Error state
class EventListingError extends EventListingState {
  final String message;

  const EventListingError({required this.message});

  @override
  List<Object?> get props => [message];
}

/// Refreshing state (keeps showing previous data)
class EventListingRefreshing extends EventListingState {
  final List<Event> events;
  final List<EventFilter> filters;
  final List<EventFilter> activeFilters;
  final List<Bid> userBids;

  const EventListingRefreshing({
    required this.events,
    required this.filters,
    required this.activeFilters,
    required this.userBids,
  });

  @override
  List<Object?> get props => [events, filters, activeFilters, userBids];
}
