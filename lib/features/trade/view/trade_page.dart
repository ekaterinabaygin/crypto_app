import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view_model/trade_controller.dart';
import '../../../core/widgets/sticky_header.dart';

class TradePage extends StatelessWidget {
  const TradePage({super.key});

  @override
  Widget build(BuildContext context) {
    final tradeController = Get.find<TradeController>();

    return Scaffold(
      appBar: const StickyHeader(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown for selecting the cryptocurrency
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

            TextField(
              controller: tradeController.cryptoAmountController,
              decoration: const InputDecoration(labelText: 'Crypto Amount'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                double cryptoAmount = double.tryParse(value) ?? 0.0;
                tradeController.updateFiatAmount(cryptoAmount);
              },
            ),
            const SizedBox(height: 20),

            Obx(() => Text(
              'Fiat Equivalent: \$${tradeController.fiatAmount.value.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 16),
            )),

            const SizedBox(height: 20),

            // Swap Button
            ElevatedButton(
              onPressed: tradeController.swapValues,
              child: const Text('Swap'),
            ),
          ],
        ),
      ),
    );
  }
}
