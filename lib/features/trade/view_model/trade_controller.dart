import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../data/trade_service.dart';

class TradeController extends GetxController {
  final TradeService tradeService;

  TradeController({required this.tradeService});

  var cryptoList = ['BTC', 'ETH', 'LTC'].obs;
  var selectedCrypto = 'BTC'.obs;
  var isCryptoInputMode = true.obs;

  late TextEditingController cryptoAmountController;
  late TextEditingController fiatAmountController;

  var cryptoAmount = 0.0.obs;
  var fiatAmount = 0.0.obs;
  var conversionRate = 0.0.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    cryptoAmountController = TextEditingController();
    fiatAmountController = TextEditingController();
    fetchConversionRate();
  }

  @override
  void onClose() {
    cryptoAmountController.dispose();
    fiatAmountController.dispose();
    super.onClose();
  }

  Future<void> fetchConversionRate() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      final rate = await tradeService.getConversionRate('USD', selectedCrypto.value);
      if (rate != null) {
        conversionRate.value = rate;
      } else {
        errorMessage.value = 'Conversion rate not available.';
        conversionRate.value = 0.0;
      }
    } catch (e) {
      errorMessage.value = 'Failed to fetch conversion rate: $e';
      conversionRate.value = 0.0;
    } finally {
      isLoading.value = false;
    }

    if (isCryptoInputMode.value) {
      updateFiatAmount(double.tryParse(cryptoAmountController.text) ?? 0.0);
    } else {
      updateCryptoAmount(double.tryParse(fiatAmountController.text) ?? 0.0);
    }
  }

  void updateFiatAmount(double cryptoAmount) {
    if (conversionRate.value == 0.0 || cryptoAmount == 0.0) {
      fiatAmount.value = 0.0;
    } else {
      fiatAmount.value = (cryptoAmount * conversionRate.value).toPrecision(2);
    }
    fiatAmountController.text = fiatAmount.value.toStringAsFixed(2);
  }

  void updateCryptoAmount(double fiatAmount) {
    if (conversionRate.value == 0.0 || fiatAmount == 0.0) {
      cryptoAmount.value = 0.0;
    } else {
      cryptoAmount.value = (fiatAmount / conversionRate.value).toPrecision(6);
    }
    cryptoAmountController.text = cryptoAmount.value.toStringAsFixed(6);
  }

  void swapInputMode() {
    isCryptoInputMode.value = !isCryptoInputMode.value;

    if (isCryptoInputMode.value) {
      double fiatAmountValue = double.tryParse(fiatAmountController.text) ?? 0.0;
      if (fiatAmountValue != 0.0 && conversionRate.value != 0.0) {
        updateCryptoAmount(fiatAmountValue);
      }
    } else {
      double cryptoAmountValue = double.tryParse(cryptoAmountController.text) ?? 0.0;
      if (cryptoAmountValue != 0.0 && conversionRate.value != 0.0) {
        updateFiatAmount(cryptoAmountValue);
      }
    }
  }

  void selectCrypto(String? value) {
    if (value != null) {
      selectedCrypto.value = value;
      fetchConversionRate();
    }
  }
}