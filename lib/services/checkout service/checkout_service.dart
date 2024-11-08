import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zneempharmacy/api/api.dart';

import '../../model/pharmcay model/pharmacy_model.dart';

class CheckoutService {
  final Dio _dio = Dio();
  final String baseUrl = Api.baseUrl;

  Future<String?> _getToken() async {
    return await Api.getAuthToken();
  }

  Future<int?> _getPharmacyId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('pharmacyId');
  }

  Future<void> checkout({
    required int cartId,
    required String phoneNumber,
    required int addressId,
    required String paymentMethod,
  }) async {
    try {
      String? token = await _getToken();
      if (token == null) {
        print("No token found. Please login first.");
        return;
      }

      int? pharmacyId = await _getPharmacyId();
      if (pharmacyId == null) {
        print("No pharmacy ID found. Please login again.");
        return;
      }

      _dio.options.headers['Authorization'] = 'Bearer $token';

      Map<String, dynamic> requestBody = {
        "cart_id": cartId,
        "phone_number": phoneNumber,
        "address_id": addressId,
        "pharmacy_id": pharmacyId,
        "payment_method": paymentMethod,
      };

      Response response = await _dio.post(
        '$baseUrl/order/checkout',
        data: requestBody,
      );

      if (response.statusCode == 200 &&
          response.data['responseStatus'] == "Success") {
        print("Checkout completed successfully!");
        print("Order ID: ${response.data['responseData']['id']}");
      } else {
        print("Failed to checkout: ${response.data['responseDescription']}");
      }
    } catch (e) {
      print("Error during checkout: $e");
    }
  }

  Future<List<PharmacyModel>> fetchPharmacies() async {
    try {
      String? token = await _getToken();
      if (token == null) {
        print("Token not found. Please log in first.");
        return [];
      }

      _dio.options.headers['Authorization'] = 'Bearer $token';
      Response response = await _dio.get('$baseUrl/pharmacy/getpharmacy');

      if (response.statusCode == 200 &&
          response.data['responseStatus'] == "Success") {
        List<dynamic> pharmacyList = response.data['responseData'];
        return pharmacyList
            .map((pharmacyJson) => PharmacyModel.fromJson(pharmacyJson))
            .toList();
      } else {
        print("Failed to retrieve pharmacies: ${response.data['responseDescription']}");
        return [];
      }
    } catch (e) {
      print("Error fetching pharmacies: $e");
      return [];
    }
  }
}
