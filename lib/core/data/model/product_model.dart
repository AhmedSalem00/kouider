class ProductModel {
  final String name;
  final double price;
  final String imageUrl;
  final String description;

  ProductModel({
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
  });

  // Updated fromJson method to correctly parse the response
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'] ?? '',
      price: json['price'] != null ? double.tryParse(json['price'].toString()) ?? 0.0 : 0.0,
      imageUrl: json['main_img'] != null ? json['main_img']['src'] ?? '' : '',
      description: json['description'] ?? '', // You might need to adjust based on available fields in the response
    );
  }
}
