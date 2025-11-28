import 'package:equatable/equatable.dart';

/// Event detail events
abstract class EventDetailEvent extends Equatable {
  const EventDetailEvent();

  @override
  List<Object?> get props => [];
}

/// Load event detail
class LoadEventDetailEvent extends EventDetailEvent {
  final String? eventId;
  final String? slug1;
  final String? slug2;

  const LoadEventDetailEvent({this.eventId, this.slug1, this.slug2});

  @override
  List<Object?> get props => [eventId, slug1, slug2];
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
