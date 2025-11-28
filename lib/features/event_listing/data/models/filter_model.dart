import '../../domain/entities/filter.dart';

/// Filter model extending EventFilter entity with JSON serialization
class FilterModel extends EventFilter {
  const FilterModel({
    required String id,
    required String name,
    required String displayName,
    int? count,
    bool isActive = false,
  }) : super(
         id: id,
         name: name,
         displayName: displayName,
         count: count,
         isActive: isActive,
       );

  factory FilterModel.fromJson(Map<String, dynamic> json) {
    return FilterModel(
      id: json['id'] as String,
      name: json['name'] as String,
      displayName: json['displayName'] as String,
      count: json['count'] as int?,
      isActive: json['isActive'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'displayName': displayName,
      'count': count,
      'isActive': isActive,
    };
  }

  EventFilter toEntity() => this;
}
