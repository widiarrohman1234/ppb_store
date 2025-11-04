import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class UserViewModel extends ChangeNotifier {
  final UserService _service = UserService();

  User? user;
  bool loading = false;

  Future<void> fetchUser() async {
    loading = true;
    notifyListeners();

    try {
      user = await _service.getCurrentUser();
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
