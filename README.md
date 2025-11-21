# FinBuddy AI

A modern Flutter application that serves as your personal financial assistant powered by AI. FinBuddy AI helps you manage your finances, track expenses, and make informed financial decisions with intelligent insights.

## Features

- **AI-Powered Financial Insights**: Get personalized financial advice and analysis using Firebase AI
- **Expense Tracking**: Easily log and categorize your expenses
- **Budget Management**: Set and monitor budgets with smart notifications
- **Secure Authentication**: Google Sign-In integration for secure access
- **Offline Support**: Local storage with Hive for offline functionality
- **Dark/Light Theme**: Adaptive theming for comfortable viewing
- **Cross-Platform**: Works on iOS, Android, Web, Windows, macOS, and Linux

## Tech Stack

- **Framework**: Flutter
- **State Management**: Riverpod
- **Backend**: Firebase (Auth, Firestore, AI)
- **Local Storage**: Hive
- **Routing**: Go Router
- **Forms**: Flutter Form Builder
- **Serialization**: Freezed + JSON Serializable

## Prerequisites

Before running this project, make sure you have the following installed:

- Flutter SDK (version 3.7.0 or higher)
- Dart SDK (version 3.7.0 or higher)
- Firebase CLI
- Android Studio (for Android development)
- Xcode (for iOS development, macOS only)

## Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/RusithHansana/finbuddy_ai.git
   cd finbuddy_ai
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a new Firebase project at [Firebase Console](https://console.firebase.google.com/)
   - Enable Authentication, Firestore, and AI services
   - Download `google-services.json` and place it in `android/app/`
   - Configure Firebase options in `lib/firebase_options.dart`

4. **Generate code**
   ```bash
   flutter pub run build_runner build
   ```

5. **Run the app**
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── firebase_options.dart     # Firebase configuration
├── models/                   # Data models
├── providers/                # Riverpod providers
├── screens/                  # UI screens
├── services/                 # Business logic services
├── utils/                    # Utility functions
└── widgets/                  # Reusable UI components
```

## Building for Production

### Android

```bash
flutter build apk --release
```

### iOS

```bash
flutter build ios --release
```

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
