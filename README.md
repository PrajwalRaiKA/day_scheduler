# day_scheduler

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Build Process

### 1. Install Dependencies

```
flutter pub get
```

### 2. Generate Code (Freezed, Drift, Injectable, Mocks)

```
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Build for Android

```
flutter build apk --release
```
Or for debug:
```
flutter run -d <android-device-id>
```

### 4. Build for iOS

```
flutter build ios --release
```
Or for debug:
```
flutter run -d <ios-device-id>
```

### 5. Build for Web

```
flutter build web
```
Or for debug:
```
flutter run -d chrome
```

### 6. Build for Desktop (macOS, Windows, Linux)

```
flutter build macos
flutter build windows
flutter build linux
```

### 7. Clean Build (Recommended if you face issues)

```
flutter clean
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
```

### 8. Troubleshooting
- If you see errors about missing generated files, always run the build_runner command above.
- For dependency issues, run `flutter pub get`.
- For platform-specific issues, check the official [Flutter documentation](https://docs.flutter.dev/).

### 9. Useful Commands
- List devices: `flutter devices`
- Hot reload: Press `r` in the terminal during `flutter run`
- Hot restart: Press `R` in the terminal during `flutter run`
- Analyze code: `flutter analyze`
- Run tests: `flutter test`

---
