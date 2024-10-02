import 'package:get/get.dart';
import '../models/crypto_asset.dart';
import '../data/crypto_service.dart';

class CryptoController extends GetxController {
  var cryptoAssets = <CryptoAsset>[].obs;
  var isLoading = true.obs;
  var hasMore = false.obs;

  final CryptoService homeService = CryptoService();

  @override
  void onInit() {
    super.onInit();
    fetchCryptoAssets();
  }

  Future<void> fetchCryptoAssets({int page = 1}) async {
    isLoading(true);
    try {
      final assets = await homeService.fetchCryptoAssets(page: page);
      if (assets.isNotEmpty) {
        cryptoAssets.addAll(assets);
        hasMore.value = assets.length == 10;
      }
    } catch (e) {
      print('Error fetching assets: $e');
    } finally {
      isLoading(false);
    }
  }
}
