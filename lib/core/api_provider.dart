import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiProvider {
  static final ApiProvider _instance = ApiProvider._internal();
  final Dio _dio;

  factory ApiProvider() {
    return _instance;
  }

  ApiProvider._internal() : _dio = Dio() {
    _dio.options.headers['Content-Type'] = 'application/json';
  }

  Future<dynamic> getCoinData({
    required String endPoint,
    Map<String, dynamic>? queryParams,
  }) async {
    _dio.options.headers['Authorization'] = 'Bearer ${dotenv.env['COIN_API_KEY']}';
    return _fetchData(endPoint: endPoint, queryParams: queryParams);
  }

  Future<dynamic> getExchangeRates({
    required String baseCurrency,
    required List<String> symbols,
  }) async {
    const String apiUrl = 'https://api.exchangerate.host/live';
    return _fetchData(endPoint: apiUrl, queryParams: {
      'base': baseCurrency,
      'symbols': symbols.join(','),
      'access_key': dotenv.env['EXCHANGERATE_HOST_KEY'],
    });
  }

  Future<dynamic> _fetchData({
    required String endPoint,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final response = await _dio.get(
        endPoint,
        queryParameters: queryParams,
      );
      if (response.statusCode == 200 && response.data != null) {
        return response.data;  // Return data without casting yet
      } else {
        print('Error: Failed to fetch data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during API request: $e');
    }
    return null;
  }
}