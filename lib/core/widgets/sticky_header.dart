import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../features/auth/view/login_modal.dart';
import '../../features/auth/view_model/auth_controller.dart';

class StickyHeader extends StatelessWidget implements PreferredSizeWidget {
  final bool automaticallyImplyLeading;

  const StickyHeader({
    super.key,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () => Get.offNamed('/home'),
            child: const Text('Home', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () {
              if (authController.isLoggedIn.value) {
                Get.offNamed('/trade');
              } else {
                Get.snackbar(
                  'Access Denied',
                  'You must be logged in to access this page.',
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            },
            child: const Text('Trade', style: TextStyle(color: Colors.white)),
          ),
          const Spacer(),
          Obx(() => authController.isLoggedIn.value
              ? TextButton(
            onPressed: authController.logout,
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          )
              : TextButton(
            onPressed: () => Get.dialog(LoginModal()),
            child: const Text('Login', style: TextStyle(color: Colors.white)),
          )),
        ],
      ),
      backgroundColor: Colors.purple,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}