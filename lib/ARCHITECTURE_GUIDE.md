# PartyWitty - Clean Architecture Guide

## Project Structure Overview

```
lib/
├── core/                          # Shared code across features
│   ├── constants/                 # App-wide constants
│   │   ├── api_constants.dart     # API URLs, endpoints
│   │   └── app_constants.dart     # App configuration
│   ├── errors/                    # Error handling
│   │   ├── exceptions.dart        # Exception classes
│   │   └── failures.dart          # Failure classes for Either
│   ├── usecases/                  # Base use case
│   │   └── usecase.dart           # Abstract UseCase class
│   └── utils/                     # Utility functions
│
├── features/                      # Feature modules
│   └── example_feature/           # Example feature structure
│       ├── data/                  # Data layer
│       │   ├── datasources/       # Remote & local data sources
│       │   ├── models/            # Data models (JSON serialization)
│       │   └── repositories/      # Repository implementations
│       ├── domain/                # Business logic layer
│       │   ├── entities/          # Business objects
│       │   ├── repositories/      # Repository contracts (interfaces)
│       │   └── usecases/          # Business use cases
│       └── presentation/          # UI layer
│           ├── bloc/              # BLoC state management
│           ├── pages/             # Full-screen pages
│           └── widgets/           # Reusable UI components
│
├── injection_container.dart       # Dependency injection setup
└── main.dart                      # App entry point
```

## Clean Architecture Layers

### 1. Domain Layer (Innermost - Pure Business Logic)
- **Entities**: Business models with no external dependencies
- **Repository Interfaces**: Contracts defining data operations
- **Use Cases**: Single-responsibility business operations

**Example Entity:**
```dart
// domain/entities/user.dart
class User extends Equatable {
  final String id;
  final String name;
  final String email;

  const User({required this.id, required this.name, required this.email});

  @override
  List<Object> get props => [id, name, email];
}
```

**Example Repository Interface:**
```dart
// domain/repositories/user_repository.dart
abstract class UserRepository {
  Future<Either<Failure, User>> getUser(String id);
  Future<Either<Failure, List<User>>> getUsers();
}
```

**Example Use Case:**
```dart
// domain/usecases/get_user.dart
class GetUser extends UseCase<User, String> {
  final UserRepository repository;

  GetUser(this.repository);

  @override
  Future<Either<Failure, User>> call(String userId) async {
    return await repository.getUser(userId);
  }
}
```

### 2. Data Layer (Data Management)
- **Models**: Extend entities, handle JSON serialization
- **Data Sources**: Remote (API) and Local (Cache/DB)
- **Repository Implementations**: Implement domain repository interfaces

**Example Model:**
```dart
// data/models/user_model.dart
class UserModel extends User {
  const UserModel({
    required String id,
    required String name,
    required String email,
  }) : super(id: id, name: name, email: email);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
```

**Example Data Source:**
```dart
// data/datasources/user_remote_data_source.dart
abstract class UserRemoteDataSource {
  Future<UserModel> getUser(String id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> getUser(String id) async {
    final response = await client.get(
      Uri.parse('${ApiConstants.baseUrl}/users/$id'),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
```

**Example Repository Implementation:**
```dart
// data/repositories/user_repository_impl.dart
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, User>> getUser(String id) async {
    try {
      final user = await remoteDataSource.getUser(id);
      await localDataSource.cacheUser(user);
      return Right(user);
    } on ServerException {
      return Left(ServerFailure());
    } on NetworkException {
      return Left(NetworkFailure());
    }
  }
}
```

### 3. Presentation Layer (UI)
- **BLoC**: State management (Events → BLoC → States)
- **Pages**: Full-screen views
- **Widgets**: Reusable UI components

**Example BLoC:**
```dart
// presentation/bloc/user_bloc.dart
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUser getUser;

  UserBloc({required this.getUser}) : super(UserInitial()) {
    on<GetUserByIdEvent>((event, emit) async {
      emit(UserLoading());
      
      final result = await getUser(event.userId);
      
      result.fold(
        (failure) => emit(UserError(message: _mapFailureToMessage(failure))),
        (user) => emit(UserLoaded(user: user)),
      );
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error. Please try again.';
      case NetworkFailure:
        return 'No internet connection.';
      default:
        return 'Unexpected error occurred.';
    }
  }
}
```

