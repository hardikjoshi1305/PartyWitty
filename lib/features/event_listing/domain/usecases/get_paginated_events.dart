import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/paginated_response.dart';
import '../repositories/event_repository.dart';

/// Parameters for GetPaginatedEvents use case
class GetPaginatedEventsParams extends Equatable {
  final double latitude;
  final double longitude;
  final int page;
  final int limit;

  const GetPaginatedEventsParams({
    required this.latitude,
    required this.longitude,
    required this.page,
    required this.limit,
  });

  @override
  List<Object> get props => [latitude, longitude, page, limit];
}

/// Use case to get paginated events
class GetPaginatedEvents
    extends UseCase<PaginatedEventsResponse, GetPaginatedEventsParams> {
  final EventRepository repository;

  GetPaginatedEvents(this.repository);

  @override
  Future<Either<Failure, PaginatedEventsResponse>> call(
    GetPaginatedEventsParams params,
  ) async {
    return await repository.getPaginatedEvents(
      latitude: params.latitude,
      longitude: params.longitude,
      page: params.page,
      limit: params.limit,
    );
  }
}
