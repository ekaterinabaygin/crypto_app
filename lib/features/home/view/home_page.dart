import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/sticky_header.dart';
import '../view_model/crypto_controller.dart';

class HomePage extends StatelessWidget {
  final CryptoController cryptoController = Get.find<CryptoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const StickyHeader(),
      body: Obx(() {
        if (cryptoController.isLoading.value && cryptoController.cryptoAssets.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: cryptoController.cryptoAssets.length + 1, // +1 for the Load More button
          itemBuilder: (context, index) {
            if (index == cryptoController.cryptoAssets.length) {
              // This is the last item - Load More button
              if (cryptoController.hasMore.value) {
                return Center(
                  child: ElevatedButton(
                    onPressed: () {
                      int nextPage = (cryptoController.cryptoAssets.length ~/ 10) + 1;
                      cryptoController.fetchCryptoAssets(page: nextPage);
                    },
                    child: const Text('Load More'),
                  ),
                );
              } else {
                return const Center(child: Text('No more assets to load'));
              }
            }

            // Render the crypto asset list item
            final asset = cryptoController.cryptoAssets[index];
            return ListTile(
              leading: Image.network(asset.iconUrl, width: 40),
              title: Text(asset.name),
              subtitle: Text('\$${asset.price.toStringAsFixed(2)}'),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'Buy') {
                    print('Buy ${asset.name}');
                  } else if (value == 'Sell') {
                    print('Sell ${asset.name}');
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'Buy', child: Text('Buy')),
                  const PopupMenuItem(value: 'Sell', child: Text('Sell')),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}
