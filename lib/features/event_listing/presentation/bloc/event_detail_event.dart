import 'package:equatable/equatable.dart';

/// Event detail events
abstract class EventDetailEvent extends Equatable {
  const EventDetailEvent();

  @override
  List<Object?> get props => [];
}

/// Load event detail
class LoadEventDetailEvent extends EventDetailEvent {
  final String eventId;

  const LoadEventDetailEvent(this.eventId);

  @override
  List<Object?> get props => [eventId];
}

/// Toggle bookmark
class ToggleBookmarkEvent extends EventDetailEvent {
  final String eventId;

  const ToggleBookmarkEvent(this.eventId);

  @override
  List<Object?> get props => [eventId];
}

/// Toggle favorite
class ToggleFavoriteEvent extends EventDetailEvent {
  final String eventId;

  const ToggleFavoriteEvent(this.eventId);

  @override
  List<Object?> get props => [eventId];
}
