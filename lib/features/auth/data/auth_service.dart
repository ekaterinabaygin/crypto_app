abstract class AuthService {
  bool isLoggedIn();
  void login(String email, String password);
  void logout();
}