# Required Packages for PartyWitty

Add these packages to your `pubspec.yaml` file to resolve linter errors.

## Dependencies

Add to the `dependencies:` section:

```yaml
dependencies:
  flutter:
    sdk: flutter

  # State Management
  flutter_bloc: ^8.1.3
  bloc: ^8.1.2

  # Functional Programming (Either type for error handling)
  dartz: ^0.10.1

  # Value Equality (for entities, states, events)
  equatable: ^2.0.5

  # Dependency Injection
  get_it: ^7.6.4

  # HTTP Client
  http: ^1.1.0

  # JSON Serialization (if needed)
  json_annotation: ^4.8.1

  # Local Storage
  shared_preferences: ^2.2.2

  # Useful Dart extensions
  collection: ^1.18.0
```

## Dev Dependencies

Add to the `dev_dependencies:` section:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter

  # Linting
  flutter_lints: ^3.0.1

  # Testing & Mocking
  mocktail: ^1.0.1
  bloc_test: ^9.1.4

  # JSON Code Generation (if using json_annotation)
  build_runner: ^2.4.6
  json_serializable: ^6.7.1
```

## Installation Steps

1. **Add packages to pubspec.yaml:**
   Copy the dependencies above into your `pubspec.yaml` file.

2. **Install packages:**
   ```bash
   flutter pub get
   ```

3. **Verify installation:**
   ```bash
   flutter pub deps
   ```

4. **Run the app:**
   ```bash
   flutter run
   ```

## Package Purposes

- **flutter_bloc**: Implements BLoC pattern for state management
- **dartz**: Provides functional programming tools like `Either` for error handling
- **equatable**: Simplifies value equality comparisons for Dart classes
- **get_it**: Service locator for dependency injection
- **http**: Making HTTP requests to APIs
- **shared_preferences**: Local key-value storage
- **mocktail**: Mocking framework for testing
- **bloc_test**: Testing utilities specifically for BLoC

## After Installation

Once packages are installed, the linter errors in these files will be resolved:
- `lib/injection_container.dart`
- `lib/core/errors/failures.dart`
- `lib/core/usecases/usecase.dart`

## Optional Packages

Depending on your needs, you might also want:

```yaml
# Image loading and caching
cached_network_image: ^3.3.0

# API client (alternative to http)
dio: ^5.4.0

# Local database
sqflite: ^2.3.0

# Path utilities
path_provider: ^2.1.1

# Secure storage
flutter_secure_storage: ^9.0.0

# Environment variables
flutter_dotenv: ^5.1.0
```

