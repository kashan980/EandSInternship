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
Firebase Crashlytics Integration
Crashlytics is a real-time crash reporting tool that helps track, prioritize, and fix stability issues that degrade app quality. It acts as a production observability system to capture fatal errors and stack traces when the app is running on a user's device.

1. Feature Branch Initialization
All Crashlytics integration was developed on a dedicated feature branch to protect the main codebase:

Bash
git checkout -b feature/KS/firebase_crashlytics
2. Install the Package
Add the Crashlytics dependency to the project:

Bash
flutter pub add firebase_crashlytics
3. Global Error Handling Configuration
To ensure all application errors are routed to the Firebase Console, lib/main.dart was updated with the following configuration:

Dart
import 'dart:ui';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

// Inside main() after Firebase.initializeApp:

// Pass all uncaught "fatal" errors from the framework to Crashlytics
FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

// Pass all uncaught asynchronous errors that aren't handled by the framework to Crashlytics
PlatformDispatcher.instance.onError = (error, stack) {
FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
return true;
};
4. Triggering a Test Crash
To verify the integration, a temporary button was added to the UI to force a fatal exception:

Dart
TextButton(
onPressed: () => FirebaseCrashlytics.instance.crash(),
child: const Text("Force Firebase Crash"),
)
Note: The application must be restarted after a crash to successfully upload the stack trace to the Firebase Console.

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


### Steps on side of firebase 
- open devops and engagement 
- 

### push the changes
- git push -u origin feature/HA/firebase_push_notifications
- messaging
- then create a compaign for messages 

### command to push on github
-  git push -u origin feature/HA/firebase_push_notifications








