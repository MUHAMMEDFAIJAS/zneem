class CategoryModel {
  final int id;
  final String categoryName;
  final int companyId;
  final String description;
  final String imageUrl;
  final DateTime createdAt;

  CategoryModel({
    required this.id,
    required this.categoryName,
    required this.companyId,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      categoryName: json['category_name'],
      companyId: json['company_id'],
      description: json['description'],
      imageUrl: json['image_url'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
