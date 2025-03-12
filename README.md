# super_app_base_flutter

## Architecture Components
This application implements the following concepts:
* Clean Architecture
* MVVM
* Multi-modules
* ViewModel
* Stream
* GetX
* Dio

![1](https://github.com/majidebraa/arch_app_flutter/assets/82038698/8ee65dbf-2475-4742-9311-a6325c203329)

# Table of Contents

- [Introduction](#introduction)
- [Project Structure](#project-structure)
- [pubspec.yaml File](#pubspecyaml-file)
- [Asset Folder](#asset-folder)
- [Common Module](#common-module)
- [Feature Module](#feature-module)
- [Navigation Module](#navigation-module)
- [app_bindings File](#app_bindings-file)
- [app_router File](#app_router-file)
- [main File](#main-file)

---

## Introduction

This documentation assumes that you are a Flutter developer using Dart. Therefore, unnecessary explanations have been avoided for better clarity of the project structure and code.

## Project Structure

The project follows the **MVVM architecture** and maintains **SOLID principles** and **Clean Architecture** for better maintainability and scalability. The following tree structure represents the project layout:

```
📦 super_app_base_flutter
 ┣ 📂 android
 ┣ 📂 ios
 ┣ 📂 lib
 ┃ ┣ 📂 common
 ┃ ┃ ┣ 📂 constant
 ┃ ┃ ┣ 📂 ui
 ┃ ┃ ┣ 📂 custom_bottom_navigation
 ┃ ┃ ┗ 📂 util
 ┃ ┣ 📂 features
 ┃ ┃ ┣ 📂 detail
 ┃ ┃ ┣ 📂 home
 ┃ ┣ 📜 main.dart
 ┃ ┣ 📜 app_router.dart
 ┃ ┗ 📜 app_bindings.dart
 ┣ 📂 test
 ┗ 📜 pubspec.yaml
```

---

## pubspec.yaml File

This file contains dependencies and configurations for the project:

```yaml
name: super_app_base_flutter
description: "A base Project"
publish_to: 'none'

version: 1.0.0+1

environment:
  sdk: ^3.6.0

dependencies:
  flutter:
    sdk: flutter
  dio: ^5.7.0
  get: ^4.6.6
  connectivity_plus: ^6.1.0
  flutter_secure_storage: ^9.2.4
  cached_network_image: ^3.4.1
  smooth_page_indicator: ^1.2.0+3
  go_router: ^14.8.0
  flutter_inappwebview: ^6.1.5
  cupertino_icons: ^1.0.8

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0

flutter:
  uses-material-design: true
  assets:
    - assets/images/
  fonts:
    - family: IranYekan
      fonts:
        - asset: assets/fonts/iran_yekan_xfanum_regular.ttf
    - family: Modam
      fonts:
        - asset: assets/fonts/modam_fa_num_regular.ttf
```

### Explanation of Dependencies

- `dio` → For RESTful communication with the server.
- `get` → For dependency injection.
- `connectivity_plus` → To check internet connectivity.
- `flutter_secure_storage` → For secure local storage.
- `cached_network_image` → For handling network images.
- `smooth_page_indicator` → For displaying page indicators.
- `go_router` → For navigation and routing.
- `flutter_inappwebview` → For embedding web applications in mobile/web views.

All dependencies can be explored further on [pub.dev](https://pub.dev/).

---

## Asset Folder

Contains application resources such as fonts and images.

## Common Module

Contains reusable components used across the application.

- **`ui/`** → Customized UI components.
- **`custom_bottom_navigation/`** → A shared bottom navigation component.
- **`util/`** → Utility classes and helper methods.
- **`constant/`** → Stores static values like colors, fonts, and image paths.

## Feature Module

Each feature is implemented in its own module within the `features/` directory following the MVVM architecture.

## Navigation Module

Handles application routing:

- **To** → Navigates to a new screen.
- **Back** → Navigates back to the previous screen.
- **ClearAndNavigate** → Clears the stack and navigates to a new screen.

## app_bindings File

Manages dependency injections for the entire application.

## app_router File

Defines application routing and the initial screen to launch.

## main File

This is the entry point of the application where the initial configurations, routing, and dependency injections are defined.

---

This structure ensures that the project remains modular, scalable, and easy to maintain.


