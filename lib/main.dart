import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/dependency_injection.dart';
import 'features/home/view/home_page.dart';
import 'features/trade/view/trade_page.dart';
import 'core/auth_guard.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await GetStorage.init();  // Persistent storage
  DependencyInjection.init(); // Initialize controllers

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Crypto Trading App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.purple,
        scaffoldBackgroundColor: Colors.black,
      ),
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => HomePage()),
        GetPage(
          name: '/trade',
          page: () => TradePage(),
          middlewares: [AuthGuard()],  // Protect TradePage with AuthGuard
        ),
      ],
    );
  }
}
