# Meory

## Description

This is a boilerplate for a clean architecture project in Flutter

## Project Structure

```sh
lib
├── app // App layer
│   ├── app_assets.dart // Assets used in the app
│   ├── app_cubit.dart // App Cubit
│   └── app_state.dart // App State
├── data // Data layer
│   ├── data_sources // Data sources
│   │   ├── local // Local data sources
│   │   │   ├── app_session.dart // App session data source
│   │   │   └── main_app_secure_storage.dart // Secure storage
│   │   └── remote // Remote data sources
│   │       ├── api_endpoints.dart // API endpoints
│   │       ├── base_repository.dart // Base repository
│   │       └── error_handler.dart // Error handler
│   ├── models // Repository models
│   └── repositories // Repositories: Contains the data sources and the repository implementation
├── domain // Domain layer
│   ├── entities // Entities
│   ├── repositories // Repositories: Contains the interfaces
│   └── usecases // Use cases
├── presentation // Presentation layer
│   ├── modules // Modules
│   │   └── module // Module
│   │       ├── components // Components
│   │       │   ├── module_view.dart // View (Screen)
│   │       ├── cubit // Cubit
│   │       │   ├── module_cubit.dart // Cubit
│   │       │   └── module_state.dart // State
│   │       ├── module_screen.dart // Module
│   ├── widgets // Widgets
│   └── routes.dart // Routes: Contains the routes of the app
├── configs.dart // Configs: Contains the app configs (Environment, Push Notifications, etc)
├── main.dart // Main: Contains the app entry point
└── di.dart // Dependency Injection: Contains the dependency injection configuration
```

## Getting Started

### 1. Clone the repository

### 2. Rename the project

#### 2.1. Rename the project in the pubspec.yaml file

```yaml
name: <project_name>
```

#### 2.2. Rename the project in the android folder

```sh
android/app/src/main/AndroidManifest.xml
android/app/src/main/kotlin/<package_name>/MainActivity.kt
```

#### 2.3. Rename the project in the ios folder

```sh
ios/Runner/Info.plist
ios/Runner.xcodeproj/project.pbxproj
```

### 3. Requirements to run the project

#### 3.1. Flutter version minimum `>= 3.0.0 <= 4.0.0`

#### 3.2. Development tools VSCode (Recommended) or Android Studio

#### 3.3. (Optional) Xcode (For iOS development)

### 4. Run the project

#### 4.1. Install the dependencies

```sh
flutter pub get
```

#### 4.2. generated

```
flutter pub run build_runner build --delete-conflicting-outputs
cd core/ && flutter gen-l10n && cd ..
```

#### 4.3. Run the project

1. Run the project in VSCode: Press F5
2. Run the project in Android Studio: Run > Run 'main.dart'
3. Run the project in the terminal

```sh
flutter run
```
