import 'package:get/get.dart';
import '../features/home/view/home_page.dart';
import '../features/trade/view/trade_page.dart';
import '../core/auth_guard.dart';

class AppRoutes {
  static const String home = '/home';
  static const String trade = '/trade';

  static final routes = [
    GetPage(name: home, page: () => HomePage()),
    GetPage(name: trade, page: () => TradePage(), middlewares: [AuthGuard()]),
  ];
}
