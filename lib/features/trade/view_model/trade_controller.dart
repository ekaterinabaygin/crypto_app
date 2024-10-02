import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TradeController extends GetxController {
  var cryptoList = ['Bitcoin', 'Ethereum', 'Litecoin'].obs;
  var selectedCrypto = 'Bitcoin'.obs;
  TextEditingController cryptoAmountController = TextEditingController();
  var fiatAmount = 0.0.obs;
  var conversionRate = <String, double>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchConversionRates();
  }
  Future<void> fetchConversionRates() async {
    const apiUrl = 'https://api.exchangerate.host/latest';

    try {
      final response = await http.get(
        Uri.parse(apiUrl).replace(
          queryParameters: {
            'base': 'USD',
            'symbols': 'BTC,ETH,LTC',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['rates'] != null) {
          // Correctly access rates for each currency
          conversionRate['Bitcoin'] = data['rates']['BTC'] ?? 0.0;
          conversionRate['Ethereum'] = data['rates']['ETH'] ?? 0.0;
          conversionRate['Litecoin'] = data['rates']['LTC'] ?? 0.0;

          // Recalculate the fiat amount based on the fetched rates
          updateFiatAmount(double.tryParse(cryptoAmountController.text) ?? 0.0);
        } else {
          Get.snackbar('Error', 'Invalid data received from API');
        }
      } else {
        Get.snackbar('Error', 'Failed to load conversion rates');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch rates: $e');
    }
  }

  void selectCrypto(String? value) {
    if (value != null) {
      selectedCrypto.value = value;
      updateFiatAmount(double.tryParse(cryptoAmountController.text) ?? 0.0);
    }
  }
  void updateFiatAmount(double cryptoAmount) {
    final rate = conversionRate[selectedCrypto.value] ?? 0.0;
    fiatAmount.value = cryptoAmount * rate;
  }
  void swapValues() {
    Get.snackbar(
      'Swap Successful',
      'Swapped ${cryptoAmountController.text} ${selectedCrypto.value} for \$${fiatAmount.value.toStringAsFixed(2)}',
    );
  }
}
