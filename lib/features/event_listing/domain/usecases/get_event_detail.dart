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
    if (params.slug1 != null && params.slug2 != null) {
      return await repository.getEventDetailBySlugs(
        slug1: params.slug1!,
        slug2: params.slug2!,
      );
    } else if (params.eventId != null) {
      return await repository.getEventDetailById(params.eventId!);
    } else {
      return Left(ServerFailure());
    }
  }
}

/// Parameters for event detail
class EventDetailParams extends Equatable {
  final String? eventId;
  final String? slug1;
  final String? slug2;

  const EventDetailParams({this.eventId, this.slug1, this.slug2});

  @override
  List<Object?> get props => [eventId, slug1, slug2];
}
