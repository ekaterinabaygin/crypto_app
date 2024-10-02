import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/sticky_header.dart';
import '../models/crypto_asset.dart';
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

        return Column(
          children: [
            _buildSortingOptions(),
            Expanded(
              child: ListView.builder(
                itemCount: cryptoController.cryptoAssets.length + 1,
                itemBuilder: (context, index) {
                  if (index == cryptoController.cryptoAssets.length) {
                    return _buildLoadMoreButton();
                  }

                  final asset = cryptoController.cryptoAssets[index];
                  return _buildCryptoItem(asset);
                },
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _buildSortingOptions() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text('Sort by: '),
          DropdownButton<String>(
            value: cryptoController.selectedSortOption.value,
            items: cryptoController.sortOptions.map((option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            onChanged: (value) {
              cryptoController.sortAssets(value!);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCryptoItem(CryptoAsset asset) {
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
  }

  Widget _buildLoadMoreButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          int nextPage = (cryptoController.cryptoAssets.length ~/ 10) + 1;
          cryptoController.fetchCryptoAssets(page: nextPage);
        },
        child: const Text('Load More'),
      ),
    );
  }
}