import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theming/colors.dart';  // New import
import '../../../core/theming/text_styles.dart';  // New import
import '../../../core/widgets/sticky_header.dart';
import '../models/crypto_asset.dart';
import '../view_model/crypto_controller.dart';
import '../utils/sort_option.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final CryptoController cryptoController = Get.find<CryptoController>();

    return Scaffold(
      appBar: const StickyHeader(),
      backgroundColor: AppColors.background,  // Updated
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
          const Text('Sort by: ', style: AppTypography.regular16),
          DropdownButton<SortOption>(
            value: cryptoController.selectedSortOption.value,
            items: cryptoController.sortOptions.map((option) {
              return DropdownMenuItem<SortOption>(
                value: option,
                child: Text(option.displayName, style: AppTypography.regular16),
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
        onPressed: () async {
          int nextPage = (cryptoController.cryptoAssets.length ~/ 10) + 1;
          bool success = await cryptoController.fetchCryptoAssets(page: nextPage);
          if (!success) {
            Get.snackbar('Error', 'Failed to load more assets');
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
        ),
        child: const Text('Load More', style: AppTypography.regular16),
      ),
    );
  }

  Widget _buildCryptoItem(CryptoAsset asset) {
    return ListTile(
      leading: Image.network(
        asset.iconUrl,
        width: 40,
        height: 40,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, color: AppColors.red),
      ),
      title: Text(asset.name, style: AppTypography.bold18),
      subtitle: Text('\$${asset.price.toStringAsFixed(2)}', style: AppTypography.regular16),
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          if (value == 'Buy') {
            print('Buy ${asset.name}');
          } else if (value == 'Sell') {
            print('Sell ${asset.name}');
          }
        },
        itemBuilder: (context) => const [
          PopupMenuItem(value: 'Buy', child: Text('Buy', style: AppTypography.regular16)),
          PopupMenuItem(value: 'Sell', child: Text('Sell', style: AppTypography.regular16)),
        ],
      ),
    );
  }
}