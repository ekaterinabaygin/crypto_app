class CryptoAsset {
  final String name;
  final double price;
  final String iconUrl;

  CryptoAsset({
    required this.name,
    required this.price,
    required this.iconUrl,
  });

  factory CryptoAsset.fromJson(Map<String, dynamic> json) {
    return CryptoAsset(
      name: json['name'] ?? 'Unknown',
      price: (json['current_price'] ?? 0.0).toDouble(),
      iconUrl: json['image'] ?? '',
    );
  }
}
