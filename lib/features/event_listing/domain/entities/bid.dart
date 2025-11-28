import 'package:equatable/equatable.dart';
import 'event.dart';

/// Bid entity representing a user's bid on an event
class Bid extends Equatable {
  final String id;
  final String userId;
  final Event event;
  final double bidAmount;
  final DateTime bidTime;
  final BidStatus status;

  const Bid({
    required this.id,
    required this.userId,
    required this.event,
    required this.bidAmount,
    required this.bidTime,
    required this.status,
  });

  @override
  List<Object?> get props => [id, userId, event, bidAmount, bidTime, status];
}

/// Bid status enum
enum BidStatus { pending, accepted, rejected, expired }
