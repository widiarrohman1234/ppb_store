import 'package:flutter/foundation.dart' hide Category;
import '../models/category_model.dart';
import '../services/category_service.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryService _service = CategoryService();
  List<Category> categories = [];
  bool loading = false;

  Future<void> fetchCategories() async {
    loading = true;
    notifyListeners();
    categories = await _service.getCategories();
    loading = false;
    notifyListeners();
  }

  Future<void> addCategory(String name, String desc) async {
    await _service.createCategory(name, desc);
    await fetchCategories();
  }

  Future<void> updateCategory(String documentId, String name, String desc) async {
    await _service.updateCategory(documentId, name, desc);
    await fetchCategories();
  }

  Future<void> deleteCategory(String documentId) async {
    await _service.deleteCategory(documentId);
    await fetchCategories();
  }
}
