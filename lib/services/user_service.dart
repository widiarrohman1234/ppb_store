import 'dart:convert';
import '../core/network_client.dart';
import '../models/user_model.dart';

class UserService {
  Future<User> getCurrentUser() async {
    final res = await NetworkClient.get('/api/users/me');

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      return User.fromJson(data);
    } else {
      throw Exception('Gagal mengambil data pengguna');
    }
  }
}
