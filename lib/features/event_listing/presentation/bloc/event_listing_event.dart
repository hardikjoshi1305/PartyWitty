import 'package:equatable/equatable.dart';
import '../../domain/entities/filter.dart';

/// Event listing events
abstract class EventListingEvent extends Equatable {
  const EventListingEvent();

  @override
  List<Object?> get props => [];
}

/// Load events
class LoadEventsEvent extends EventListingEvent {
  const LoadEventsEvent();
}

/// Apply filter
class ApplyFilterEvent extends EventListingEvent {
  final EventFilter filter;

  const ApplyFilterEvent(this.filter);

  @override
  List<Object?> get props => [filter];
}

/// Remove filter
class RemoveFilterEvent extends EventListingEvent {
  final EventFilter filter;

  const RemoveFilterEvent(this.filter);

  @override
  List<Object?> get props => [filter];
}

/// Toggle event bookmark
class ToggleBookmarkEvent extends EventListingEvent {
  final String eventId;

  const ToggleBookmarkEvent(this.eventId);

  @override
  List<Object?> get props => [eventId];
}

/// Toggle event favorite
class ToggleFavoriteEvent extends EventListingEvent {
  final String eventId;

  const ToggleFavoriteEvent(this.eventId);

  @override
  List<Object?> get props => [eventId];
}

/// Load user bids
class LoadUserBidsEvent extends EventListingEvent {
  final String userId;

  const LoadUserBidsEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

/// Refresh events
class RefreshEventsEvent extends EventListingEvent {
  const RefreshEventsEvent();
}

/// Load more events (pagination)
class LoadMoreEventsEvent extends EventListingEvent {
  const LoadMoreEventsEvent();
}
