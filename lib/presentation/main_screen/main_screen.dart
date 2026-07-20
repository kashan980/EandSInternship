import 'package:eandsinternship/config/routes/app_routes.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart'; // Added Crashlytics import
import 'package:flutter/material.dart';

import '../api_test_screen/api_test_screen.dart'; // Added import for the new API test screen

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Main Screen")),
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Centers the buttons vertically
          children: [
            ElevatedButton(
              onPressed: () {
                MenuScreenRoute().push(context);
              },
              child: const Text("Open Menu"),
            ),
            const SizedBox(
              height: 20,
            ), // Adds a little spacing between the buttons

            TextButton(
              onPressed: () => FirebaseCrashlytics.instance.crash(),
              child: const Text("Force Firebase Crash"),
            ),
            const SizedBox(height: 20), // Added spacing for the new button
            // The new button to navigate to your ApiTestScreen
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ApiTestScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[100],
              ), // Colored to stand out!
              child: const Text("Open API Test Screen"),
            ),
          ],
        ),
      ),
    );
  }
}
