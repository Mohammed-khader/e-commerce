class ProductsModel {
  final String id;
  final String name;
  final String image;
  final String description;
  final double price;
  int? count;

  ProductsModel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.price,
    this.count,
  });
  factory ProductsModel.fromJson(Map<String, dynamic> product) {
    return ProductsModel(
      description: product['description'],
      id: product['id'],
      name: product['name'],
      image: product['image'],
      price: product['price'],
      count: product['count'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
      'price': price,
      'count': count,
    };
  }
}
