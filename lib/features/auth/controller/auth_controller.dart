import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  var isLoggedIn = false.obs;
  final GetStorage storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    isLoggedIn.value = storage.read('isLoggedIn') ?? false;
  }

  void login(String email, String password) {
    if (email.isNotEmpty && password.isNotEmpty) {
      isLoggedIn.value = true;
      storage.write('isLoggedIn', true);
      Get.offAllNamed('/home');
    } else {
      Get.snackbar('Login Failed', 'Please enter both email and password');
    }
  }

  void logout() {
    isLoggedIn.value = false;
    storage.write('isLoggedIn', false);
    Get.offAllNamed('/home');
  }
}