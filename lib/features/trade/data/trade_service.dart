import 'package:get/get.dart';
import 'package:crypto_trading_app/core/api_provider.dart';
import 'package:crypto_trading_app/features/home/models/crypto_asset.dart';

class TradeService {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();  // Use ApiProvider

  // Fetch crypto assets with a limit parameter
  Future<List<CryptoAsset>> getCryptoAssets({required int limit}) async {
    try {
      final assetsData = await _apiProvider.fetchCryptoAssets(limit: limit);
      return assetsData.map((e) => CryptoAsset.fromJson(e)).toList();
    } catch (e) {
      print('Error fetching crypto assets: $e');
      return [];
    }
  }

  // Fetch exchange rates
  Future<Map<String, dynamic>?> getExchangeRates(String baseCurrency, List<String> symbols) async {
    try {
      final rates = await _apiProvider.fetchLiveExchangeRates(
        baseCurrency: baseCurrency,
        symbols: symbols,
      );
      return rates;
    } catch (e) {
      print('Error fetching exchange rates: $e');
      return null;
    }
  }
}
