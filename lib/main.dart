import 'package:firebase_core/firebase_core.dart'; // Added Firebase Core import
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'config/routes/app_routes.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  print("Background notification received");
}

void main() async {
  // Ensures Flutter framework is fully initialized before calling native code
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes Firebase using the configuration for the current platform
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(
    firebaseMessagingBackgroundHandler,
  );

  // Request notification permission
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  String? token = await FirebaseMessaging.instance.getToken();
  print(token);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Notification received!");
    print("Title: ${message.notification?.title}");
    print("Body: ${message.notification?.body}");
  });

  FirebaseMessaging.onBackgroundMessage(
    firebaseMessagingBackgroundHandler,
  );

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("User opened the notification");
  });

  runApp(MyApp());
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
