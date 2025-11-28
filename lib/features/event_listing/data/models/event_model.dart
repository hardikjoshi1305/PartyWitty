import '../../domain/entities/event.dart';

/// Event model extending Event entity with JSON serialization
class EventModel extends Event {
  const EventModel({
    required String id,
    required String name,
    String? description,
    required String imageUrl,
    required DateTime dateTime,
    required String timeDisplay,
    required String category,
    required String eventType,
    required String artistName,
    required String artistRole,
    required Venue venue,
    required List<String> inclusions,
    String? offer,
    int attendeeCount = 0,
    List<String> recentAttendees = const [],
    bool isFavorite = false,
    bool isBookmarked = false,
  }) : super(
         id: id,
         name: name,
         description: description,
         imageUrl: imageUrl,
         dateTime: dateTime,
         timeDisplay: timeDisplay,
         category: category,
         eventType: eventType,
         artistName: artistName,
         artistRole: artistRole,
         venue: venue,
         inclusions: inclusions,
         offer: offer,
         attendeeCount: attendeeCount,
         recentAttendees: recentAttendees,
         isFavorite: isFavorite,
         isBookmarked: isBookmarked,
       );

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      timeDisplay: json['timeDisplay'] as String,
      category: json['category'] as String,
      eventType: json['eventType'] as String,
      artistName: json['artistName'] as String,
      artistRole: json['artistRole'] as String,
      venue: VenueModel.fromJson(json['venue'] as Map<String, dynamic>),
      inclusions: (json['inclusions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      offer: json['offer'] as String?,
      attendeeCount: json['attendeeCount'] as int? ?? 0,
      recentAttendees:
          (json['recentAttendees'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      isFavorite: json['isFavorite'] as bool? ?? false,
      isBookmarked: json['isBookmarked'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'dateTime': dateTime.toIso8601String(),
      'timeDisplay': timeDisplay,
      'category': category,
      'eventType': eventType,
      'artistName': artistName,
      'artistRole': artistRole,
      'venue': VenueModel.fromVenue(venue).toJson(),
      'inclusions': inclusions,
      'offer': offer,
      'attendeeCount': attendeeCount,
      'recentAttendees': recentAttendees,
      'isFavorite': isFavorite,
      'isBookmarked': isBookmarked,
    };
  }

  Event toEntity() => this;
}

/// Venue model extending Venue entity with JSON serialization
class VenueModel extends Venue {
  const VenueModel({
    required String id,
    required String name,
    required String address,
    required String locationShort,
    required double rating,
    required int reviewCount,
    required double distanceKm,
    double? latitude,
    double? longitude,
  }) : super(
         id: id,
         name: name,
         address: address,
         locationShort: locationShort,
         rating: rating,
         reviewCount: reviewCount,
         distanceKm: distanceKm,
         latitude: latitude,
         longitude: longitude,
       );

  factory VenueModel.fromJson(Map<String, dynamic> json) {
    return VenueModel(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      locationShort: json['locationShort'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewCount: json['reviewCount'] as int,
      distanceKm: (json['distanceKm'] as num).toDouble(),
      latitude: json['latitude'] as double?,
      longitude: json['longitude'] as double?,
    );
  }

  factory VenueModel.fromVenue(Venue venue) {
    return VenueModel(
      id: venue.id,
      name: venue.name,
      address: venue.address,
      locationShort: venue.locationShort,
      rating: venue.rating,
      reviewCount: venue.reviewCount,
      distanceKm: venue.distanceKm,
      latitude: venue.latitude,
      longitude: venue.longitude,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'locationShort': locationShort,
      'rating': rating,
      'reviewCount': reviewCount,
      'distanceKm': distanceKm,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  Venue toEntity() => this;
}
