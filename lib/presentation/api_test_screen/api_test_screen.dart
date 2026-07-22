import 'package:flutter/material.dart';

import '../../services/api_service.dart';

class ApiTestScreen extends StatefulWidget {
  const ApiTestScreen({super.key});

  @override
  State<ApiTestScreen> createState() => _ApiTestScreenState();
}

class _ApiTestScreenState extends State<ApiTestScreen> {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  String _displayText = 'Tap a button to test the network!';

  void _testRequest(bool isGetRequest) async {
    setState(() {
      _isLoading = true;
      _displayText = isGetRequest
          ? 'Fetching data...'
          : 'Verifying App Version...';
    });

    String result;

    if (isGetRequest) {
      result = await _apiService.fetchTestPost();
    } else {
      result = await _apiService.verifyAppVersion();
    }

    setState(() {
      _isLoading = false;
      _displayText = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Network Test')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Show the CircularProgressIndicator if _isLoading is true, otherwise show the text
              if (_isLoading)
                const CircularProgressIndicator()
              else
                Text(
                  _displayText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: _isLoading ? null : () => _testRequest(true),
                child: const Text('Test GET Request'),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: _isLoading ? null : () => _testRequest(false),
                child: const Text('Test Real API (POST)'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
