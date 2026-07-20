import 'package:dio/dio.dart';

class ApiService {
  // 1. Explore the flutter dio package: Setting up the core Dio instance
  // We define global timeout rules here to handle network layer failures.
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  // ==========================================
  // REAL POST REQUEST (Evamp & Saanga API)
  // ==========================================

  // 2. Write code for POST request & Consume a network API
  Future<String> verifyAppVersion() async {
    try {
      final response = await _dio.post(
        'https://tec.evampsaanga.com/content-service/api/configuration/verify-app-version',

        // 3. Usage of request body
        data: {"version": "1.0.0"},

        // 4. Usage of headers
        options: Options(
          headers: {
            'channel': 'sc_app',
            'device-id': '1234',
            'language': 'en',
            'tenant': 'tec-ens',
            'platform': 'android',
            'transaction-token': 'test',
            'user-id': '136',
            'Content-Type': 'application/json',
          },
        ),
      );

      // 5. Handling of the status codes for server level
      if (response.statusCode == 200 || response.statusCode == 201) {
        // 6. Parsing of response
        // We are returning the raw data so you can see exactly what the server replies with on your screen.
        return 'Success! Server Reply: ${response.data}';
      } else {
        return 'Unexpected Server Status: ${response.statusCode}';
      }
    } on DioException catch (e) {
      // 7. Handling of API call failure & network layer call failure
      return _handleDioError(e);
    } catch (e) {
      return 'A generic error occurred: $e';
    }
  }

  // ==========================================
  // TEST GET REQUEST
  // ==========================================

  // 8. Write code for GET request
  Future<String> fetchTestPost() async {
    try {
      final response = await _dio.get(
        'https://jsonplaceholder.typicode.com/posts/1',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        // Parsing out just the title from the JSON response
        final title = response.data['title'];
        return 'GET Success! Title: $title';
      } else {
        return 'Unexpected Server Status: ${response.statusCode}';
      }
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  // ==========================================
  // GLOBAL ERROR HANDLER
  // ==========================================

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        // Handles scenarios where the user's WiFi is off or the server is completely down
        return 'Network Failure: Please check your internet connection and try again.';

      case DioExceptionType.badResponse:
        // Handles scenarios where the server was reached, but it rejected the request (e.g., 401 Unauthorized, 404 Not Found)
        final statusCode = error.response?.statusCode;
        final serverMessage = error.response?.data;
        return 'API Failure: Server rejected request (Code $statusCode). Details: $serverMessage';

      default:
        return 'Unknown Network Error: ${error.message}';
    }
  }
}
