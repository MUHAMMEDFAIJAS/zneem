class ProductModel {
  final int id;
  final String primaryCode;
  final String imageUrl;
  final String productName;
  final String barcode;
  final String description;
  final String expiresAt;
  final String countryOfOrigin;
  final int companyId;
  final int supplierId;
  final int categoryId;
  final double price; 
  final double vat;

  ProductModel({
    required this.id,
    required this.primaryCode,
    required this.imageUrl,
    required this.productName,
    required this.barcode,
    required this.description,
    required this.expiresAt,
    required this.countryOfOrigin,
    required this.companyId,
    required this.supplierId,
    required this.categoryId,
    required this.price,
    required this.vat,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      primaryCode: json['primary_code'].toString(),
      imageUrl: json['image_url'] ?? '',
      productName: json['product_name'] ?? 'Unknown Product',
      barcode: json['barcode'] ?? '',
      description: json['description'] ?? '',
      expiresAt: json['expires_at'] ?? 'N/A',
      countryOfOrigin: json['country_of_origin'] ?? 'Unknown',
      companyId: json['company_id'] ?? 0,
      supplierId: json['supplier_id'] ?? 0,
      categoryId: json['category_id'] ?? 0,
      price: (json['mrp'] ?? 0).toDouble(), // Adjusted from 'price' to 'mrp'
      vat: (json['vat'] ?? 0).toDouble(),
    );
  }
}
