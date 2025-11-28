import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../models/event_model.dart';
import '../models/event_detail_model.dart';
import '../models/filter_model.dart';
import '../models/paginated_response_model.dart';

/// Remote data source for events (API calls)
abstract class EventRemoteDataSource {
  /// Fetch paginated events from API
  Future<PaginatedEventsResponseModel> getPaginatedEvents({
    required double latitude,
    required double longitude,
    required int page,
    required int limit,
  });

  /// Fetch all events from API
  Future<List<EventModel>> getEvents();

  /// Fetch filtered events from API
  Future<List<EventModel>> getFilteredEvents(List<String> filterIds);

  /// Fetch event by ID from API
  Future<EventModel> getEventById(String eventId);

  /// Fetch event detail by ID from API (with extended information)
  Future<EventDetailModel> getEventDetailById(String eventId);

  /// Fetch event detail by slugs from API (with extended information)
  Future<EventDetailModel> getEventDetailBySlugs({
    required String slug1,
    required String slug2,
  });

  /// Fetch available filters from API
  Future<List<FilterModel>> getFilters();

  /// Toggle event favorite
  Future<EventModel> toggleFavorite(String eventId);

  /// Toggle event bookmark
  Future<EventModel> toggleBookmark(String eventId);

  /// Search events
  Future<List<EventModel>> searchEvents(String query);
}

