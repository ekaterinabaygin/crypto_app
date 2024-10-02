import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/crypto_asset.dart';

class CryptoService {
  final Dio _dio = Dio();

  Future<List<CryptoAsset>> fetchCryptoAssets({required int page}) async {
    final String apiKey = dotenv.env['COIN_API_KEY'] ?? '';
    final response = await _dio.get(
      'https://api.coingecko.com/api/v3/coins/markets',
      queryParameters: {
        'vs_currency': 'usd',
        'page': page,
        'per_page': 10,
      },
    );
    return (response.data as List)
        .map((json) => CryptoAsset.fromJson(json))
        .toList();
  }
}