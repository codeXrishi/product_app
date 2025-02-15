class Product {
  final int id;
  final String title;
  final double price;
  final String category;
  final String description; // ✅ Add this field
  final String thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description, // ✅ Add this field
    required this.thumbnail,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      price: (json['price'] as num).toDouble(),
      category: json['category'] ?? "Unknown",
      description: json['description'] ?? "No description available", // ✅ Ensure it exists
      thumbnail: json['thumbnail'],
    );
  }
}
