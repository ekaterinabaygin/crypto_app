import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiProvider {
  final Dio _dio = Dio();

  // Fetch crypto assets with error handling
  Future<List<dynamic>> fetchCryptoAssets({required int limit}) async {
    const String apiUrl = 'https://rest.coinapi.io/v1/assets';
    final String apiKey = dotenv.env['COIN_API_KEY'] ?? '';

    try {
      final response = await _dio.get(apiUrl, queryParameters: {
        'limit': limit,
      }, options: Options(headers: {
        'X-CoinAPI-Key': apiKey,
      }));

      if (response.statusCode == 200 && response.data is List) {
        return response.data as List<dynamic>;
      } else {
        print('Error: Failed to fetch crypto assets.');
        return [];
      }
    } catch (e) {
      print('Error fetching crypto assets: $e');
      return [];
    }
  }

  // Fetch live exchange rates with proper error handling
  Future<Map<String, dynamic>?> fetchLiveExchangeRates({
    required String baseCurrency,
    required List<String> symbols,
  }) async {
    const String apiUrl = 'https://api.exchangerate.host/latest';

    try {
      final response = await _dio.get(apiUrl, queryParameters: {
        'base': baseCurrency,
        'symbols': symbols.join(','),
      });

      if (response.statusCode == 200 && response.data != null) {
        return response.data['rates'] as Map<String, dynamic>;
      } else {
        print('Error: Failed to fetch exchange rates.');
        return null;
      }
    } catch (e) {
      print('Error fetching exchange rates: $e');
      return null;
    }
  }
}

