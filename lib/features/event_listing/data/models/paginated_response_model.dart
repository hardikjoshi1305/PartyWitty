import '../../domain/entities/paginated_response.dart';
import 'event_model.dart';

/// Paginated response model extending PaginatedEventsResponse entity
class PaginatedEventsResponseModel extends PaginatedEventsResponse {
  const PaginatedEventsResponseModel({
    required super.events,
    required super.total,
    required super.totalPages,
    required super.limit,
    required super.page,
    required super.count,
    required super.hasMore,
  });

  factory PaginatedEventsResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as List<dynamic>? ?? [];
    final events = data
        .map((e) => EventModel.fromApiJson(e as Map<String, dynamic>))
        .toList();

    final total = json['total'] as int? ?? 0;
    final totalPages = json['totalPages'] as int? ?? 0;
    final limit = json['limit'] as int? ?? 10;
    final page = json['page'] as int? ?? 1;
    final count = json['count'] as int? ?? 0;

    return PaginatedEventsResponseModel(
      events: events,
      total: total,
      totalPages: totalPages,
      limit: limit,
      page: page,
      count: count,
      hasMore: page < totalPages,
    );
  }

  PaginatedEventsResponse toEntity() => this;
}
