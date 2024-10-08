import 'package:get_storage/get_storage.dart';

class AuthService {
  final GetStorage storage = GetStorage();

  bool isLoggedIn() {
    return storage.read('isLoggedIn') ?? false;
  }

  void login(String email, String password) {
    storage.write('isLoggedIn', true);  // Assume successful login for now
  }

  void logout() {
    storage.write('isLoggedIn', false);  // Mark user as logged out
  }
}