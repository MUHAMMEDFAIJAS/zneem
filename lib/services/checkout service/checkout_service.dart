import 'dart:math';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/pharmcay model/pharmacy_model.dart';

class CheckoutService {
  final Dio _dio = Dio();
  final String checkoutUrl = "http://192.168.1.124:8081/master/order/checkout";

  Future<void> checkout({
    required int cartId,
    required String phoneNumber,
    required int addressId,
    required int pharmacyId,
    required String paymentMethod,
  }) async {
    try {
      // Retrieve token from SharedPreferences
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('authToken');

      if (token == null) {
        print("No token found. Please login first.");
        return;
      }

      // Set authorization header
      _dio.options.headers['Authorization'] = 'Bearer $token';

      // Prepare request body
      Map<String, dynamic> requestBody = {
        "cart_id": cartId,
        "phone_number": phoneNumber,
        "address_id": addressId,
        "pharmacy_id": pharmacyId,
        "payment_method": paymentMethod,
      };

      // Make POST request
      Response response = await _dio.post(
        checkoutUrl,
        data: requestBody,
      );

      // Handle response
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
    // Retrieve token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');

    if (token == null) {
      print("Token not found. Please log in first.");
      return []; // Return an empty list if no token
    }

    // Set up Dio with authorization header
    Dio dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $token';

    // Perform GET request to fetch pharmacies
    Response response = await dio.get('http://192.168.1.124:8081/master/pharmacy/getpharmacy');

    if (response.statusCode == 200 && response.data['responseStatus'] == "Success") {
      List<dynamic> pharmacyList = response.data['responseData'];

      // Parse pharmacies using the Pharmacy model
      List<PharmacyModel> pharmacies = pharmacyList
          .map((pharmacyJson) => PharmacyModel.fromJson(pharmacyJson))
          .toList();

      print("Pharmacies retrieved successfully: ${pharmacies.length} items");
      return pharmacies; // Return the list of pharmacies
    } else {
      print("Failed to retrieve pharmacies: ${response.data['responseDescription']}");
      return []; // Return an empty list on failure
    }
  } catch (e) {
    print("Error fetching pharmacies: $e");
    return []; // Return an empty list on error
  }
}

}
