import 'package:get/get.dart';
import '../models/crypto_asset.dart';
import '../data/crypto_service.dart';

class CryptoController extends GetxController {
  var cryptoAssets = <CryptoAsset>[].obs;
  var isLoading = true.obs;
  var hasMore = false.obs;
  var selectedSortOption = 'Name'.obs;

  final List<String> sortOptions = ['Name', 'Price'];
  final CryptoService cryptoService = CryptoService();

  @override
  void onInit() {
    super.onInit();
    fetchCryptoAssets();
  }

  Future<void> fetchCryptoAssets({int page = 1}) async {
    isLoading(true);
    try {
      final assets = await cryptoService.fetchCryptoAssets(page: page);
      if (assets.isNotEmpty) {
        cryptoAssets.addAll(assets);
        hasMore.value = assets.length == 10;
        _sortAssets();
      }
    } catch (e) {
      print('Error fetching assets: $e');
    } finally {
      isLoading(false);
    }
  }

  void sortAssets(String option) {
    selectedSortOption.value = option;
    _sortAssets();
  }

  void _sortAssets() {
    if (selectedSortOption.value == 'Name') {
      cryptoAssets.sort((a, b) => a.name.compareTo(b.name));
    } else if (selectedSortOption.value == 'Price') {
      cryptoAssets.sort((a, b) => a.price.compareTo(b.price));
    }
  }
}