import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/event.dart';
import '../entities/event_detail.dart';
import '../entities/filter.dart';
import '../entities/bid.dart';

/// Event Repository interface
abstract class EventRepository {
  /// Get all events
  Future<Either<Failure, List<Event>>> getEvents();

  /// Get events with filters applied
  Future<Either<Failure, List<Event>>> getFilteredEvents(
    List<EventFilter> activeFilters,
  );

  /// Get event by ID
  Future<Either<Failure, Event>> getEventById(String eventId);

  /// Get event detail by ID (with extended information)
  Future<Either<Failure, EventDetail>> getEventDetailById(String eventId);

  /// Get available filters
  Future<Either<Failure, List<EventFilter>>> getFilters();

  /// Get user's bids
  Future<Either<Failure, List<Bid>>> getUserBids(String userId);

  /// Toggle event favorite status
  Future<Either<Failure, Event>> toggleFavorite(String eventId);

  /// Toggle event bookmark status
  Future<Either<Failure, Event>> toggleBookmark(String eventId);

  /// Search events
  Future<Either<Failure, List<Event>>> searchEvents(String query);
}
