import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:crypto_trading_app/features/auth/controller/auth_controller.dart';

class AuthGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();

    if (!authController.isLoggedIn.value) {
      Get.snackbar(
        'Access Denied',
        'You must be logged in to access this page',
        snackPosition: SnackPosition.BOTTOM,
      );
      return const RouteSettings(name: '/home');
    }
    return null;
  }
}