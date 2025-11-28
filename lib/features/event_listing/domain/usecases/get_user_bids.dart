import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/bid.dart';
import '../repositories/event_repository.dart';

/// Use case to get user's bids
class GetUserBids extends UseCase<List<Bid>, UserBidsParams> {
  final EventRepository repository;

  GetUserBids(this.repository);

  @override
  Future<Either<Failure, List<Bid>>> call(UserBidsParams params) async {
    return await repository.getUserBids(params.userId);
  }
}

/// Parameters for user bids
class UserBidsParams extends Equatable {
  final String userId;

  const UserBidsParams({required this.userId});

  @override
  List<Object?> get props => [userId];
}
