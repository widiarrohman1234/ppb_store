class Category {
  final int id;
  final String name;
  final String documentId;
  final String? description;

  Category({
    required this.id,
    required this.name,
    required this.documentId,
    this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      documentId: json['documentId'],
      name: json['name'] ?? '',
      description: json['description'],
    );
  }
  @override
  String toString() {
    // Kembalikan representasi string yang ingin Anda lihat di konsol
    return 'Category(id: $id, documentId: $documentId, name: $name, description: $description)';
  }
}
