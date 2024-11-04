class OrderModel {
  final int id;
  final int pharmacyId;
  final int driverId;
  final int userId;
  final int addressId;
  final DateTime orderDate;
  final double totalAmount;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
    final List<Item> items;


  OrderModel({
    required this.id,
    required this.pharmacyId,
    required this.driverId,
    required this.userId,
    required this.addressId,
    required this.orderDate,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    var itemList = json['items'] as List;
    List<Item> items = itemList.map((i) => Item.fromJson(i)).toList();

    return OrderModel(
      id: json['id'],
      pharmacyId: json['pharmacy_id'],
      driverId: json['driver_id'],
      userId: json['user_id'],
      addressId: json['address_id'],
      orderDate: DateTime.parse(json['order_date']),
      totalAmount: json['total_amount'].toDouble(),
      status: json['status'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      items: items
    );
  }
}

class Item {
  final int id;
  final int orderId;
  final int productId;
  final String productName;
  final int quantity;
  final int price;

  Item({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.price,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      orderId: json['order_id'],
      productId: json['product_id'],
      productName: json['product_name'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }
}