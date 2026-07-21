import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Api_Call extends StatelessWidget {
  Api_Call({super.key});

  final textNotifier = ValueNotifier("No data fetched yet.");

  final loadingNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Api Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueListenableBuilder(
              valueListenable: loadingNotifier,
              builder: (context, isLoading, child) {
                if (isLoading == true) {
                  return const CircularProgressIndicator();
                }

                // If not loading, show the actual text message
                return ValueListenableBuilder(
                  valueListenable: textNotifier,
                  builder: (context, currentText, child) {
                    return Center(child: Text(currentText.toString(),
                        textAlign:TextAlign.center
                    ),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                fetchData();
              },
              child: Text('Fetch Data'),
            ),
            ElevatedButton(
              onPressed: () {
                postData();
              },
              child: Text('Post Data'),
            )
          ],
        ),
      ),
    );
  }

  void fetchData() async {
    var dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);

    loadingNotifier.value = true;

    try {
      var response = await dio.get('https://tec.evampsaanga.com/content-service/api/configuration/verify-app-version');
      debugPrint('${response.statusCode}');
      debugPrint(response.data.toString());

      textNotifier.value = response.data['responseMessage'].toString();

    } on DioException catch (e) {
      handleNetworkError(e);
      debugPrint('Error Status Code ${e.response?.statusCode}');
      debugPrint('Error Response Body ${e.response?.data}');
      textNotifier.value = "Fetch failed!";
    }

    loadingNotifier.value = false;
  }

  void postData() async {
    var dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 10);
    dio.options.receiveTimeout = const Duration(seconds: 10);

    loadingNotifier.value = true;

    try {
      var response = await dio.post(
        'https://tec.evampsaanga.com/content-service/api/configuration/verify-app-version',
        options: Options(
          headers: {
            'channel': 'sc_app',
            'device-id': '124',
            'language': 'en',
            'tenant': 'tec-ens',
            'platform': 'android',
            'transaction-token': 'test',
            'user-id': '1000',
            'Content-Type': 'application/json',
          },
        ),
        data: {
          'version': '1.0.0',
        },
      );

      debugPrint('- SUCCESS -');
      debugPrint('Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.data.toString()}');

      textNotifier.value = response.data['responseMessage'].toString();

    } on DioException catch (e) {
      debugPrint('- ERROR ENCOUNTERED -');
      handleNetworkError(e);
      debugPrint('Error Status Code: ${e.response?.statusCode}');
      debugPrint('Error Response Body: ${e.response?.data}');
      textNotifier.value = "Post failed!";
    }

    loadingNotifier.value = false;
  }

  void handleNetworkError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout) {
      textNotifier.value = "Connection timed out. Server might be down.";
    } else if (error.type == DioExceptionType.receiveTimeout) {
      textNotifier.value = "Server is taking too long to send data.";
    } else if (error.type == DioExceptionType.connectionError) {
      textNotifier.value = "No internet connection. Please check your Wi-Fi.";
    } else if (error.type == DioExceptionType.badResponse) {
      switch (error.response?.statusCode) {
        case 400:
          textNotifier.value = "400 - Bad Request";
          break;

        case 401:
          textNotifier.value = "401 - Unauthorized";
          break;

        case 403:
          textNotifier.value = "403 - Forbidden";
          break;

        case 404:
          textNotifier.value = "404 - Resource Not Found";
          break;

        case 500:
          textNotifier.value = "500 - Internal Server Error";
          break;

        default:
          textNotifier.value =
          "Server Error (${error.response?.statusCode})";
      }
    }
    else {
      textNotifier.value = "Network communication failed. Please retry.";
    }
  }
}




