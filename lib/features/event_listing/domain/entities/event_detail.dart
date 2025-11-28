import 'package:equatable/equatable.dart';
import 'event.dart';

/// Extended event detail entity with additional information
class EventDetail extends Equatable {
  final Event event;
  final double? price; // e.g., 50.0 for ₹50
  final String? validity; // e.g., "Valid For Max 10 Person"
  final String? aboutText; // About the event description
  final List<String> imageUrls; // Multiple images for carousel
  final List<MenuCategory> menuCategories; // Menu items
  final List<OfferBox> offerBoxes; // Promotion boxes

  const EventDetail({
    required this.event,
    this.price,
    this.validity,
    this.aboutText,
    this.imageUrls = const [],
    this.menuCategories = const [],
    this.offerBoxes = const [],
  });

  @override
  List<Object?> get props => [
    event,
    price,
    validity,
    aboutText,
    imageUrls,
    menuCategories,
    offerBoxes,
  ];
}

/// Menu category with items
class MenuCategory extends Equatable {
  final String id;
  final String name; // e.g., "STARTERS", "MAIN COURSE"
  final List<MenuItem> items;

  const MenuCategory({
    required this.id,
    required this.name,
    required this.items,
  });

  @override
  List<Object?> get props => [id, name, items];
}

/// Menu item
class MenuItem extends Equatable {
  final String id;
  final String name;
  final String? imageUrl;
  final double? price;
  final String? description;

  const MenuItem({
    required this.id,
    required this.name,
    this.imageUrl,
    this.price,
    this.description,
  });

  @override
  List<Object?> get props => [id, name, imageUrl, price, description];
}

/// Offer/Promotion box
class OfferBox extends Equatable {
  final String id;
  final String title; // e.g., "Save flat ₹200 on Total Bill"
  final String? code; // e.g., "TEASERREWARD20"
  final String? buttonText; // e.g., "Watch Teaser", "Pre-Booking"
  final String? iconName; // e.g., "cheers", "dancing"

  const OfferBox({
    required this.id,
    required this.title,
    this.code,
    this.buttonText,
    this.iconName,
  });

  @override
  List<Object?> get props => [id, title, code, buttonText, iconName];
}
