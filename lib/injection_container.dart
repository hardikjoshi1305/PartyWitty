import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Example: Register your feature dependencies here
  // Bloc
  // sl.registerFactory(() => ExampleBloc(useCase: sl()));

  // Use cases
  // sl.registerLazySingleton(() => ExampleUseCase(repository: sl()));

  // Repository
  // sl.registerLazySingleton<ExampleRepository>(
  //   () => ExampleRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  // );

  // Data sources
  // sl.registerLazySingleton<ExampleRemoteDataSource>(
  //   () => ExampleRemoteDataSourceImpl(client: sl()),
  // );

  //! Core
  // Add core dependencies here (e.g., network client, cache manager)

  //! External
  // Add external dependencies here (e.g., http.Client, SharedPreferences)
}
