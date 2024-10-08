import 'package:get_storage/get_storage.dart';
import '../data/auth_service.dart';

class AuthServiceImpl implements AuthService {
  final GetStorage storage = GetStorage();

  @override
  bool isLoggedIn() {
    return storage.read('isLoggedIn') ?? false;
  }

  @override
  void login(String email, String password) {
    storage.write('isLoggedIn', true);
  }

  @override
  void logout() {
    storage.write('isLoggedIn', false);
  }
}