import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/event.dart';
import '../entities/filter.dart';
import '../repositories/event_repository.dart';

/// Use case to get filtered events
class GetFilteredEvents extends UseCase<List<Event>, FilterParams> {
  final EventRepository repository;

  GetFilteredEvents(this.repository);

  @override
  Future<Either<Failure, List<Event>>> call(FilterParams params) async {
    return await repository.getFilteredEvents(params.filters);
  }
}

/// Parameters for filtered events
class FilterParams extends Equatable {
  final List<EventFilter> filters;

  const FilterParams({required this.filters});

  @override
  List<Object?> get props => [filters];
}
