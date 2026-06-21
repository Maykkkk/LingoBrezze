# LingoBreeze — My Vocabulary feature

Repository layout:

- `flutter-app/` — Flutter app implementing the My Vocabulary screen.
- `backend/` — Node.js + Firebase Admin API with `GET /words` and `POST /words`.

Quick start

1. Setup backend:

```bash
cd backend
# add serviceAccountKey.json from Firebase console
npm install
npm start
```

2. Run Flutter app:

```bash
cd flutter-app
# flutter pub get
# run on your device/emulator
```

Notes

- The backend expects a Firestore collection named `words`.
- Update `flutter-app/lib/services/api_service.dart` `baseUrl` if needed (emulator vs device).
