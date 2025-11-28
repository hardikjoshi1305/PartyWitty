# PartyWitty - Source Code

This directory contains the Flutter application source code following Clean Architecture principles with BLoC pattern.

## 📁 Directory Structure

- **`core/`** - Shared code, utilities, and base classes used across all features
- **`features/`** - Feature modules organized by Clean Architecture layers
- **`main.dart`** - Application entry point with dependency injection initialization
- **`injection_container.dart`** - Service locator setup using GetIt

## 📚 Documentation

- **[ARCHITECTURE_GUIDE.md](./ARCHITECTURE_GUIDE.md)** - Complete guide to the Clean Architecture implementation
- **[core/README.md](./core/README.md)** - Core module documentation
- **[features/README.md](./features/README.md)** - Features module documentation

## 🚀 Quick Start

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Run the app:**
   ```bash
   flutter run
   ```

3. **Create a new feature:**
   - See [features/README.md](./features/README.md) for step-by-step guide
   - Use `example_feature/` as a reference

## 🏗️ Architecture Layers

```
Presentation (UI) → Domain (Business Logic) → Data (Data Management)
     ↓                      ↓                        ↓
   BLoC                Use Cases              Repositories
   Pages               Entities               Data Sources
   Widgets             Interfaces             Models
```

## 📦 Required Packages

Make sure your `pubspec.yaml` includes:
- `flutter_bloc` - State management
- `dartz` - Functional programming (Either)
- `equatable` - Value equality
- `get_it` - Dependency injection
- `http` - HTTP client

## 🧪 Testing

Run tests with:
```bash
flutter test
```

## 📖 Coding Guidelines

Refer to the cursor rules in `/lib/cursorrule` for:
- Naming conventions
- Code style rules
- SOLID principles
- Testing requirements
- Commit conventions

## 🎯 Next Steps

1. Review the [ARCHITECTURE_GUIDE.md](./ARCHITECTURE_GUIDE.md)
2. Explore the `example_feature/` structure
3. Create your first feature following the Clean Architecture pattern
4. Register dependencies in `injection_container.dart`
5. Write tests for your use cases and BLoCs

---

**Need help?** Check the architecture guide or refer to the cursor rules file.

