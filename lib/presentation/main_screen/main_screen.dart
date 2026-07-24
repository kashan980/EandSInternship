import 'package:eandsinternship/config/routes/app_routes.dart';
import 'package:eandsinternship/presentation/api_call/api_call.dart';
import 'package:eandsinternship/presentation/checking_age_provider/checking_age_screen.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart'; // Added Crashlytics import
import 'package:flutter/material.dart';

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
            TextButton(
                onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context)=> Api_Call()),
              );
            },
              child: const Text("Call API Screen"),

            ),
            ElevatedButton(onPressed:(){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckingAge()));
            }, child: Text("Checking age"))
          ],
        ),
      ),
    );
  }
}
