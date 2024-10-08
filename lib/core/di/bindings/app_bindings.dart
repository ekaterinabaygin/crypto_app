import 'package:get/get.dart';
import '../../../features/auth/data/auth_service.dart';
import '../../../features/auth/data/auth_service_impl.dart';
import '../../../features/auth/view_model/auth_controller.dart';
import '../../../features/home/data/crypto_service.dart';
import '../../../features/home/data/crypto_service_impl.dart'; // Подключаем реализацию
import '../../../features/home/view_model/crypto_controller.dart';
import '../../../features/trade/data/trade_service.dart';
import '../../../features/trade/data/trade_service_impl.dart';
import '../../../features/trade/view_model/trade_controller.dart';
import '../../api_provider.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(() => ApiProvider(), fenix: true);

    Get.lazyPut<TradeService>(() => TradeServiceImpl(apiProvider: Get.find<ApiProvider>()), fenix: true);
    Get.lazyPut<TradeController>(() => TradeController(tradeService: Get.find<TradeService>()), fenix: true);

    Get.lazyPut<AuthService>(() => AuthServiceImpl(), fenix: true);
    Get.lazyPut<AuthController>(() => AuthController(authService: Get.find<AuthService>()), fenix: true);

    Get.lazyPut<CryptoService>(() => CryptoServiceImpl(apiProvider: Get.find<ApiProvider>()), fenix: true);
    Get.lazyPut<CryptoController>(() => CryptoController(cryptoService: Get.find<CryptoService>()), fenix: true);
  }
}