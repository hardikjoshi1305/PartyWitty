import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/event.dart';
import '../../domain/entities/event_detail.dart';
import '../../domain/entities/filter.dart';
import '../../domain/entities/bid.dart';
import '../../domain/entities/paginated_response.dart';
import '../../domain/repositories/event_repository.dart';
import '../datasources/event_remote_data_source.dart';

/// Implementation of EventRepository
class EventRepositoryImpl implements EventRepository {
  final EventRemoteDataSource remoteDataSource;

  EventRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PaginatedEventsResponse>> getPaginatedEvents({
    required double latitude,
    required double longitude,
    required int page,
    required int limit,
  }) async {
    try {
      final response = await remoteDataSource.getPaginatedEvents(
        latitude: latitude,
        longitude: longitude,
        page: page,
        limit: limit,
      );
      return Right(response.toEntity());
    } on ServerException {
      return Left(ServerFailure());
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Event>>> getEvents() async {
    try {
      final events = await remoteDataSource.getEvents();
      return Right(events);
    } on ServerException {
      return Left(ServerFailure());
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Event>>> getFilteredEvents(
    List<EventFilter> activeFilters,
  ) async {
    try {
      final filterIds = activeFilters.map((f) => f.id).toList();
      final events = await remoteDataSource.getFilteredEvents(filterIds);
      return Right(events);
    } on ServerException {
      return Left(ServerFailure());
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Event>> getEventById(String eventId) async {
    try {
      final event = await remoteDataSource.getEventById(eventId);
      return Right(event);
    } on ServerException {
      return Left(ServerFailure());
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, EventDetail>> getEventDetailById(
    String eventId,
  ) async {
    try {
      final eventDetail = await remoteDataSource.getEventDetailById(eventId);
      return Right(eventDetail);
    } on ServerException {
      return Left(ServerFailure());
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, EventDetail>> getEventDetailBySlugs({
    required String slug1,
    required String slug2,
  }) async {
    try {
      final eventDetail = await remoteDataSource.getEventDetailBySlugs(
        slug1: slug1,
        slug2: slug2,
      );
      return Right(eventDetail.toEntity());
    } on ServerException {
      return Left(ServerFailure());
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<EventFilter>>> getFilters() async {
    try {
      final filters = await remoteDataSource.getFilters();
      return Right(filters);
    } on ServerException {
      return Left(ServerFailure());
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Bid>>> getUserBids(String userId) async {
    // TODO: Implement when bid data source is available
    try {
      // Mock implementation
      await Future.delayed(const Duration(milliseconds: 500));
      return const Right([]);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Event>> toggleFavorite(String eventId) async {
    try {
      final event = await remoteDataSource.toggleFavorite(eventId);
      return Right(event);
    } on ServerException {
      return Left(ServerFailure());
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Event>> toggleBookmark(String eventId) async {
    try {
      final event = await remoteDataSource.toggleBookmark(eventId);
      return Right(event);
    } on ServerException {
      return Left(ServerFailure());
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Event>>> searchEvents(String query) async {
    try {
      final events = await remoteDataSource.searchEvents(query);
      return Right(events);
    } on ServerException {
      return Left(ServerFailure());
    } on NetworkException {
      return Left(NetworkFailure());
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
