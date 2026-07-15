import 'package:eandsinternship/config/routes/app_routes.dart';
import 'package:flutter/material.dart';
import '../menu/menu.dart';
import 'package:go_router/go_router.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Screen"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
           MenuScreenRoute().push(context);
          },
          child: const Text("Open Menu"),
        ),
      ),
    );
  }
}
