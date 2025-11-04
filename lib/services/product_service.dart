import 'dart:convert';
import '../core/network_client.dart';
import '../models/product_model.dart';

class ProductService {
  Future<List<Product>> getProducts() async {
    final res = await NetworkClient.get('/api/products');
    final json = jsonDecode(res.body);

    if (res.statusCode == 200) {
      final list = (json['data'] as List)
          .map((item) => Product.fromJson(item))
          .toList();
      return list;
    } else {
      throw Exception(json['error']?['message'] ?? 'Gagal memuat produk');
    }
  }

  Future<void> createProduct(Product product) async {
    final res = await NetworkClient.post('/api/products', product.toJson());
    if (res.statusCode != 201) {
      throw Exception('Gagal menambahkan produk');
    }
  }

  Future<void> updateProduct(String documentId, Product product) async {
    final res = await NetworkClient.put(
      '/api/products/$documentId',
      product.toJson(),
    );
    if (res.statusCode != 200) {
      throw Exception('Gagal mengupdate produk');
    }
  }

  Future<void> deleteProduct(String documentId) async {
    final res = await NetworkClient.delete('/api/products/$documentId');
    if (res.statusCode != 200 && res.statusCode != 204) {
      throw Exception('Gagal menghapus produk');
    }
  }

  Future<void> createProductFromJson(Map<String, dynamic> body) async {
    final res = await NetworkClient.post('/api/products', body);
    if (res.statusCode != 201) {
      throw Exception('Gagal menambah produk');
    }
  }

  Future<void> updateProductFromJson(
    String id,
    Map<String, dynamic> body,
  ) async {
    final res = await NetworkClient.put('/api/products/$id', body);
    if (res.statusCode != 200) {
      throw Exception('Gagal mengupdate produk');
    }
  }
}
