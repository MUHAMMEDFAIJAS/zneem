// import '../address model/address_model.dart';

// class CartModel {
//   final int id;
//   final double totalPrice;
//   final int totalItems;
//   final List<CartItem> items;
//   final AddressModel? address; // Add address to the cart

//   CartModel({
//     required this.id,
//     required this.totalPrice,
//     required this.totalItems,
//     required this.items,
//     this.address,
//   });

//   factory CartModel.fromJson(Map<String, dynamic> json) {
//     var itemList = json['items'] as List;
//     List<CartItem> cartItems = itemList.map((i) => CartItem.fromJson(i)).toList();

//     return CartModel(
//       id: json['id'],
//       totalPrice: json['total_price'].toDouble(),
//       totalItems: json['total_items'],
//       items: cartItems,
//       address: json['address'] != null ? AddressModel.fromJson(json['address']) : null, // Parsing the address
//     );
//   }
// }

// class CartItem {
//   final int id;
//   final int productId;
//   final String productName;
//   final double price;
//   final int quantity;
//   final String imageUrl;
//   final String description;

//   CartItem({
//     required this.id,
//     required this.productId,
//     required this.productName,
//     required this.price,
//     required this.quantity,
//     required this.imageUrl,
//     required this.description,
//   });

//   factory CartItem.fromJson(Map<String, dynamic> json) {
//     return CartItem(
//       id: json['id'],
//       productId: json['product_id'],
//       productName: json['product_name'],
//       price: json['price'].toDouble(),
//       quantity: json['quantity'],
//       imageUrl: json['image_url'],
//       description: json['description'],
//     );
//   }

//   double get totalPrice => price * quantity; // Added computed total price based on quantity
// }
class CartModel {
  final List<CartItem> items;
  final int totalItems;
  final int cartId;
  final double totalPrice;

  CartModel({
    required this.items,
    required this.totalItems,
    required this.totalPrice,
    required this.cartId,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    var itemsJson = json['items'] as List? ?? [];
    List<CartItem> itemsList =
        itemsJson.map((item) => CartItem.fromJson(item)).toList();

    return CartModel(
      items: itemsList,
      cartId: json['id'],
      totalItems: json['total_items'] ?? 0,
      totalPrice: (json['total_price'] ?? 0).toDouble(),
    );
  }
}

class CartItem {
  final int id;
  final String productName;
  final double price;
  final int quantity;
  final double totalPrice;
  final String imageUrl;
  final String description;
  final int phonenumber;

  CartItem({
    required this.id,
    required this.productName,
    required this.price,
    required this.quantity,
    required this.totalPrice,
    required this.imageUrl,
    required this.description,
    required this.phonenumber,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] ?? 0,
      productName: json['product_name'] ?? 'Unknown Product',
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 1,
      totalPrice: (json['total_price'] ?? 0).toDouble(),
      imageUrl: json['image_url'] ?? '',
      description: json['description'] ?? 'No description available',
      phonenumber: json['phone_number'] ?? 0,
    );
  }
}
