import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/order model/order_model.dart';

class OrderService {
  final Dio _dio = Dio();
  final String baseUrl = 'http://192.168.1.124:8081/master/order/getallorders';

  Future<List<OrderModel>> fetchAllOrders(String phoneNumber) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('authToken');

      if (token == null) {
        throw Exception('No authentication token found. Please log in.');
      }

      log('Fetching orders for phone number: $phoneNumber');
      log('Using token: $token');

      final response = await _dio.get(
        baseUrl,
        data: {'phone_number': '9946233225'},
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      log('Response status: ${response.statusCode}');

      if (response.data['responseStatus'] == 'Success') {
        List<OrderModel> orders = (response.data['responseData'] as List)
            .map((order) => OrderModel.fromJson(order))
            .toList();
        return orders;
      } else {
        throw Exception(
            'Failed to fetch orders: ${response.data['responseDescription']}');
      }
    } on DioError catch (dioError) {
      log('DioError fetching orders: ${dioError.message}');
      log('Response status: ${dioError.response?.statusCode}');
      log('Response data: ${dioError.response?.data}');
      throw Exception('Error fetching orders: ${dioError.message}');
    } catch (e) {
      log('Error fetching orders: $e');
      rethrow;
    }
  }
}
