import 'package:flutter/foundation.dart';
import '../models/product_model.dart';
import '../services/product_service.dart';

class ProductViewModel extends ChangeNotifier {
  final ProductService _service = ProductService();

  List<Product> products = [];
  bool loading = false;

  Future<void> fetchProducts() async {
    loading = true;
    notifyListeners();

    try {
      products = await _service.getProducts();
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<void> addProduct(Product product) async {
    await _service.createProduct(product);
    await fetchProducts();
  }

  Future<void> updateProduct(String documentId, Product product) async {
    await _service.updateProduct(documentId, product);
    await fetchProducts();
  }

  Future<void> deleteProduct(String documentId) async {
    await _service.deleteProduct(documentId);
    await fetchProducts();
  }

  Future<void> addProductFromJson(Map<String, dynamic> data) async {
  await _service.createProductFromJson(data);
  await fetchProducts();
}

Future<void> updateProductFromJson(String id, Map<String, dynamic> data) async {
  await _service.updateProductFromJson(id, data);
  await fetchProducts();
}

}
