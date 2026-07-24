import 'package:flutter/material.dart';

import '../services/api_service.dart';

class ApiProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  String _displayText = 'Tap a button to test the network!';

  bool get isLoading => _isLoading;
  String get displayText => _displayText;

  Future<void> testGetRequest() async {
    _isLoading = true;
    _displayText = 'Fetching data...';
    notifyListeners();

    final result = await _apiService.fetchTestPost();

    _isLoading = false;
    _displayText = result;
    notifyListeners();
  }

  Future<void> testPostRequest() async {
    _isLoading = true;
    _displayText = 'Verifying App Version...';
    notifyListeners();

    final result = await _apiService.verifyAppVersion();

    _isLoading = false;
    _displayText = result;
    notifyListeners();
  }
}
