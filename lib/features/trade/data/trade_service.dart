import 'package:crypto_trading_app/core/api_provider.dart';

class TradeService {
  final ApiProvider apiProvider;

  TradeService({required this.apiProvider});

  Future<double?> getConversionRate(String from, String to) async {
    try {
      final rates = await apiProvider.fetchLiveExchangeRates(
        baseCurrency: from,
        symbols: [to],
      );
      if (rates != null) {

        final rateKey = 'USD$to';
        if (rates.containsKey(rateKey)) {
          return rates[rateKey];
        } else {
          print('Conversion rate for $rateKey not available.');
        }
      }
      return null;
    } catch (e) {
      print('Error fetching conversion rate: $e');
      return null;
    }
  }
}