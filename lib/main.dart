import 'dart:ui'; // Added for PlatformDispatcher

import 'package:firebase_core/firebase_core.dart'; // Added Firebase Core import
import 'package:firebase_crashlytics/firebase_crashlytics.dart'; // Added Crashlytics import
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// --- NEW PROVIDER IMPORTS ---
import 'package:provider/provider.dart';

import 'config/routes/app_routes.dart';
import 'firebase_options.dart';
import 'providers/api_provider.dart'; // Ensure this path matches where you saved your ApiProvider

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  debugPrint("Background notification received");
}

void main() async {
  // Ensures Flutter framework is fully initialized before calling native code
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes Firebase using the configuration for the current platform
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // Request notification permission
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  String? token = await FirebaseMessaging.instance.getToken();
  debugPrint(token);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint("Notification received!");
    debugPrint("Title: ${message.notification?.title}");
    debugPrint("Body: ${message.notification?.body}");
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint("User opened the notification");
  });

  // Pass all uncaught "fatal" errors from the Flutter framework to Crashlytics
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // --- UPGRADED RUN APP WITH PROVIDER ---
  // Wrapping MyApp in a MultiProvider injects the "Vault" at the very root of the app,
  // making ApiProvider accessible to every single screen in your GoRouter setup.
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ApiProvider()),
        // You can easily add more providers here later!
        // e.g., ChangeNotifierProvider(create: (context) => AuthProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key}); // Added a standard key constructor

  final _router = GoRouter(
    routes: $appRoutes,
    navigatorKey: navigatorKey,
    initialLocation: getAppInitialRouteLocation(),
  );

  @override
  Widget build(BuildContext context) =>
      MaterialApp.router(routerConfig: _router);
}