/// Implementation of EventRemoteDataSource
class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  final http.Client client;

  EventRemoteDataSourceImpl({required this.client});

  @override
  Future<PaginatedEventsResponseModel> getPaginatedEvents({
    required double latitude,
    required double longitude,
    required int page,
    required int limit,
  }) async {
    try {
      final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.allEventsEndpoint}',
      );

      // Create multipart request
      final request = http.MultipartRequest('POST', url);

      // Add form fields
      request.fields['latitude'] = latitude.toString();
      request.fields['longitude'] = longitude.toString();
      request.fields['limit'] = limit.toString();
      request.fields['page'] = page.toString();

      // Send request
      final streamedResponse = await client
          .send(request)
          .timeout(const Duration(seconds: 30));

      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as Map<String, dynamic>;

        // Check if status is true
        if (jsonResponse['status'] == true) {
          return PaginatedEventsResponseModel.fromJson(jsonResponse);
        } else {
          throw ServerException();
        }
      } else {
        throw ServerException();
      }
    } catch (e) {
      if (e is ServerException) {
        rethrow;
      } else if (e is http.ClientException ||
          e.toString().contains('SocketException')) {
        throw NetworkException();
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<List<EventModel>> getEvents() async {
    // TODO: Implement API call
    // final response = await client.get(
    //   Uri.parse('${ApiConstants.baseUrl}/events'),
    // );
    // if (response.statusCode == 200) {
    //   final data = json.decode(response.body) as List;
    //   return data.map((e) => EventModel.fromJson(e)).toList();
    // } else {
    //   throw ServerException();
    // }

    // Mock implementation
    await Future.delayed(const Duration(milliseconds: 500));
    return _getMockEvents();
  }

  @override
  Future<List<EventModel>> getFilteredEvents(List<String> filterIds) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(milliseconds: 500));
    return _getMockEvents();
  }

  @override
  Future<EventModel> getEventById(String eventId) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(milliseconds: 500));
    return _getMockEvents().first;
  }

  @override
  Future<EventDetailModel> getEventDetailById(String eventId) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(milliseconds: 500));
    return _getMockEventDetail();
  }

  @override
  Future<EventDetailModel> getEventDetailBySlugs({
    required String slug1,
    required String slug2,
  }) async {
    try {
      final url = Uri.parse(
        '${ApiConstants.baseUrl}${ApiConstants.eventDetailsEndpoint}',
      );

      // Create multipart request
      final request = http.MultipartRequest('POST', url);

      // Add form fields
      request.fields['slug1'] = slug1;
      request.fields['slug2'] = slug2;
      print(slug1);
      print(slug2);
      print(url);

      // Send request
      final streamedResponse = await client
          .send(request)
          .timeout(const Duration(seconds: 30));

      final response = await http.Response.fromStream(streamedResponse);
      print(response.body.toString());

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body) as Map<String, dynamic>;

        // Check if status is true
        if (jsonResponse['status'] == true && jsonResponse['data'] != null) {
          try {
            final data = jsonResponse['data'] as Map<String, dynamic>;
            print('Parsing event detail data...');
            final eventDetail = EventDetailModel.fromApiJson(data);
            print('Event detail parsed successfully');
            return eventDetail;
          } catch (parseError, stackTrace) {
            print('Error parsing event detail: $parseError');
            print('Error type: ${parseError.runtimeType}');
            print('Stack trace: $stackTrace');
            rethrow; // Re-throw to be caught by outer catch
          }
        } else {

          final msg = jsonResponse['msg'] as String? ?? 'Unknown error';
          print('API returned error: $msg');
          throw ServerException();
        }
      } else {
        print('HTTP error status: ${response.statusCode}');
        throw ServerException();
      }
    } catch (e, stackTrace) {
      print('Exception in getEventDetailBySlugs: $e');
      print('Exception type: ${e.runtimeType}');
      print('Stack trace: $stackTrace');
      if (e is ServerException) {
        rethrow;
      } else if (e is http.ClientException ||
          e.toString().contains('SocketException')) {
        throw NetworkException();
      } else {
        // If it's a parsing error, it will be caught here
        print('Unexpected error, converting to ServerException: $e');
        throw ServerException();
      }
    }
  }

  @override
  Future<List<FilterModel>> getFilters() async {
    // TODO: Implement API call
    await Future.delayed(const Duration(milliseconds: 500));
    return _getMockFilters();
  }

  @override
  Future<EventModel> toggleFavorite(String eventId) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(milliseconds: 500));
    return _getMockEvents().first;
  }

  @override
  Future<EventModel> toggleBookmark(String eventId) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(milliseconds: 500));
    return _getMockEvents().first;
  }

  @override
  Future<List<EventModel>> searchEvents(String query) async {
    // TODO: Implement API call
    await Future.delayed(const Duration(milliseconds: 500));
    return _getMockEvents();
  }

  // Mock data
  List<EventModel> _getMockEvents() {
    return [
      EventModel(
        id: '1',
        name: 'Sitar Magic by Rishabh Rikhiram Sharma...',
        imageUrl: 'https://example.com/event1.jpg',
        dateTime: DateTime.now(),
        timeDisplay: 'Today | 10:00 PM Onwards',
        category: 'Carnival',
        eventType: 'Stand-up Comedy',
        artistName: 'Malvika Khanna',
        artistRole: 'Artist',
        venue: const VenueModel(
          id: '1',
          name: 'F-Bar',
          address: 'DLP Phase 3, Gurugram, Haryana',
          locationShort: 'DLP Phase 3, Gurugram',
          rating: 4.1,
          reviewCount: 3,
          distanceKm: 1.2,
        ),
        inclusions: [
          '3 Starters',
          '2 Main Course',
          '1 Dessert',
          '2 Drinks',
          '1 Appetizer',
          'Live Music',
          'DJ',
          'Dance Floor',
          'Valet Parking',
          'Air Conditioning',
        ],
        offer: 'Get Flat 25% Off On Food & Bever.',
        attendeeCount: 7,
        recentAttendees: ['Rohit Sharma'],
      ),
    ];
  }

  List<FilterModel> _getMockFilters() {
    return const [
      FilterModel(
        id: '1',
        name: 'carnival',
        displayName: 'Carnival',
        isActive: false,
      ),
      FilterModel(
        id: '2',
        name: 'social',
        displayName: 'Social',
        count: 32,
        isActive: false,
      ),
      FilterModel(
        id: '3',
        name: 'live_music',
        displayName: 'Live Music',
        isActive: false,
      ),
      FilterModel(
        id: '4',
        name: 'underground',
        displayName: 'Underground',
        isActive: false,
      ),
    ];
  }

  EventDetailModel _getMockEventDetail() {
    final mockEvent = _getMockEvents().first;
    return EventDetailModel(
      event: mockEvent,
      price: 50.0,
      validity: 'Valid For Max 10 Person',
      aboutText:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
      imageUrls: [
        mockEvent.imageUrl,
        'https://example.com/event1-2.jpg',
        'https://example.com/event1-3.jpg',
      ],
      menuCategories: [
        MenuCategoryModel(
          id: '1',
          name: 'STARTERS',
          items: [
            MenuItemModel(
              id: '1',
              name: 'Chicken Tenders',
              imageUrl: 'https://example.com/chicken.jpg',
              price: 250.0,
            ),
            MenuItemModel(
              id: '2',
              name: 'Caesar Salad',
              imageUrl: 'https://example.com/salad.jpg',
              price: 180.0,
            ),
          ],
        ),
        MenuCategoryModel(
          id: '2',
          name: 'MAIN COURSE',
          items: [
            MenuItemModel(
              id: '3',
              name: 'Grilled Chicken',
              imageUrl: 'https://example.com/grilled.jpg',
              price: 450.0,
            ),
          ],
        ),
      ],
      offerBoxes: [
        OfferBoxModel(
          id: '1',
          title: 'Save flat ₹200 on Total Bill',
          code: 'TEASERREWARD20',
          buttonText: 'Watch Teaser',
          iconName: 'cheers',
        ),
        OfferBoxModel(
          id: '2',
          title: 'Upto 50% Off On Food & Beverages Bill',
          buttonText: 'Pre-Booking',
          iconName: 'dancing',
        ),
      ],
    );
  }
}
