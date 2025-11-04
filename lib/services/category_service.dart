import 'dart:convert';
import '../core/network_client.dart';
import '../models/category_model.dart';

class CategoryService {
  Future<List<Category>> getCategories() async {
    final res = await NetworkClient.get('/api/categories');
    final data = jsonDecode(res.body);
    return (data['data'] as List)
        .map((item) => Category.fromJson(item))
        .toList();
  }

  Future<void> createCategory(String name, String? desc) async {
    await NetworkClient.post('/api/categories', {
      "data": {"name": name, "description": desc}
    });
  }

  Future<void> updateCategory(String documentId, String name, String? desc) async {
    await NetworkClient.put('/api/categories/$documentId', {
      "data": {"name": name, "description": desc}
    });
  }

  Future<void> deleteCategory(String documentId) async {
    await NetworkClient.delete('/api/categories/$documentId');
  }
}
