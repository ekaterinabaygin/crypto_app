import 'package:get/get.dart';
import '../../../features/auth/controller/auth_controller.dart';
import '../../../features/auth/data/auth_service.dart';
import '../../../features/home/data/crypto_service.dart';
import '../../../features/home/view_model/crypto_controller.dart';
import '../../../features/trade/data/trade_service.dart';
import '../../../features/trade/view_model/trade_controller.dart';
import '../../api_provider.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(() => ApiProvider(), fenix: true);

    Get.lazyPut<TradeService>(() => TradeService(apiProvider: Get.find<ApiProvider>()), fenix: true);

    Get.lazyPut<TradeController>(() => TradeController(tradeService: Get.find<TradeService>()), fenix: true);

    Get.lazyPut<CryptoService>(() => CryptoService(apiProvider: Get.find<ApiProvider>()), fenix: true);

    Get.lazyPut<CryptoController>(() => CryptoController(cryptoService: Get.find<CryptoService>()), fenix: true);

    Get.lazyPut<AuthService>(() => AuthService(), fenix: true);

    Get.lazyPut<AuthController>(() => AuthController(authService: Get.find<AuthService>()), fenix: true);
  }
}
