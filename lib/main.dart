import 'package:firebase_core/firebase_core.dart'; // Added Firebase Core import
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'config/routes/app_routes.dart';
import 'firebase_options.dart'; // Added Firebase Options import

void main() async {
  // Ensures Flutter framework is fully initialized before calling native code
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes Firebase using the configuration for the current platform
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
