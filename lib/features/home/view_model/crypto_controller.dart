import 'package:get/get.dart';
import '../models/crypto_asset.dart';
import '../data/crypto_service.dart';
import '../utils/sort_option.dart';
class CryptoController extends GetxController {
  var cryptoAssets = <CryptoAsset>[].obs;
  var isLoading = true.obs;
  var hasMore = false.obs;
  var selectedSortOption = SortOption.name.obs;

  final List<SortOption> sortOptions = SortOption.values;
  final CryptoService cryptoService;
  CryptoController({required this.cryptoService});

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

  void sortAssets(SortOption option) {
    selectedSortOption.value = option;
    _sortAssets();
  }

  void _sortAssets() {
    if (selectedSortOption.value == SortOption.name) {
      cryptoAssets.sort((a, b) => a.name.compareTo(b.name));
    } else if (selectedSortOption.value == SortOption.price) {
      cryptoAssets.sort((a, b) => a.price.compareTo(b.price));
    }
  }
}
