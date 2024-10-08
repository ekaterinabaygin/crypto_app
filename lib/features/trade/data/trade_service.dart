import 'package:crypto_trading_app/core/api_provider.dart';

abstract class TradeService {
  Future<double?> getConversionRate(String from, String to);
}

class TradeServiceImpl implements TradeService {
  final ApiProvider apiProvider;

  TradeServiceImpl({required this.apiProvider});

  @override
  Future<double?> getConversionRate(String from, String to) async {
    try {
      final response = await apiProvider.getExchangeRates(
        baseCurrency: from,
        symbols: [to],
      );

      if (response != null && response.containsKey('quotes')) {
        final rateKey = '$from$to'.toUpperCase();
        if (response['quotes'].containsKey(rateKey)) {
          return response['quotes'][rateKey];
        }
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch conversion rate: $e');
    }
  }
}


//
// class TradeService {
//   final ApiProvider apiProvider;
//
//   TradeService({required this.apiProvider});
//
//   Future<double?> getConversionRate(String from, String to) async {
//     try {
//       final response = await apiProvider.getExchangeRates(
//         baseCurrency: from,
//         symbols: [to],
//       );
//
//       if (response != null && response.containsKey('quotes')) {
//         final rateKey = '$from$to'.toUpperCase();
//         if (response['quotes'].containsKey(rateKey)) {
//           return response['quotes'][rateKey];
//         }
//       }
//       return null;
//     } catch (e) {
//       throw Exception('Failed to fetch conversion rate: $e');
//     }
//   }
// }