import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'presentation/main_screen/main_screen.dart';
import 'presentation/menu/menu.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MainScreen(),
    ),
    GoRoute(
      path: '/menu',
      builder: (context, state) => const Menu(),
    ),
  ],
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}