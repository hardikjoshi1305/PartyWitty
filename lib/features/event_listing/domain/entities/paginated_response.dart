import 'package:equatable/equatable.dart';
import 'event.dart';

/// Paginated response entity
class PaginatedEventsResponse extends Equatable {
  final List<Event> events;
  final int total;
  final int totalPages;
  final int limit;
  final int page;
  final int count;
  final bool hasMore;

  const PaginatedEventsResponse({
    required this.events,
    required this.total,
    required this.totalPages,
    required this.limit,
    required this.page,
    required this.count,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [
    events,
    total,
    totalPages,
    limit,
    page,
    count,
    hasMore,
  ];
}
