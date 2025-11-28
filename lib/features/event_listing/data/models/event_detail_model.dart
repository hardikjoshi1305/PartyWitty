import '../../domain/entities/event.dart';
import '../../domain/entities/event_detail.dart';
import 'event_model.dart';

/// Event detail model extending EventDetail entity with JSON serialization
class EventDetailModel extends EventDetail {
  const EventDetailModel({
    required Event event,
    double? price,
    String? validity,
    String? aboutText,
    List<String> imageUrls = const [],
    List<MenuCategory> menuCategories = const [],
    List<OfferBox> offerBoxes = const [],
  }) : super(
         event: event,
         price: price,
         validity: validity,
         aboutText: aboutText,
         imageUrls: imageUrls,
         menuCategories: menuCategories,
         offerBoxes: offerBoxes,
       );

  factory EventDetailModel.fromJson(Map<String, dynamic> json) {
    return EventDetailModel(
      event: EventModel.fromJson(json['event'] as Map<String, dynamic>),
      price: (json['price'] as num?)?.toDouble(),
      validity: json['validity'] as String?,
      aboutText: json['aboutText'] as String?,
      imageUrls:
          (json['imageUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      menuCategories:
          (json['menuCategories'] as List<dynamic>?)
              ?.map(
                (e) => MenuCategoryModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
      offerBoxes:
          (json['offerBoxes'] as List<dynamic>?)
              ?.map((e) => OfferBoxModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    final eventModel = event is EventModel
        ? event as EventModel
        : EventModel(
            id: event.id,
            name: event.name,
            description: event.description,
            imageUrl: event.imageUrl,
            dateTime: event.dateTime,
            timeDisplay: event.timeDisplay,
            category: event.category,
            eventType: event.eventType,
            artistName: event.artistName,
            artistRole: event.artistRole,
            venue: VenueModel.fromVenue(event.venue),
            inclusions: event.inclusions,
            offer: event.offer,
            attendeeCount: event.attendeeCount,
            recentAttendees: event.recentAttendees,
            isFavorite: event.isFavorite,
            isBookmarked: event.isBookmarked,
          );

    return {
      'event': eventModel.toJson(),
      'price': price,
      'validity': validity,
      'aboutText': aboutText,
      'imageUrls': imageUrls,
      'menuCategories': menuCategories
          .map((e) => MenuCategoryModel.fromMenuCategory(e).toJson())
          .toList(),
      'offerBoxes': offerBoxes
          .map((e) => OfferBoxModel.fromOfferBox(e).toJson())
          .toList(),
    };
  }

  EventDetail toEntity() => this;
}

/// Menu category model
class MenuCategoryModel extends MenuCategory {
  const MenuCategoryModel({
    required String id,
    required String name,
    required List<MenuItem> items,
  }) : super(id: id, name: name, items: items);

  factory MenuCategoryModel.fromJson(Map<String, dynamic> json) {
    return MenuCategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => MenuItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  factory MenuCategoryModel.fromMenuCategory(MenuCategory category) {
    return MenuCategoryModel(
      id: category.id,
      name: category.name,
      items: category.items,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'items': items
          .map((e) => MenuItemModel.fromMenuItem(e).toJson())
          .toList(),
    };
  }

  MenuCategory toEntity() => this;
}

/// Menu item model
class MenuItemModel extends MenuItem {
  const MenuItemModel({
    required String id,
    required String name,
    String? imageUrl,
    double? price,
    String? description,
  }) : super(
         id: id,
         name: name,
         imageUrl: imageUrl,
         price: price,
         description: description,
       );

  factory MenuItemModel.fromJson(Map<String, dynamic> json) {
    return MenuItemModel(
      id: json['id'] as String,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      description: json['description'] as String?,
    );
  }

  factory MenuItemModel.fromMenuItem(MenuItem item) {
    return MenuItemModel(
      id: item.id,
      name: item.name,
      imageUrl: item.imageUrl,
      price: item.price,
      description: item.description,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'price': price,
      'description': description,
    };
  }

  MenuItem toEntity() => this;
}

/// Offer box model
class OfferBoxModel extends OfferBox {
  const OfferBoxModel({
    required String id,
    required String title,
    String? code,
    String? buttonText,
    String? iconName,
  }) : super(
         id: id,
         title: title,
         code: code,
         buttonText: buttonText,
         iconName: iconName,
       );

  factory OfferBoxModel.fromJson(Map<String, dynamic> json) {
    return OfferBoxModel(
      id: json['id'] as String,
      title: json['title'] as String,
      code: json['code'] as String?,
      buttonText: json['buttonText'] as String?,
      iconName: json['iconName'] as String?,
    );
  }

  factory OfferBoxModel.fromOfferBox(OfferBox box) {
    return OfferBoxModel(
      id: box.id,
      title: box.title,
      code: box.code,
      buttonText: box.buttonText,
      iconName: box.iconName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'code': code,
      'buttonText': buttonText,
      'iconName': iconName,
    };
  }

  OfferBox toEntity() => this;
}
