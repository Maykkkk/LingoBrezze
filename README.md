# LingoBreeze — My Vocabulary feature

Repository layout:


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


## Deploying the web app

- This repository includes a GitHub Actions workflow that builds the Flutter web app and deploys it to the `gh-pages` branch on pushes to `main`.
- To enable automatic deployment, ensure Actions are enabled for your repo. The workflow uses the default `GITHUB_TOKEN` so no additional secrets are required.
- After the action runs, enable GitHub Pages in the repository settings to serve the `gh-pages` branch.
