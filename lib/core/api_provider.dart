import 'package:dio/dio.dart';

class ApiProvider {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>?> fetchLiveExchangeRates({
    required String baseCurrency,
    required List<String> symbols,
  }) async {
    const String apiUrl = 'https://api.exchangerate.host/live';
    const String accessKey = '403da6dfef81906bcaaf337abe527cd9';  // Your access key

    try {
      final response = await _dio.get(apiUrl, queryParameters: {
        'access_key': accessKey,
        'base': baseCurrency,
        'symbols': symbols.join(','),
      });

      print('Exchange Rates Response: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        if (response.data['success'] == true && response.data['quotes'] != null) {
          return response.data['quotes'] as Map<String, dynamic>;
        } else {
          print('Error: API did not return success or quotes missing.');
        }
      } else {
        print('Error: Failed to fetch exchange rates. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching exchange rates: $e');
    }
    return null;
  }
}
