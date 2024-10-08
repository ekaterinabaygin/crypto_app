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

  bool login(String email, String password) {
    if (email.isNotEmpty && password.isNotEmpty) {
      authService.login(email, password);
      isLoggedIn.value = true;
      return true;  // Success
    } else {
      return false;  // Failure
    }
  }

  bool logout() {
    authService.logout();
    isLoggedIn.value = false;
    return true;
  }
}