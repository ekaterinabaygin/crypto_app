import 'package:get/get.dart';
import '../features/auth/controller/auth_controller.dart';
import '../features/home/view_model/crypto_controller.dart';
import '../features/trade/view_model/trade_controller.dart';

class DependencyInjection {
  static void init() {
    Get.lazyPut<TradeController>(() => TradeController(), fenix: true);
    Get.lazyPut<CryptoController>(() => CryptoController(), fenix: true);
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
  }
}