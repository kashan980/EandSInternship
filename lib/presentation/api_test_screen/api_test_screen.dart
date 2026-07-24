import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Required for State Management

// Make sure this path points correctly to your new Provider file
import '../../providers/api_provider.dart';

class ApiTestScreen extends StatelessWidget {
  const ApiTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Network Test')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          // CONSUMER: This widget listens to ApiProvider.
          // Whenever notifyListeners() is called in the provider, ONLY this Column rebuilds.
          child: Consumer<ApiProvider>(
            builder: (context, apiProvider, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 1. STATE READING: Show the spinner or the text based on the Provider's state
                  if (apiProvider.isLoading)
                    const CircularProgressIndicator()
                  else
                    Text(
                      apiProvider.displayText,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  const SizedBox(height: 20),

                  // 2. IMAGE LOADING EXCEPTION: Prevents the app from crashing on broken URLs
                  Image.network(
                    'https://tec.evampsaanga.com/broken_logo.png', // A fake/broken URL
                    height: 100,
                    width: 100,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 100,
                        width: 100,
                        color: Colors.grey[300],
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 40),

                  // 3. ACTIONS: Triggering the API calls inside the Provider
                  ElevatedButton(
                    // If it is already loading, we set onPressed to 'null' to temporarily disable the button
                    onPressed: apiProvider.isLoading
                        ? null
                        : () => apiProvider.testGetRequest(),
                    child: const Text('Test GET Request'),
                  ),

                  const SizedBox(height: 15),

                  ElevatedButton(
                    onPressed: apiProvider.isLoading
                        ? null
                        : () => apiProvider.testPostRequest(),
                    child: const Text('Test Real API (POST)'),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
