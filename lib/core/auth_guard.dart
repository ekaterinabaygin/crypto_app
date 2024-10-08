import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../features/auth/view_model/auth_controller.dart';

class AuthGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();

    if (!authController.isLoggedIn.value) {
      Get.snackbar(
        'Access Denied',
        'You must be logged in to access the Trade page.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return const RouteSettings(name: '/home');
    }
    return null;
  }
}