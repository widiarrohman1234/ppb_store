class Product {
  final int id;
  final String name;
  final String documentId;
  final String? description;
  final bool available;
  final int stock;
  final String? id_category;

  Product({
    required this.id,
    required this.name,
    required this.documentId,
    this.description,
    required this.available,
    required this.stock,
    this.id_category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      documentId: json['documentId'] ?? '',
      description: json['description'],
      available: json['available'] ?? false,
      stock: json['stock'] ?? 0,
      id_category: json['id_category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": {
        "name": name,
        "description": description,
        "available": available,
        "stock": stock,
        "id_category": id_category,
      }
    };
  }
}
