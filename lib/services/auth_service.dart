import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants.dart';
import '../core/local_storage.dart';

class AuthService {
  Future<bool> login(String email, String password) async {
    final res = await http.post(
      Uri.parse('${AppConstants.baseUrl}/api/auth/local'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'identifier': email, 'password': password}),
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      await LocalStorage.saveToken(data['jwt']);
      return true;
    } else {
      final error = jsonDecode(res.body);
      throw Exception(error['error']?['message'] ?? 'Login gagal');
    }
  }

  Future<bool> register(String username, String email, String password) async {
    final res = await http.post(
      Uri.parse('${AppConstants.baseUrl}/api/auth/local/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'email': email, 'password': password}),
    );

    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      await LocalStorage.saveToken(data['jwt']);
      return true;
    } else {
      final error = jsonDecode(res.body);
      throw Exception(error['error']?['message'] ?? 'Registrasi gagal');
    }
  }

  Future<void> logout() async {
    await LocalStorage.clear();
  }
}
