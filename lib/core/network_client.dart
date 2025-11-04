import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';
import 'local_storage.dart';

class NetworkClient {
  static Future<http.Response> get(String endpoint) async {
    final token = await LocalStorage.getToken();
    return http.get(
      Uri.parse('${AppConstants.baseUrl}$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
  }

  static Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final token = await LocalStorage.getToken();
    return http.post(
      Uri.parse('${AppConstants.baseUrl}$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
  }

  static Future<http.Response> put(String endpoint, Map<String, dynamic> body) async {
    final token = await LocalStorage.getToken();
    return http.put(
      Uri.parse('${AppConstants.baseUrl}$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );
  }

  static Future<http.Response> delete(String endpoint) async {
    final token = await LocalStorage.getToken();
    return http.delete(
      Uri.parse('${AppConstants.baseUrl}$endpoint'),
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
  }
}
