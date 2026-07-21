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
            // 2. This listener decides whether to show the text or a loading spinner
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

    // 3. Turn the loader ON before communication starts
    loadingNotifier.value = true;

    try {
      var response = await dio.get('https://tec.evampsaanga.com/content-service/api/configuration/verify-app-version');
      debugPrint('${response.statusCode}');
      debugPrint(response.data.toString());

      textNotifier.value = response.data['responseMessage'].toString();

    } on DioException catch (e) {
      debugPrint('Error Status Code ${e.response?.statusCode}');
      debugPrint('Error Response Body ${e.response?.data}');
      textNotifier.value = "Fetch failed!";
    }

    // 4. Turn the loader OFF when communication finishes
    loadingNotifier.value = false;
  }

  void postData() async {
    var dio = Dio();

    // 3. Turn the loader ON before communication starts
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
      debugPrint('Error Status Code: ${e.response?.statusCode}');
      debugPrint('Error Response Body: ${e.response?.data}');
      textNotifier.value = "Post failed!";
    }

    // 4. Turn the loader OFF when communication finishes
    loadingNotifier.value = false;
  }
}


