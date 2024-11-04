import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/address model/address_model.dart';
import '../../model/cart model/cart_model.dart';

class CartServices {
  final Dio _dio = Dio();
  Future<String> addToCart({
    required int productId,
    required String phoneNumber,
    required AddressModel address,
  }) async {
    const String url = 'http://192.168.1.124:8081/master/cart/add';

    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('authToken');

    if (token == null) {
      throw Exception('Token not found. Please log in.');
    }

    final Map<String, dynamic> data = {
      "product_id": productId,
      "phone_number": phoneNumber,
      "address": address.toJson(),
    };

    try {
      final response = await _dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 &&
          response.data['responseStatus'] == 'Success') {
        return 'Item added to cart successfully';
      } else {
        return 'Failed to add item to cart: ${response.data['responseDescription']}';
      }
    } catch (e) {
      return 'Error adding to cart: $e';
    }
  }

  final String baseUrl = "http://192.168.1.124:8081/master/cart/fetchCart";

  Future<CartModel> fetchCart(String phoneNumber) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('authToken');

      if (token != null) {
        Response response = await _dio.get(
          baseUrl,
          data: {
            "phone_number": phoneNumber,
          },
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );

        if (response.statusCode == 200) {
          return CartModel.fromJson(response.data['responseData']);
        } else {
          throw Exception(
              'Failed to load cart: ${response.data['responseDescription']}');
        }
      } else {
        throw Exception('Token not found!');
      }
    } catch (e) {
      throw Exception('Failed to load cart: $e');
    }
  }

  Future<String> deletecartitem(
      {required int itemId, required String phoneNumber}) async {
    const String url = 'http://192.168.1.124:8081/master/cart/removeCartItem';

    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('authToken');

    if (token == null) {
      throw Exception('Token not found. Please log in.');
    }

    final Map<String, dynamic> data = {
      "item_id": itemId,
      "phone_number": phoneNumber,
    };
    try {
      final response = await _dio.delete(url,
          data: data,
          options: Options(headers: {
            'Authorization': 'Bearer $token',
          }));

      if (response.statusCode == 200 &&
          response.data['responseStatus'] == 'Success') {
        return 'Item removed from cart successfully';
      } else {
        return 'Failed to remove item from cart: ${response.data['responseDescription']}';
      }
    } catch (e) {
      return 'error removing item from cart :  $e';
    }
  }

  Future<String> updateQuantity({
    required int cartItemId,
    required String phoneNumber,
    required int quantity,
  }) async {
    const String url = 'http://192.168.1.124:8081/master/order/updatequantity';

    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('authToken');

    if (token == null) {
      throw Exception('Token not found. Please log in.');
    }

    final Map<String, dynamic> data = {
      "cart_item_id": cartItemId,
      "phone_number": phoneNumber,
      "Quantity": quantity,
    };

    try {
      final response = await _dio.put(
        url,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 &&
          response.data['responseStatus'] == 'Success') {
        return 'Cart item quantity updated successfully';
      } else {
        return 'Failed to update cart item quantity: ${response.data['responseDescription']}';
      }
    } catch (e) {
      return 'Error updating quantity: $e';
    }
  }

  Future<String> reduceQuantity({
    required int cartItemId,
    required String phoneNumber,
  }) async {
    const String url = 'http://192.168.1.124:8081/master/order/reducequantity';

    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('authToken');

    if (token == null) {
      throw Exception('Token not found. Please log in.');
    }

    final Map<String, dynamic> data = {
      "cart_item_id": cartItemId,
      "phone_number": phoneNumber,
      "Quantity": 1, // Always reducing by 1
    };

    try {
      final response = await _dio.put(
        url,
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 &&
          response.data['responseStatus'] == 'Success') {
        return 'Cart item quantity reduced successfully';
      } else {
        return 'Failed to reduce cart item quantity: ${response.data['responseDescription']}';
      }
    } catch (e) {
      return 'Error reducing quantity: $e';
    }
  }
}




// import 'package:dio/dio.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../model/address model/address_model.dart';
// import '../../model/cart model/cart_model.dart';

// class CartServices {
//   final Dio _dio = Dio();

//   /// Adds an item to the cart with the specified product ID, phone number, and address.
//   Future<String> addToCart({
//     required int productId,
//     required String phoneNumber,
//     required AddressModel address,
//   }) async {
//     const String url = 'http://192.168.1.124:8081/master/cart/add';

//     final prefs = await SharedPreferences.getInstance();
//     final String? token = prefs.getString('authToken');

//     if (token == null) {
//       throw Exception('Token not found. Please log in.');
//     }

