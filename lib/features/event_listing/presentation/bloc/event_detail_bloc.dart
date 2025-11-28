import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/usecases/get_event_detail.dart';
import 'event_detail_event.dart';
import 'event_detail_state.dart';

/// Event detail BLoC
class EventDetailBloc extends Bloc<EventDetailEvent, EventDetailState> {
  final GetEventDetail getEventDetail;

  EventDetailBloc({required this.getEventDetail})
    : super(const EventDetailInitial()) {
    on<LoadEventDetailEvent>(_onLoadEventDetail);
    on<ToggleBookmarkEvent>(_onToggleBookmark);
    on<ToggleFavoriteEvent>(_onToggleFavorite);
  }

  Future<void> _onLoadEventDetail(
    LoadEventDetailEvent event,
    Emitter<EventDetailState> emit,
  ) async {
    emit(const EventDetailLoading());

    final result = await getEventDetail(
      EventDetailParams(eventId: event.eventId),
    );

    result.fold(
      (failure) =>
          emit(EventDetailError(message: _mapFailureToMessage(failure))),
      (eventDetail) => emit(EventDetailLoaded(eventDetail: eventDetail)),
    );
  }

  void _onToggleBookmark(
    ToggleBookmarkEvent event,
    Emitter<EventDetailState> emit,
  ) {
    if (state is EventDetailLoaded) {
      final currentState = state as EventDetailLoaded;
      // Update bookmark status
      // In production, call repository method
      emit(currentState);
    }
  }

  void _onToggleFavorite(
    ToggleFavoriteEvent event,
    Emitter<EventDetailState> emit,
  ) {
    if (state is EventDetailLoaded) {
      final currentState = state as EventDetailLoaded;
      // Update favorite status
      // In production, call repository method
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
