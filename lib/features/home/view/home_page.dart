import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/widgets/sticky_header.dart';
import '../view_model/crypto_controller.dart';
import '../models/crypto_asset.dart';
import '../utils/sort_option.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final CryptoController cryptoController = Get.find<CryptoController>();

    return Scaffold(
      appBar: const StickyHeader(),
      body: Obx(() {
        if (cryptoController.isLoading.value && cryptoController.cryptoAssets.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return Column(
          children: [
            _buildSortingOptions(cryptoController),
            Expanded(
              child: ListView.builder(
                itemCount: cryptoController.cryptoAssets.length + 1,
                itemBuilder: (context, index) {
                  if (index == cryptoController.cryptoAssets.length) {
                    return _buildLoadMoreButton(cryptoController);
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

  Widget _buildSortingOptions(CryptoController cryptoController) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Text('Sort by: '),
          DropdownButton<SortOption>(
            value: cryptoController.selectedSortOption.value,
            items: cryptoController.sortOptions.map((option) {
              return DropdownMenuItem<SortOption>(
                value: option,
                child: Text(option.displayName),
              );
            }).toList(),
            onChanged: (value) {
              if (value != null) {
                cryptoController.sortAssets(value);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLoadMoreButton(CryptoController cryptoController) {
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

  Widget _buildCryptoItem(CryptoAsset asset) {
    return ListTile(
      leading: Image.network(
        asset.iconUrl,
        width: 40,
        height: 40,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported),
      ),
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
        itemBuilder: (context) => const [
          PopupMenuItem(value: 'Buy', child: Text('Buy')),
          PopupMenuItem(value: 'Sell', child: Text('Sell')),
        ],
      ),
    );
  }
}