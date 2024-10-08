import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/sticky_header.dart';
import '../../auth/view_model/auth_controller.dart';
import '../view_model/trade_controller.dart';

class TradePage extends StatelessWidget {
  const TradePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TradeController tradeController = Get.find<TradeController>();
    final AuthController authController = Get.find<AuthController>();

    return Scaffold(
      appBar: const StickyHeader(automaticallyImplyLeading: false),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (!authController.isLoggedIn.value) {
            return const Center(
              child: Text(
                'Login to access this page',
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
            );
          }

          if (tradeController.isLoading.value) {
            return const CircularProgressIndicator();
          }

          if (tradeController.errorMessage.isNotEmpty) {
            return Text(
              tradeController.errorMessage.value,
              style: const TextStyle(color: Colors.red),
            );
          }

          return Column(
            children: [
              DropdownButton<String>(
                value: tradeController.selectedCrypto.value,
                items: tradeController.cryptoList.map((crypto) {
                  return DropdownMenuItem<String>(
                    value: crypto,
                    child: Text(crypto),
                  );
                }).toList(),
                onChanged: (value) => tradeController.selectCrypto(value),
              ),
              const SizedBox(height: 20),
              Obx(() {
                return TextField(
                  controller: tradeController.isCryptoInputMode.value
                      ? tradeController.cryptoAmountController
                      : tradeController.fiatAmountController,
                  decoration: InputDecoration(
                    labelText: tradeController.isCryptoInputMode.value
                        ? 'Crypto Amount'
                        : 'Fiat Amount (USD)',
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    double inputAmount = double.tryParse(value) ?? 0.0;
                    if (tradeController.isCryptoInputMode.value) {
                      tradeController.updateFiatAmount(inputAmount);
                    } else {
                      tradeController.updateCryptoAmount(inputAmount);
                    }
                  },
                );
              }),
              const SizedBox(height: 20),
              Obx(() => Text(
                tradeController.isCryptoInputMode.value
                    ? 'Fiat Equivalent: \$${tradeController.fiatAmount.value.toStringAsFixed(2)}'
                    : 'Crypto Equivalent: ${tradeController.cryptoAmount.value.toStringAsFixed(6)} ${tradeController.selectedCrypto.value}',
                style: const TextStyle(fontSize: 16),
              )),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: tradeController.swapInputMode,
                child: const Text('Swap'),
              ),
            ],
          );
        }),
      ),
    );
  }
}