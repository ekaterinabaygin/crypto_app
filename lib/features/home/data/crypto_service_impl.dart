import 'package:crypto_trading_app/core/api_provider.dart';
import '../models/crypto_asset.dart';
import 'crypto_service.dart';

class CryptoServiceImpl implements CryptoService {
  final ApiProvider apiProvider;

  CryptoServiceImpl({required this.apiProvider});

  @override
  Future<List<CryptoAsset>> fetchCryptoAssets({required int page}) async {
    final response = await apiProvider.getCoinData(
      endPoint: 'https://api.coingecko.com/api/v3/coins/markets',
      queryParams: {
        'vs_currency': 'usd',
        'page': page,
        'per_page': 10,
      },
    );

    if (response != null) {
      if (response is List) {
        return response.map((json) => CryptoAsset.fromJson(json)).toList();
      } else {
        throw Exception('Unexpected response format');
      }
    }
    return [];
  }
}
