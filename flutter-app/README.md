# Flutter App — LingoBreeze My Vocabulary

Quick notes to run the Flutter app locally.

1. Fetch packages:

```bash
cd flutter-app
flutter pub get
```

2. Configure backend host if needed:

- By default the app uses `http://localhost:3000` as `baseUrl` in `lib/services/api_service.dart`.
- For Android emulator use `http://10.0.2.2:3000`.

3. Run on Chrome (web):

```bash
flutter run -d chrome
```

4. Run on macOS (if desktop support is enabled):

```bash
flutter create .
flutter run -d macos
```
