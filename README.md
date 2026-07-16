# eands

A Flutter project developed during the Evamp & Sangaa Mobile App Development Internship.

## Firebase Setup Guide

This project is integrated with Firebase. Below are the exact terminal commands used to configure Firebase for this Flutter project. These commands can be referenced for future setups or if another collaborator needs to sync their local environment.

### 1. Install Firebase CLI Tools
Requires Node.js and npm to be installed.
```bash
npm install -g firebase-tools
```

### 2. Log in to Firebase
Authenticate your terminal with your Google account:
```bash
firebase login
```

### 3. Install the FlutterFire CLI
Activate the FlutterFire tool globally on your machine:
```bash
dart pub global activate flutterfire_cli
```

### 4. Add the Core Firebase Package
Add the required Firebase dependency to the Flutter project:
```bash
flutter pub add firebase_core
```

### 5. Configure the Project
Link the local Flutter project to the Firebase console project (e.g., `eands-internship-2026`).
*(Note: Using `dart pub global run` bypasses Windows path environment variable issues).*
```bash
dart pub global run flutterfire_cli:flutterfire configure
```
*Tip: If the CLI fails to create a new project due to naming conflicts, create the project manually in the [Firebase Console](https://console.firebase.google.com/) first. Then, re-run the configuration command and select the newly created project from the list.*

### 6. Initialize Firebase in Code
Update `lib/main.dart` to initialize Firebase before the app runs:
```dart
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // App initialization continues here...
}
```

---

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Navigation

### Added `go_router` for app navigation.
### Configured routes in `app_routes.dart`.
### Created `route_helper_utils.dart` for route helpers.
### Integrated routing using `MaterialApp.router`.



### Implementing the ability to receive the push notifications from the firebase

### 1.Git Commands for making feature of push notifications
-  git checkout -b feature/HA/firebase_push_notifications


### 2.Adding depenencies in pubspec.yaml
firebase_core: ^4.0.0
firebase_messaging: ^16.0.0
flutter_local_notifications: ^19.4.0

### 3.write the command 
- flutter pub get 

### 4. go in build.gradle.kts inside andriod 
- in this file inside **compile options** add this command 
- isCoreLibraryDesugaringEnabled = true

### 5.At the bottom of the file, just above:

flutter {
source = "../.."
}
- add
  dependencies {
  coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")
  }

### 6. Add permission on andriod 
- <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>

### 7. To get device token add this in main
String? token = await FirebaseMessaging.instance.getToken();
print(token);

### 8. To listen for messages (for foreground notifications) add this in main 
FirebaseMessaging.onMessage.listen((RemoteMessage message) {
print(message.notification?.title);
print(message.notification?.body);
});

### 9. Add the code of bakground notifications in main 

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
await Firebase.initializeApp(
options: DefaultFirebaseOptions.currentPlatform,
);

print("Background notification received");

### 10 Then call it in main
FirebaseMessaging.onBackgroundMessage(
firebaseMessagingBackgroundHandler,
);

### 11 Then the code to detect when use tap the notifications (add in main) 

FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
print("User opened the notification");
});








