import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

// Features - Event Listing
import 'features/event_listing/data/datasources/event_remote_data_source.dart';
import 'features/event_listing/data/repositories/event_repository_impl.dart';
import 'features/event_listing/domain/repositories/event_repository.dart';
import 'features/event_listing/domain/usecases/get_paginated_events.dart';
import 'features/event_listing/domain/usecases/get_filtered_events.dart';
import 'features/event_listing/domain/usecases/get_user_bids.dart';
import 'features/event_listing/domain/usecases/get_event_detail.dart';
import 'features/event_listing/presentation/bloc/event_listing_bloc.dart';
import 'features/event_listing/presentation/bloc/event_detail_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Event Listing
  // Bloc
  sl.registerFactory(
    () => EventListingBloc(
      getPaginatedEvents: sl(),
      getFilteredEvents: sl(),
      getUserBids: sl(),
    ),
  );

  sl.registerFactory(() => EventDetailBloc(getEventDetail: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetPaginatedEvents(sl()));
  sl.registerLazySingleton(() => GetFilteredEvents(sl()));
  sl.registerLazySingleton(() => GetUserBids(sl()));
  sl.registerLazySingleton(() => GetEventDetail(sl()));

  // Repository
  sl.registerLazySingleton<EventRepository>(
    () => EventRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<EventRemoteDataSource>(
    () => EventRemoteDataSourceImpl(client: sl()),
  );

  //! Core
  // Add core dependencies here (e.g., network client, cache manager)

  //! External
  sl.registerLazySingleton(() => http.Client());
}
