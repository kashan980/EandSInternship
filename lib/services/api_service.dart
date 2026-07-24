import 'dart:developer' as developer;

import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  // REAL POST REQUEST

  Future<String> verifyAppVersion() async {
    try {
      final response = await _dio.post(
        'https://tec.evampsaanga.com/content-service/api/configuration/verify-app-version',
        data: {"version": "1.0.0"},
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

      if (response.statusCode == 200 || response.statusCode == 201) {
        return 'Success! Server Reply: ${response.data}';
      } else {
        return 'Unexpected Success Status: ${response.statusCode}';
      }
    } on DioException catch (e, stackTrace) {
      developer.log(
        'Dio Network Crash in verifyAppVersion',
        name: 'ApiService',
        error: e,
        stackTrace: stackTrace,
        level: 1000,
      );

      return _handleDioError(e);
    } catch (e, stackTrace) {
      developer.log(
        'Unexpected App Crash in verifyAppVersion',
        name: 'ApiService',
        error: e,
        stackTrace: stackTrace,
      );
      return 'A generic error occurred: $e';
    }
  }

  // TEST GET REQUEST

  Future<String> fetchTestPost() async {
    try {
      final response = await _dio.get(
        'https://jsonplaceholder.typicode.com/posts/1',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        String title = 'No Title Provided'; // Safe fallback

        if (responseData is Map<String, dynamic>) {
          title = responseData['title']?.toString() ?? 'No Title Provided';
        }

        return 'GET Success! Title: $title';
      } else {
        return 'Unexpected Success Status: ${response.statusCode}';
      }
    } on DioException catch (e, stackTrace) {
      developer.log(
        'Dio Network Crash in fetchTestPost',
        name: 'ApiService',
        error: e,
        stackTrace: stackTrace,
        level: 1000,
      );
      return _handleDioError(e);
    } catch (e, stackTrace) {
      developer.log(
        'Unexpected App Crash in fetchTestPost',
        name: 'ApiService',
        error: e,
        stackTrace: stackTrace,
      );
      return 'A generic error occurred: $e';
    }
  }

  String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return 'Network Failure: Please check your internet connection and try again.';

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final serverMessage = error.response?.data;

        switch (statusCode) {
          case 400:
            return 'Bad Request (400): The data sent to the server was invalid.';
          case 401:
            return 'Unauthorized (401): Session expired or invalid transaction token. Please log in again.';
          case 403:
            return 'Forbidden (403): You do not have permission to perform this action.';
          case 404:
            return 'Not Found (404): The requested URL endpoint does not exist.';
          case 422:
            return 'Validation Error (422): The server understood the request, but the data was incorrect. Details: $serverMessage';
          case 500:
            return 'Internal Server Error (500): The server crashed. Please try again later.';
          case 502:
            return 'Bad Gateway (502): The server is temporarily down or restarting.';
          case 503:
            return 'Service Unavailable (503): The server is currently under maintenance.';
          default:
            return 'API Failure (Code $statusCode): Server rejected request. Details: $serverMessage';
        }

      default:
        return 'Unknown Network Error: ${error.message}';
    }
  }
}
