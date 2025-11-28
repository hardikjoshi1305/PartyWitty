import '../../domain/entities/event.dart';
import '../../../../core/constants/api_constants.dart';

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
    String? slug1,
    String? slug2,
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
         slug1: slug1,
         slug2: slug2,
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
      slug1: json['slug1'] as String?,
      slug2: json['slug2'] as String?,
    );
  }

  /// Factory method to create EventModel from API response JSON
  factory EventModel.fromApiJson(Map<String, dynamic> json) {
    // Parse date and time
    final eventDate = json['event_date'] as String? ?? '';
    final eventTime = json['event_time'] as String? ?? '';
    final eventEndTime = json['event_end_time'] as String? ?? '';

    // Construct DateTime
    DateTime? dateTime;
    String timeDisplay = '';
    try {
      if (eventDate.isNotEmpty && eventTime.isNotEmpty) {
        // Parse date like "28 Nov, 2025" and time like "07:30 PM"
        final dateParts = eventDate.replaceAll(',', '').split(' ');
        if (dateParts.length >= 3) {
          final monthMap = {
            'Jan': '01',
            'Feb': '02',
            'Mar': '03',
            'Apr': '04',
            'May': '05',
            'Jun': '06',
            'Jul': '07',
            'Aug': '08',
            'Sep': '09',
            'Oct': '10',
            'Nov': '11',
            'Dec': '12',
          };
          final day = dateParts[0].padLeft(2, '0');
          final month = monthMap[dateParts[1]] ?? '01';
          final year = dateParts[2];

          // Parse time from "07:30 PM" format
          final timeParts = eventTime.replaceAll(' ', '').toUpperCase();
          String hour = '';
          String minute = '00';
          bool isPM = timeParts.contains('PM');

          if (timeParts.contains(':')) {
            final timeOnly = timeParts.split(RegExp(r'[AP]M'))[0];
            final hm = timeOnly.split(':');
            hour = hm[0].padLeft(2, '0');
            minute = hm.length > 1 ? hm[1].padLeft(2, '0') : '00';

            int h = int.parse(hour);
            if (isPM && h != 12) h += 12;
            if (!isPM && h == 12) h = 0;
            hour = h.toString().padLeft(2, '0');
          }

          final dateTimeString = '$year-$month-$day $hour:$minute:00';
          dateTime = DateTime.parse(dateTimeString);

          // Construct time display
          if (eventEndTime.isNotEmpty) {
            timeDisplay = '$eventTime - $eventEndTime';
          } else {
            timeDisplay = '$eventTime Onwards';
          }
        }
      }
    } catch (e) {
      // If parsing fails, use current date/time as fallback
      dateTime = DateTime.now();
      timeDisplay = eventTime.isNotEmpty ? '$eventTime Onwards' : '';
    }

    // Construct image URL
    final imagePath = json['image'] as String? ?? '';
    final imageUrl = imagePath.isNotEmpty
        ? '${ApiConstants.imageBaseUrl}/master/assets/uploads/$imagePath'
        : '';

    // Build inclusions list
    final inclusions = <String>[];

    if (json['fnb'] == 'yes') {
      inclusions.add('Food & Beverages');
    }
    // Add other inclusions based on available fields
    if (json['food_starter']?.toString().isNotEmpty == true) {
      inclusions.add('Starters');
    }
    if (json['sitting_confirm'] == 'yes') {
      inclusions.add('Sitting Confirmed');
    }
    if (json['kids_friendly'] == 'yes') {
      inclusions.add('Kids Friendly');
    }

    // Construct offer text
    String? offer;
    final discount = json['discount'] as String?;
    if (discount != null && discount.isNotEmpty && discount != '0') {
      offer = 'Get Flat $discount% Off';
    }

    // Venue information
    final clubName = json['clubName'] as String? ?? '';
    final clubAddress = json['clubAddress'] as String? ?? '';
    final areaName = json['areaName'] as String? ?? '';
    final cityName = json['cityName'] as String? ?? '';
    final locationShort = areaName.isNotEmpty
        ? '$areaName, $cityName'
        : cityName.isNotEmpty
        ? cityName
        : '';

    // Handle distance which can be string or number
    double distance = 0.0;

    final distanceValue = json['distance'];
    if (distanceValue != null) {
      if (distanceValue is num) {
        distance = distanceValue.toDouble();
      } else if (distanceValue is String) {
        distance = double.tryParse(distanceValue) ?? 0.0;
      }
    }
    final distanceKm = distance; // Distance is already in kilometers

    final clubLat = json['clubLat'] as String?;
    final clubLong = json['clubLong'] as String?;
    final latitude = clubLat != null && clubLat.isNotEmpty
        ? double.tryParse(clubLat)
        : null;
    final longitude = clubLong != null && clubLong.isNotEmpty
        ? double.tryParse(clubLong)
        : null;

    // Also check latitude and longitude in the main json if not in venue fields
    final latValue = json['latitude'];
    final longValue = json['longitude'];
    final finalLatitude =
        latitude ??
        (latValue != null
            ? (latValue is num
                  ? latValue.toDouble()
                  : (latValue is String ? double.tryParse(latValue) : null))
            : null);
    final finalLongitude =
        longitude ??
        (longValue != null
            ? (longValue is num
                  ? longValue.toDouble()
                  : (longValue is String ? double.tryParse(longValue) : null))
            : null);

    final venue = VenueModel(
      id: json['club_id'] as String? ?? '',
      name: clubName,
      address: clubAddress,
      locationShort: locationShort,
      rating: 0.0, // Not provided in API response
      reviewCount: 0, // Not provided in API response
      distanceKm: distanceKm,
      latitude: finalLatitude,
      longitude: finalLongitude,
    );

    return EventModel(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? '',
      description: json['event_des'] as String?,
      imageUrl: imageUrl,
      dateTime: dateTime ?? DateTime.now(),
      timeDisplay: timeDisplay,
      category: json['categoryName'] as String? ?? '',
      eventType: json['ftname'] as String? ?? '',
      artistName: clubName, // Using club name as artist name for now
      artistRole: 'Venue',
      venue: venue,
      inclusions: inclusions,
      offer: offer,
      attendeeCount: 0,
      recentAttendees: const [],
      isFavorite: false,
      isBookmarked: false,
      slug1: json['slug1'] as String?,
      slug2: json['slug2'] as String?,
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
      'slug1': slug1,
      'slug2': slug2,
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
