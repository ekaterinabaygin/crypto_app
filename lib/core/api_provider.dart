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

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print('Request: ${options.method} ${options.uri}');
        handler.next(options);
      },
      onResponse: (response, handler) {
        print('Response: ${response.statusCode} ${response.data}');
        handler.next(response);
      },
      onError: (DioError e, handler) {
        print('Error occurred: ${e.message}');
        handler.next(e);
      },
    ));

    _setCoinAPIHeaders();
  }

  void _setExchangeRateHostHeaders() {
    _dio.options.headers['Authorization'] = 'Bearer ${dotenv.env['EXCHANGERATE_HOST_KEY']}';
  }

  void _setCoinAPIHeaders() {
    _dio.options.headers['Authorization'] = 'Bearer ${dotenv.env['COIN_API_KEY']}';
  }

  Future<dynamic> getCoinData({
    required String endPoint,
    Map<String, dynamic>? queryParams,
  }) async {
    _setCoinAPIHeaders();
    return _fetchData(endPoint: endPoint, queryParams: queryParams);
  }

  Future<dynamic> getExchangeRates({
    required String baseCurrency,
    required List<String> symbols,
  }) async {
    _setExchangeRateHostHeaders();
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
        return response.data;
      } else {
        print('Error: Failed to fetch data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during API request: $e');
    }
    return null;
  }
}