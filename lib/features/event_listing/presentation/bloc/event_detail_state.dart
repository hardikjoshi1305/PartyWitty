import 'package:equatable/equatable.dart';
import '../../domain/entities/event_detail.dart';

/// Event detail states
abstract class EventDetailState extends Equatable {
  const EventDetailState();

  @override
  List<Object?> get props => [];
}

/// Initial state
class EventDetailInitial extends EventDetailState {
  const EventDetailInitial();
}

/// Loading state
class EventDetailLoading extends EventDetailState {
  const EventDetailLoading();
}

/// Loaded state
class EventDetailLoaded extends EventDetailState {
  final EventDetail eventDetail;

  const EventDetailLoaded({required this.eventDetail});

  EventDetailLoaded copyWith({EventDetail? eventDetail}) {
    return EventDetailLoaded(eventDetail: eventDetail ?? this.eventDetail);
  }

  @override
  List<Object?> get props => [eventDetail];
}

/// Error state
class EventDetailError extends EventDetailState {
  final String message;

  const EventDetailError({required this.message});

  @override
  List<Object?> get props => [message];
}
