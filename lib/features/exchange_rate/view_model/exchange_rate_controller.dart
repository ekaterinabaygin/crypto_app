import 'package:get/get.dart';
import '../../../core/api_provider.dart';

class ExchangeRateController extends GetxController {
  var exchangeRates = <String, dynamic>{}.obs;
  var isLoading = true.obs;
  final ApiProvider _apiProvider = Get.find<ApiProvider>();

  // Fetch exchange rates with GetX reactive state management
  void fetchExchangeRates(String baseCurrency) async {
    isLoading(true);
    final data = await _apiProvider.fetchLiveExchangeRates(baseCurrency: baseCurrency, symbols: ['USDEUR', 'USDGBP', 'USDJPY']);

    if (data != null) {
      exchangeRates.value = data;
      print("Exchange rate fetched: ${exchangeRates.value}");
    } else {
      print("Failed to fetch exchange rates.");
      Get.snackbar('Error', 'Invalid data received from API');
    }

    isLoading(false);
  }
}
