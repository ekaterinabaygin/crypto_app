import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../features/auth/controller/auth_controller.dart';
import '../../features/auth/view/login_modal.dart';
import '../../core/theming/colors.dart';  // New import
import '../../core/theming/text_styles.dart';  // New import

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
            child: const Text('Home', style: AppTypography.bold18),
          ),
          const SizedBox(width: 10),
          TextButton(
            onPressed: () => Get.toNamed('/trade'),
            child: const Text('Trade', style: AppTypography.bold18),
          ),
          const Spacer(),
          Obx(() => authController.isLoggedIn.value
              ? TextButton(
            onPressed: authController.logout,
            child: const Text('Logout', style: AppTypography.bold18),
          )
              : TextButton(
            onPressed: () => Get.dialog(LoginModal()),
            child: const Text('Login', style: AppTypography.bold18),
          )),
        ],
      ),
      backgroundColor: AppColors.primary,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}