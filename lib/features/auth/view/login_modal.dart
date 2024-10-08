import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../view_model/auth_controller.dart';

class LoginModal extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authController = Get.find<AuthController>();

  LoginModal({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Login'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            final email = emailController.text.trim();
            final password = passwordController.text.trim();

            bool isSuccess = authController.login(email, password);

            if (isSuccess) {
              Get.back();
              Get.offAllNamed('/trade');
            } else {
              Get.snackbar('Login Failed', 'Please enter both email and password');
            }
          },
          child: const Text('Login'),
        ),
      ],
    );
  }
}