## Dependency Injection with GetIt

Register all dependencies in `injection_container.dart`:

```dart
Future<void> init() async {
  //! Features - User
  // Bloc
  sl.registerFactory(
    () => UserBloc(getUser: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetUser(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(client: sl()),
  );

  //! Core
  
  //! External
  sl.registerLazySingleton(() => http.Client());
}
```

## Required Packages

Add these to your `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  flutter_bloc: ^8.1.3
  
  # Functional Programming
  dartz: ^0.10.1
  
  # Value Equality
  equatable: ^2.0.5
  
  # Dependency Injection
  get_it: ^7.6.4
  
  # HTTP Client
  http: ^1.1.0
  
  # Local Storage (if needed)
  shared_preferences: ^2.2.2

dev_dependencies:
  flutter_test:
    sdk: flutter
  
  # Linting
  flutter_lints: ^3.0.1
  
  # Testing
  mocktail: ^1.0.1
```

## Development Workflow

### Creating a New Feature

1. **Create feature directory structure:**
```bash
mkdir -p lib/features/my_feature/{data/{datasources,models,repositories},domain/{entities,repositories,usecases},presentation/{bloc,pages,widgets}}
```

2. **Start with Domain Layer:**
   - Define entities
   - Define repository interfaces
   - Create use cases

3. **Implement Data Layer:**
   - Create models extending entities
   - Implement data sources
   - Implement repository

4. **Build Presentation Layer:**
   - Create BLoC (events, states, bloc)
   - Build pages
   - Create widgets

5. **Register Dependencies:**
   - Update `injection_container.dart`

6. **Write Tests:**
   - Unit tests for use cases
   - Unit tests for BLoC
   - Widget tests for UI

## SOLID Principles Applied

- **Single Responsibility**: Each class has one reason to change
- **Open/Closed**: Extend through interfaces, not modification
- **Liskov Substitution**: Models can replace entities
- **Interface Segregation**: Small, focused repository interfaces
- **Dependency Inversion**: Depend on abstractions (interfaces), not concretions

## Testing Strategy

```dart
// test/features/user/domain/usecases/get_user_test.dart
void main() {
  late GetUser useCase;
  late MockUserRepository mockRepository;

  setUp(() {
    mockRepository = MockUserRepository();
    useCase = GetUser(mockRepository);
  });

  test('should get user from repository', () async {
    // arrange
    final tUser = User(id: '1', name: 'Test', email: 'test@test.com');
    when(() => mockRepository.getUser('1'))
        .thenAnswer((_) async => Right(tUser));

    // act
    final result = await useCase('1');

    // assert
    expect(result, Right(tUser));
    verify(() => mockRepository.getUser('1')).called(1);
  });
}
```

## Best Practices

1. **No business logic in widgets** - Use BLoC for logic
2. **Immutable classes** - Use `const` constructors and `final` fields
3. **Value equality** - Extend `Equatable` for entities and states
4. **Error handling** - Use `Either<Failure, Success>` pattern
5. **Dependency injection** - Register all dependencies in `injection_container.dart`
6. **Testing** - Write tests for all business logic
7. **Code organization** - Follow the feature-based structure
8. **Naming conventions** - Follow the cursor rules

## Common Patterns

### Loading States
```dart
abstract class UserState extends Equatable {}
class UserInitial extends UserState {}
class UserLoading extends UserState {}
class UserLoaded extends UserState {
  final User user;
  UserLoaded({required this.user});
}
class UserError extends UserState {
  final String message;
  UserError({required this.message});
}
```

### BLoC in Widget
```dart
BlocProvider(
  create: (context) => sl<UserBloc>()..add(GetUserByIdEvent('1')),
  child: BlocBuilder<UserBloc, UserState>(
    builder: (context, state) {
      if (state is UserLoading) {
        return CircularProgressIndicator();
      } else if (state is UserLoaded) {
        return Text(state.user.name);
      } else if (state is UserError) {
        return Text(state.message);
      }
      return Container();
    },
  ),
)
```

---

**Happy Coding! 🚀**

