import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TradeController extends GetxController {
  var cryptoList = ['BTC', 'ETH', 'LTC'].obs;
  var selectedCrypto = 'BTC'.obs;

  var isCryptoInputMode = true.obs;

  TextEditingController cryptoAmountController = TextEditingController();
  TextEditingController fiatAmountController = TextEditingController();

  var cryptoAmount = 0.0.obs;
  var fiatAmount = 0.0.obs;

  var conversionRate = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchConversionRate();
  }

  Future<void> fetchConversionRate() async {
    final String apiUrl = 'https://api.exchangerate.host/live';
    try {
      final response = await http.get(
        Uri.parse(apiUrl).replace(
          queryParameters: {
            'access_key': '403da6dfef81906bcaaf337abe527cd9', // Your access key
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Check if the 'quotes' and 'USDBTC' fields are present
        if (data['quotes'] != null && data['quotes']['USDBTC'] != null) {
          conversionRate.value = 1 / data['quotes']['USDBTC']; // Convert USD to BTC rate
          print('Conversion rate (BTC to USD) fetched: ${conversionRate.value}');
        } else {
          conversionRate.value = 0.0;
          Get.snackbar('Error', 'BTC rate not available. Please try again.');
          print('Error: BTC rate not available in the API response.');
        }
      } else {
        conversionRate.value = 0.0;
        Get.snackbar('Error', 'Failed to load conversion rates. Status Code: ${response.statusCode}');
        print('Error: Failed to fetch conversion rate. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      conversionRate.value = 0.0;
      Get.snackbar('Error', 'Failed to fetch rates: $e');
      print('Error fetching conversion rates: $e');
    }

    if (isCryptoInputMode.value) {
      updateFiatAmount(double.tryParse(cryptoAmountController.text) ?? 0.0);
    } else {
      updateCryptoAmount(double.tryParse(fiatAmountController.text) ?? 0.0);
    }
  }



  void selectCrypto(String? value) {
    if (value != null) {
      selectedCrypto.value = value;
      fetchConversionRate();
    }
  }

  // Method to update the fiat equivalent when the user inputs a crypto amount
  void updateFiatAmount(double cryptoAmount) {
    if (conversionRate.value == 0.0 || cryptoAmount == 0.0) {
      fiatAmount.value = 0.0; // Handle case when the rate or input is 0
    } else {
      fiatAmount.value = (cryptoAmount * conversionRate.value).toPrecision(2);
    }
    fiatAmountController.text = fiatAmount.value.toStringAsFixed(2);
  }

  void updateCryptoAmount(double fiatAmount) {
    if (conversionRate.value == 0.0 || fiatAmount == 0.0) {
      cryptoAmount.value = 0.0; // Handle case when the rate or input is 0
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
  }}