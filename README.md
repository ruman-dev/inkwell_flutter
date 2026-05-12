# Inkwell 🖋️

Inkwell is a premium, modern task management and note-taking application built with Flutter and Firebase. It features a sleek dark-themed interface, real-time cloud synchronization, and a fully responsive design.

## ✨ Features

- **🔒 Secure Authentication**: Robust login and registration system powered by Firebase Authentication.
- **☁️ Cloud Sync**: Seamless real-time data storage using Google Cloud Firestore.
- **📱 Responsive UI**: Optimized for all screen sizes (phones, tablets) using `flutter_screenutil`.
- **⚡ Optimistic Updates**: Instant UI feedback when completing tasks, with automatic rollback on network failure.
- **🎨 Premium Design**: Minimalist dark mode aesthetic with glassmorphism elements and smooth transitions.
- **🌀 Native Splash**: Custom branded splash screen using `flutter_native_splash`.
- **🔄 Pull-to-Refresh**: Easily synchronize your notes with a simple swipe-down gesture.

## 🛠️ Technology Stack

- **Framework**: [Flutter](https://flutter.dev)
- **State Management**: [GetX](https://pub.dev/packages/get)
- **Backend**: [Firebase](https://firebase.google.com) (Auth & Firestore)
- **Architecture**: Clean Architecture (Layered)
- **Responsiveness**: [Flutter ScreenUtil](https://pub.dev/packages/flutter_screenutil)
- **Functional Programming**: [Dartz](https://pub.dev/packages/dartz) (for error handling with `Either`)

## 🏗️ Architecture & Pattern

This project follows **Clean Architecture** principles to ensure scalability, maintainability, and testability. It is divided into three primary layers:

1.  **Presentation Layer**: Handles UI and state management using GetX (Controllers, Screens, Bindings).
2.  **Domain Layer**: Contains business logic and entities. It defines interfaces (Repositories) that the data layer must implement.
3.  **Data Layer**: Responsible for data sources (Firebase Firestore) and repository implementations.

## 🚀 Getting Started

### Prerequisites

- Flutter SDK
- A Firebase project

### Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/ruman-dev/inkwell_flutter.git
   ```
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Configure Firebase:
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) to the respective directories.
4. Run the app:
   ```bash
   flutter run
   ```

## 📂 Project Structure

```text
lib/
├── core/            # App-wide utilities, themes, and routing
├── features/        # Feature-based modules
│   ├── auth/        # Authentication logic and UI
│   └── home/        # Task management logic and UI
└── main.dart        # Entry point and initialization
```

---

Built with ❤️ by [Ruman](https://github.com/ruman-dev)
