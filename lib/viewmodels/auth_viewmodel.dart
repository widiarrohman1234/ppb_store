import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';
import '../core/local_storage.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _service = AuthService();

  bool loading = false;
  bool isLoggedIn = false;

  Future<void> checkLoginStatus() async {
    final token = await LocalStorage.getToken();
    isLoggedIn = token != null;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    loading = true;
    notifyListeners();
    try {
      await _service.login(email, password);
      isLoggedIn = true;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> register(String username, String email, String password) async {
    loading = true;
    notifyListeners();
    try {
      await _service.register(username, email, password);
      isLoggedIn = true;
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    await _service.logout();
    isLoggedIn = false;
    notifyListeners();
  }
}
