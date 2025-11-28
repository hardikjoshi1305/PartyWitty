import 'package:equatable/equatable.dart';

/// Event entity representing a party/event in the app
class Event extends Equatable {
  final String id;
  final String name;
  final String? description;
  final String imageUrl;
  final DateTime dateTime;
  final String timeDisplay; // e.g., "Today | 10:00 PM Onwards"
  final String category; // e.g., "Carnival", "Social"
  final String eventType; // e.g., "Stand-up Comedy", "Live Music"
  final String artistName;
  final String artistRole; // e.g., "Artist", "DJ"
  final Venue venue;
  final List<String> inclusions; // e.g., ["3 Starters", "2 Main Course"]
  final String? offer; // e.g., "Get Flat 25% Off On Food & Beverages"
  final int attendeeCount; // Number of people who attended
  final List<String> recentAttendees; // Names of recent attendees
  final bool isFavorite;
  final bool isBookmarked;

  const Event({
    required this.id,
    required this.name,
    this.description,
    required this.imageUrl,
    required this.dateTime,
    required this.timeDisplay,
    required this.category,
    required this.eventType,
    required this.artistName,
    required this.artistRole,
    required this.venue,
    required this.inclusions,
    this.offer,
    this.attendeeCount = 0,
    this.recentAttendees = const [],
    this.isFavorite = false,
    this.isBookmarked = false,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    imageUrl,
    dateTime,
    timeDisplay,
    category,
    eventType,
    artistName,
    artistRole,
    venue,
    inclusions,
    offer,
    attendeeCount,
    recentAttendees,
    isFavorite,
    isBookmarked,
  ];
}

/// Venue entity representing event location
class Venue extends Equatable {
  final String id;
  final String name;
  final String address;
  final String locationShort; // e.g., "DLP Phase 3, Gurugram"
  final double rating;
  final int reviewCount;
  final double distanceKm;
  final double? latitude;
  final double? longitude;

  const Venue({
    required this.id,
    required this.name,
    required this.address,
    required this.locationShort,
    required this.rating,
    required this.reviewCount,
    required this.distanceKm,
    this.latitude,
    this.longitude,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    address,
    locationShort,
    rating,
    reviewCount,
    distanceKm,
    latitude,
    longitude,
  ];
}
