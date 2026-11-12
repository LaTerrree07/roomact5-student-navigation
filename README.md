# Student Navigation Portal (`lim_navigation_app`)

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=flat&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=flat&logo=Dart&logoColor=white)
![Material 3](https://img.shields.io/badge/Material%203-%230F766E.svg?style=flat)

A responsive multi-destination Flutter application showcasing in-memory authentication, bottom tab navigation with state preservation, basic arithmetic calculations, student profile details, and a social media hub.

---

## Features

- **Authentication Flow**: Form-validated login and registration with interactive password visibility toggle and in-memory credential storage.
- **Bottom Navigation & State Preservation**: Material 3 `NavigationBar` integrated with `IndexedStack` to preserve state, calculations, and inputs across tab switches.
- **Home Dashboard**: Clean overview hub introducing all application modules and active session state.
- **Calculator**: Complete arithmetic engine supporting addition, subtraction, multiplication, and division with error handling (division by zero, non-finite input validation) and reset capabilities.
- **Student Profile**: Comprehensive profile displaying student number, academic program, year & section, about me statement, and interests.
- **Social Media Showcase**: Interactive platform cards providing feedback via SnackBars for connected social channels.

---

## Tech Stack

- **Framework**: [Flutter](https://flutter.dev/) (Channel stable, Material 3)
- **Language**: [Dart](https://dart.dev/)
- **Architecture**: Modular component architecture with `StatefulWidget` state persistence (`IndexedStack`)
- **Theme**: Cohesive deep teal (`#0F766E`) and soft mint (`#CCFBF1`) styling

---

## Getting Started

### Prerequisites

- Flutter SDK (>= 3.13.5)
- Android Studio / VS Code with Flutter extension
- A connected physical device, emulator, or Chrome browser

### Installation & Run

1. Clone or navigate to the project directory:
   ```bash
   cd lim_navigation_app
   ```

2. Fetch dependencies:
   ```bash
   flutter pub get
   ```

3. Run the automated test suite:
   ```bash
   flutter test
   ```

4. Launch the application:
   ```bash
   flutter run
   ```

---

## Author

**Earth Justin Lim**  
BS Information Technology
