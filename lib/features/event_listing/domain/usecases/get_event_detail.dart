import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/event_detail.dart';
import '../repositories/event_repository.dart';

/// Use case to get event detail by ID
class GetEventDetail extends UseCase<EventDetail, EventDetailParams> {
  final EventRepository repository;

  GetEventDetail(this.repository);

  @override
  Future<Either<Failure, EventDetail>> call(EventDetailParams params) async {
    return await repository.getEventDetailById(params.eventId);
  }
}

/// Parameters for event detail
class EventDetailParams extends Equatable {
  final String eventId;

  const EventDetailParams({required this.eventId});

  @override
  List<Object?> get props => [eventId];
}
