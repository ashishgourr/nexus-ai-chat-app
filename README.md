# Nexus AI — Mini AI Chat App

Flutter AI chat app (Android & iOS) with anonymous/Google/Apple sign-in, streaming AI (Gemini + mock fallback), and persistent conversations. Built for the First-Round Assignment: Mini AI Chat.

---

# Demo Video 

https://github.com/user-attachments/assets/7192733d-70c3-4172-be4c-142df31ed391



## Submission

- **Repository:** [https://github.com/ashishgourr/nexus-ai-chat-app](https://github.com/ashishgourr/nexus-ai-chat-app)
- **README:** This file. Step-by-step setup, architecture, what’s complete vs. known limitations below.

---

## Step-by-step setup (Android & iOS)

### 1. Clone and install

```bash
git clone https://github.com/ashishgourr/nexus-ai-chat-app.git
cd nexus-ai-chat-app
flutter pub get
```

### 2. Firebase project

1. Create a project at [Firebase Console](https://console.firebase.google.com).
2. Enable **Authentication** → Sign-in method: **Anonymous**, **Google**, **Apple**.
3. Enable **Cloud Firestore** (create database).
4. Run: `dart pub global activate flutterfire_cli` then `flutterfire configure` to link the app and download config files.

### 3. Android setup

1. In Firebase Console → Project settings → Your apps → add Android app (package name e.g. `com.example.mini_ai_chat_app`).
2. Download **google-services.json** and place at `android/app/google-services.json`.
3. **SHA-1 (required for Google Sign-In):** Project settings → Your apps → Android app → Add fingerprint. Get SHA-1: `cd android && ./gradlew signingReport` (debug variant). Add SHA-1 and SHA-256 if you use release builds.

### 4. iOS setup

1. In Firebase Console → Your apps → Add iOS app (bundle ID e.g. `com.example.miniAiChatApp`).
2. Download **GoogleService-Info.plist** and add to Xcode: place in `ios/Runner/` and add to Runner target.
3. **URL scheme for Google Sign-In:** In `ios/Runner/Info.plist`, add `CFBundleURLTypes` with the **reversed client ID** from `GoogleService-Info.plist` (key `REVERSED_CLIENT_ID`).
4. **Sign in with Apple (required on iOS):** [Apple Developer](https://developer.apple.com/account/) → Identifiers → your App ID → enable **Sign in with Apple**. In Xcode: Runner target → Signing & Capabilities → add **Sign in with Apple**. Without this, the button shows that setup is required.

### 5. Firestore rules

```bash
firebase deploy --only firestore:rules
```

Rules are in `firestore.rules` (restrict read/write to `request.auth.uid`).

### 6. Environment / API key (optional)

The app reads **GEMINI_API_KEY** from the **project root**. No secrets are committed.

- **Option A:** Create a `.env` file in the **project root** (same folder as `pubspec.yaml`). Add:
  ```text
  GEMINI_API_KEY=your_key
  ```
  Run with: `./run_with_env.sh`
- **Option B:** Run with: `flutter run --dart-define=GEMINI_API_KEY=your_key`

Get a key from [Google AI Studio](https://aistudio.google.com/app/apikey). If no key is set, the app uses **mock AI** (simulated responses).

### 7. Code generation

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 8. Run

```bash
# With .env in project root
./run_with_env.sh

# Or with dart-define
flutter run --dart-define=GEMINI_API_KEY=your_key
```

### 9. App icon (optional)

Icon asset: `assets/icon/app_icon.png`. To set as launcher icon:

```bash
dart run flutter_launcher_icons
```

Then: `flutter clean && flutter pub get && flutter run`. If iOS gives "Operation not permitted", run the command from your system terminal.

---

## Architecture & state management

### Clean Architecture

The app follows **Clean Architecture** with three layers:

- **Domain:** Entities, repository interfaces, use cases. No Flutter/Firebase; easy to test and reuse.
- **Data:** Repository implementations, remote (Firebase) and local (SharedPreferences/secure storage) data sources, DTOs.
- **Presentation:** BLoC, pages, widgets. UI only; business logic lives in use cases.

**Why:** Clear separation of concerns, testability (mock repos/use cases), and independence from frameworks and external services.

### State management: BLoC

**BLoC** (Business Logic Component) is used for app-wide and feature state (auth, chat list, chat detail).

- **Why BLoC:** Single-direction data flow (events → bloc → state → UI), predictable and easy to reason about. Fits Clean Architecture: UI dispatches events, bloc calls use cases, emits states; UI rebuilds from state only. No business logic in widgets.
- **Packages:** `flutter_bloc`, `bloc`. Use cases are injected into blocs; no direct repo access from UI.

### Key packages and why

| Package                    | Purpose                                                                                                                                                                                 |
| -------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **get_it**                 | Dependency injection. Register repos, data sources, use cases, blocs in one place; inject into blocs and widgets. Keeps construction and lifecycle explicit.                            |
| **go_router**              | Declarative routing with redirects (e.g. unauthenticated → auth). Auth-aware; single source of truth for routes.                                                                        |
| **dio**                    | HTTP client for the **Gemini API**. Used instead of `http` for timeouts, interceptors, and streaming (SSE) support; same client can be configured with base URL and headers for Gemini. |
| **flutter_dotenv**         | Load `.env` from project root so `GEMINI_API_KEY` (and optional `GOOGLE_WEB_CLIENT_ID`) are not hardcoded. `.env` is in `.gitignore`.                                                   |
| **freezed**                | Immutable state/events and data classes (e.g. `AuthState`, `AuthEvent`). Reduces boilerplate and avoids mutation bugs.                                                                  |
| **connectivity_plus**      | Detect online/offline for offline banner and “Back online” SnackBar.                                                                                                                    |
| **flutter_secure_storage** | Persist anonymous user UID so guest session survives app restart.                                                                                                                       |

---

## Evaluation rubric (how each criterion is met)

| Criterion                       | Weight | How it's met                                                                                                                                                                                                                                                                                                                                                                                                                                                             |
| ------------------------------- | ------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| **Architecture & code quality** | 25%    | **Separation of concerns:** Domain (entities, repo interfaces, use cases) → Data (repo impl, remote/local datasources) → Presentation (BLoC, pages, widgets). **State management:** BLoC for auth, chat list, chat detail; single-direction flow; use cases injected, no business logic in UI. **Readability:** Feature-based folders, freezed for state/entities, `AppStrings` for copy.                                                                                |
| **Auth & data handling**        | 25%    | **Correctness:** Anonymous, Google, Apple sign-in and account linking; auth errors mapped to user-facing strings and shown in SnackBar; link failure keeps user on chat screen (no full-screen loading). **Reliability:** Cache-first load; offline send queue; flush on reconnect. **Security:** Firestore rules in `firestore.rules` restrict read/write to `request.auth.uid == userId`; no secrets in repo (`.env` at root or `--dart-define`).                      |
| **UX & polish**                 | 20%    | **Loading/error states:** Auth loading; chat list loading/error; chat detail loading; `ChatDetailError` with Semantics; message bubble shows "Response failed" for AI errors. **Streaming illusion:** Message status `streaming` with typing dots; chunks emitted and UI updated; input disabled while streaming. **Accessibility:** `Semantics` on loading indicator, error state, and chat input (see `chat_detail_page.dart`, `chat_input_field.dart`).               |
| **Documentation**               | 10%    | **Setup clarity:** Step-by-step setup (clone, Firebase, Android, iOS, Firestore, env, code gen, run). **Assumptions & trade-offs:** Section in README (secrets, Firebase, AI, offline). **Known limitations:** Apple Sign-In, no Cloud Functions, bloc_test, rate limiting.                                                                                                                                                                                              |
| **Testing & maintainability**   | 10%    | **Tests:** `auth_page_test.dart`, `chat_list_page_test.dart`, `chat_repository_impl_test.dart`; mocktail + mock BLoC. **Seams for testing:** Use cases and repository interfaces are injectable; BLoC depends on use cases, not repositories directly; easy to mock in tests.                                                                                                                                                                                            |
| **Edge case handling**          | 10%    | **AI API error:** Stream failure yields `Failure`; bloc sets message status to `error`, emits `ChatDetailState.error`; UI shows error message in body and "Response failed" in the failed message bubble; mock fallback when no API key. **Offline:** Cache used for conversations/messages; send fails with user-facing "Check connection" message; messages can be queued and flushed when back online; offline banner and "You're offline" / "Back online" SnackBars. |

---

## What’s complete vs. known limitations

### Complete

- **Build:** Runs on Android and iOS (simulator).
- **Auth:** Anonymous, Google, Apple sign-in. Guest can link to Google/Apple without losing chat history. Sign out; guest session persisted locally.
- **Chat:** Send message → streaming AI response (Gemini) → persisted per user. View past conversations and continue. Bubbles, timestamps, typing/streaming UX, empty states.
- **Data:** Firestore for conversations/messages; local cache (cache-first, offline read); offline send queue (messages sent when back online).
- **UX:** Loading and error states; offline banner and connectivity SnackBars; link errors shown in SnackBar without full-screen loading; client-side rate limiting (2s between sends).
- **Security:** Firestore rules by owner UID; no secrets in repo (`.env` at root or `--dart-define`).

### Known limitations

- **Apple Sign-In:** Code and UI are implemented. End-to-end flow needs a **paid Apple Developer account**, “Sign in with Apple” enabled for the App ID, and the capability added in Xcode. Without that, the button shows that setup is required.
- **Firebase Cloud Functions:** Not used. The assignment allowed client-side AI or a backend. This app calls the **Gemini API** from the client; API key via `.env` or `--dart-define`. For production, moving the AI call to a backend (e.g. Cloud Function) and keeping the key on the server is recommended.
- **Rate limiting:** Client-side only (2s between sends). Stricter limits would require a backend.

---

## Troubleshooting

- **Google Sign-In DEVELOPER_ERROR / “Unknown calling package name”:** Add debug SHA-1 (and SHA-256) in Firebase Console → Project settings → Your apps → Android app → Add fingerprint. Use `cd android && ./gradlew signingReport`.
- **“Guest sign-in is not enabled”:** Firebase Console → Authentication → Sign-in method → enable **Anonymous**.
- **Apple Sign-In error (e.g. 1000):** Enable “Sign in with Apple” for your App ID in Apple Developer and add the capability in Xcode (see iOS setup).
- **iOS CocoaPods / ffi_c error:** Use Homebrew Ruby and reinstall CocoaPods; or run `./scripts/ios_pod_install.sh` if available.

---

## Assumptions & trade-offs

- **Secrets:** No API keys in repo. Use `.env` in the **project root** or `--dart-define=GEMINI_API_KEY=...`.
- **Firebase:** You create the project and add Android/iOS apps and config files; they are not committed.
- **AI:** Gemini from client when key is set; mock fallback otherwise. For production, use a backend for the AI call and keep the key on the server.
- **Offline:** Cached conversations/messages shown when offline; offline send queue flushes when back online.
