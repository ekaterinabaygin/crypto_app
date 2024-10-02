import 'package:flutter/material.dart';
import '../models/crypto_asset.dart';

class CryptoItem extends StatelessWidget {
  final CryptoAsset asset;

  const CryptoItem({Key? key, required this.asset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        },
        itemBuilder: (context) => const [
          PopupMenuItem(value: 'buy', child: Text('Buy')),
          PopupMenuItem(value: 'sell', child: Text('Sell')),
        ],
      ),
    );
  }
}
