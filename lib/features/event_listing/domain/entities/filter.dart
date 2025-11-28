import 'package:equatable/equatable.dart';

/// Filter entity for event filtering
class EventFilter extends Equatable {
  final String id;
  final String name;
  final String displayName;
  final int? count; // Optional count, e.g., "Social (32)"
  final bool isActive;

  const EventFilter({
    required this.id,
    required this.name,
    required this.displayName,
    this.count,
    this.isActive = false,
  });

  EventFilter copyWith({
    String? id,
    String? name,
    String? displayName,
    int? count,
    bool? isActive,
  }) {
    return EventFilter(
      id: id ?? this.id,
      name: name ?? this.name,
      displayName: displayName ?? this.displayName,
      count: count ?? this.count,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props => [id, name, displayName, count, isActive];
}
