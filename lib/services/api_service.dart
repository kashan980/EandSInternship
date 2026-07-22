import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

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
        return 'Unexpected Server Status: ${response.statusCode}';
      }
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e) {
      return 'A generic error occurred: $e';
    }
  }

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
        return 'API Failure: Server rejected request (Code $statusCode). Details: $serverMessage';

      default:
        return 'Unknown Network Error: ${error.message}';
    }
  }
}
