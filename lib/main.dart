import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'config/routes/app_routes.dart';
import 'presentation/main_screen/main_screen.dart';
import 'presentation/menu/menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _router = GoRouter(
    routes: $appRoutes,
    navigatorKey: navigatorKey,
    initialLocation: getAppInitialRouteLocation(),
  );


  @override
  Widget build(BuildContext context) => MaterialApp.router(
    routerConfig: _router,
  );
}