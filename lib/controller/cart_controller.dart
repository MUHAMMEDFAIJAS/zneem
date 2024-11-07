
// }

import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/address model/address_model.dart';
import '../../model/cart model/cart_model.dart';

class CartController extends GetxController {
  final Dio _dio = Dio();

  var cartItems = <CartItem>[].obs;
  var totalItems = 0.obs;
  var totalPrice = 0.0.obs;

  final String _addToCartUrl = 'http://192.168.1.124:8081/master/cart/add';
  final String _fetchCartUrl =
      'http://192.168.1.124:8081/master/cart/fetchCart';
  final String _removeCartItemUrl =
      'http://192.168.1.124:8081/master/cart/removeCartItem';
  final String _updateQuantityUrl =
      'http://192.168.1.124:8081/master/order/updatequantity';

  Future<void> addToCart(
      int productId, String phoneNumber, AddressModel address,{int quantity = 1}) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('authToken');

    if (token == null) {
      Get.snackbar('Error', 'Token not found. Please log in.');
      return;
    }

    final Map<String, dynamic> data = {
      "product_id": productId,
      "phone_number": phoneNumber,
      "address": address.toJson(),
      "quantity": quantity,
    };

    try {
      final response = await _dio.post(
        _addToCartUrl,
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200 &&
          response.data['responseStatus'] == 'Success') {
        Get.snackbar('Success', 'Item added to cart successfully');
        fetchCart(phoneNumber);
      } else {
        Get.snackbar('Error',
            response.data['responseDescription'] ?? 'Unknown error occurred');
      }
    } catch (dioError) {
      Get.snackbar('Error', 'Error adding to cart:}');
    }
  }

  Future<void> fetchCart(String phoneNumber) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('authToken');

      if (token != null) {
        final dioResponse = await _dio.get(
          _fetchCartUrl,
          queryParameters: {"phone_number": phoneNumber},
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );

        if (dioResponse.statusCode == 200) {
          CartModel cartModel =
              CartModel.fromJson(dioResponse.data['responseData']);
          cartItems.assignAll(cartModel.items);
          totalItems.value = cartModel.totalItems;
          totalPrice.value = cartModel.totalPrice;
        } else {
          Get.snackbar('Error',
              'Failed to load cart: ${dioResponse.data['responseDescription'] ?? 'Unknown error occurred'}');
        }
      } else {
        Get.snackbar('Error', 'Token not found!');
      }
    } on DioError catch (dioError) {
      // Get.snackbar('Error', 'Failed to load cart: ${dioError.message}');
    }
  }

  Future<void> deleteCartItem(int itemId, String phoneNumber) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('authToken');

    if (token == null) {
      Get.snackbar('Error', 'Token not found. Please log in.');
      return;
    }

    final Map<String, dynamic> data = {
      "item_id": itemId,
      "phone_number": phoneNumber,
    };

    try {
      final response = await _dio.delete(
        _removeCartItemUrl,
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200 &&
          response.data['responseStatus'] == 'Success') {
        Get.snackbar('Success', 'Item removed from cart successfully');
        fetchCart(phoneNumber);
      } else {
        Get.snackbar('Error',
            response.data['responseDescription'] ?? 'Unknown error occurred');
      }
    } on DioError catch (dioError) {
      Get.snackbar(
          'Error', 'Error removing item from cart: ${dioError.message}');
    }
  }

  Future<void> updateQuantity(
      int cartItemId, String phoneNumber, int quantity) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('authToken');

    if (token == null) {
      Get.snackbar('Error', 'Token not found. Please log in.');
      return; 
    }

    final Map<String, dynamic> data = {
      "cart_item_id": cartItemId,
      "phone_number": phoneNumber,
      "Quantity": quantity,
    };

    try {
      final response = await _dio.put(
        _updateQuantityUrl,
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200 &&
          response.data['responseStatus'] == 'Success') {
        Get.snackbar('Success', 'Cart item quantity updated successfully');
        fetchCart(phoneNumber); 
      } else {
        Get.snackbar('Error',
            response.data['responseDescription'] ?? 'Unknown error occurred');
      }
    } on DioError catch (dioError) {
      Get.snackbar('Error', 'Error updating quantity: ${dioError.message}');
    }
  }
}
