import 'package:get/get.dart';
import '../data/auth_service.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  final AuthService authService;

  AuthController({required this.authService});

  @override
  void onInit() {
    super.onInit();
    isLoggedIn.value = authService.isLoggedIn();
  }

  void login(String email, String password) {
    if (email.isNotEmpty && password.isNotEmpty) {
      authService.login(email, password);
      isLoggedIn.value = true;
      Get.offAllNamed('/home');
    } else {
      Get.snackbar('Login Failed', 'Please enter both email and password');
    }
  }

  void logout() {
    authService.logout();
    isLoggedIn.value = false;
    Get.offAllNamed('/home');
  }
}