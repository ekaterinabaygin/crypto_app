import '../models/crypto_asset.dart';

abstract class CryptoService {
  Future<List<CryptoAsset>> fetchCryptoAssets({required int page});
}
