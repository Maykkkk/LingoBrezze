# LingoBreeze Backend

Simple Express backend that uses Firebase Firestore to store vocabulary words.

Setup

1. Create a Firebase project and generate a service account key JSON.
2. Save the JSON as `serviceAccountKey.json` in this folder (not committed).
3. Install dependencies:

```bash
npm install
```

4. Start the server:

```bash
npm start
```

Mock mode

If `serviceAccountKey.json` is not present, the server will run in mock mode using an in-memory store (useful for local development or when you don't want to configure Firebase). In mock mode the API endpoints behave the same (`GET /words`, `POST /words`).

Endpoints

- `GET /words` — returns all saved words.
- `POST /words` — create a word. Body: `{ word, meaning, translation }`.
