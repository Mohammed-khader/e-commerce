class CategoryModel {
  final String? id;
  final String? name;
  final String? image;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
  });
  factory CategoryModel.fromJson(Map<String, dynamic> data) {
    return CategoryModel(
      id: data['id'],
      name: data['name'],
      image: data['image'],
    );
  }
}
