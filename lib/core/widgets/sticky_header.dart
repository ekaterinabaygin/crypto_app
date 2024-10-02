import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../features/auth/controller/auth_controller.dart';
import '../../features/auth/view/login_modal.dart';

class StickyHeader extends StatelessWidget implements PreferredSizeWidget {
  const StickyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () => Get.offAllNamed('/home'),
            child: const Text('Home', style: TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () => Get.toNamed('/trade'),
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
