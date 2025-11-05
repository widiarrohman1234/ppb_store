class Product {
  final int id;
  final String? id_category;
  final String? category_name;
  final String documentId;
  final String name;
  final String? description;
  final bool available;
  final int stock;

 
  Product({
    required this.id,
    this.id_category,
    this.category_name, 
    required this.documentId,
    required this.name,
    this.description,
    required this.available,
    required this.stock,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      id_category: json['id_category'] ?? '',
      category_name: json['category_name'] ?? '',
      documentId: json['documentId'] ?? '',
      name: json['name'] ?? '',
      description: json['description'],
      available: json['available'] ?? false,
      stock: json['stock'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": {
        "name": name,
        "available": available,
        "stock": stock,
        "id_category": id_category,
        "description": description,
      }
    };
  }
}