//     final Map<String, dynamic> data = {
//       "product_id": productId,
//       "phone_number": phoneNumber,
//       "address": address.toJson(),
//     };

//     try {
//       final response = await _dio.post(
//         url,
//         data: data,
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//           },
//         ),
//       );

//       if (response.statusCode == 200 &&
//           response.data['responseStatus'] == 'Success') {
//         return 'Item added to cart successfully';
//       } else {
//         return 'Failed to add item to cart: ${response.data['responseDescription']}';
//       }
//     } catch (e) {
//       return 'Error adding to cart: $e';
//     }
//   }

//   /// Fetches the cart data for a specified phone number.
//   Future<CartModel> fetchCart(String phoneNumber) async {
//     const String url = "http://192.168.1.124:8081/master/cart/fetchCart";

//     final prefs = await SharedPreferences.getInstance();
//     final String? token = prefs.getString('authToken');

//     if (token == null) {
//       throw Exception('Token not found!');
//     }

//     try {
//       final response = await _dio.get(
//         url,
//         queryParameters: {
//           "phone_number": phoneNumber,
//         },
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//           },
//         ),
//       );

//       if (response.statusCode == 200) {
//         return CartModel.fromJson(response.data['responseData']);
//       } else {
//         throw Exception(
//             'Failed to load cart: ${response.data['responseDescription']}');
//       }
//     } catch (e) {
//       throw Exception('Failed to load cart: $e');
//     }
//   }

//   /// Deletes an item from the cart with the specified item ID and phone number.
//   Future<String> deleteCartItem({required int itemId, required String phoneNumber}) async {
//     const String url = 'http://192.168.1.124:8081/master/cart/removeCartItem';

//     final prefs = await SharedPreferences.getInstance();
//     final String? token = prefs.getString('authToken');

//     if (token == null) {
//       throw Exception('Token not found. Please log in.');
//     }

//     final Map<String, dynamic> data = {
//       "item_id": itemId,
//       "phone_number": phoneNumber,
//     };

//     try {
//       final response = await _dio.delete(
//         url,
//         data: data,
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//           },
//         ),
//       );

//       if (response.statusCode == 200 &&
//           response.data['responseStatus'] == 'Success') {
//         return 'Item removed from cart successfully';
//       } else {
//         return 'Failed to remove item from cart: ${response.data['responseDescription']}';
//       }
//     } catch (e) {
//       return 'Error removing item from cart: $e';
//     }
//   }

//   /// Updates the quantity of a cart item.
//   Future<String> updateQuantity({
//     required int cartItemId,
//     required String phoneNumber,
//     required int quantity,
//   }) async {
//     const String url = 'http://192.168.1.124:8081/master/cart/updateQuantity';

//     final prefs = await SharedPreferences.getInstance();
//     final String? token = prefs.getString('authToken');

//     if (token == null) {
//       throw Exception('Token not found. Please log in.');
//     }

//     final Map<String, dynamic> data = {
//       "cart_item_id": cartItemId,
//       "phone_number": phoneNumber,
//       "quantity": quantity,
//     };

//     try {
//       final response = await _dio.put(
//         url,
//         data: data,
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//           },
//         ),
//       );

//       if (response.statusCode == 200 &&
//           response.data['responseStatus'] == 'Success') {
//         return 'Cart item quantity updated successfully';
//       } else {
//         return 'Failed to update cart item quantity: ${response.data['responseDescription']}';
//       }
//     } catch (e) {
//       return 'Error updating quantity: $e';
//     }
//   }

//   /// Reduces the quantity of a cart item by 1.
//   Future<String> reduceQuantity({
//     required int cartItemId,
//     required String phoneNumber,
//   }) async {
//     const String url = 'http://192.168.1.124:8081/master/cart/reduceQuantity';

//     final prefs = await SharedPreferences.getInstance();
//     final String? token = prefs.getString('authToken');

//     if (token == null) {
//       throw Exception('Token not found. Please log in.');
//     }

//     final Map<String, dynamic> data = {
//       "cart_item_id": cartItemId,
//       "phone_number": phoneNumber,
//       "quantity": 1, // Reducing by 1
//     };

//     try {
//       final response = await _dio.put(
//         url,
//         data: data,
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $token',
//           },
//         ),
//       );

//       if (response.statusCode == 200 &&
//           response.data['responseStatus'] == 'Success') {
//         return 'Cart item quantity reduced successfully';
//       } else {
//         return 'Failed to reduce cart item quantity: ${response.data['responseDescription']}';
//       }
//     } catch (e) {
//       return 'Error reducing quantity: $e';
//     }
//   }
// }
