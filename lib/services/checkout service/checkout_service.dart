
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('authToken');

      if (token == null) {
        print("No token found. Please login first.");
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
        checkoutUrl,
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');

    if (token == null) {
      print("Token not found. Please log in first.");
      return []; 
    }

    Dio dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer $token';

    Response response = await dio.get('http://192.168.1.124:8081/master/pharmacy/getpharmacy');

    if (response.statusCode == 200 && response.data['responseStatus'] == "Success") {
      List<dynamic> pharmacyList = response.data['responseData'];

      List<PharmacyModel> pharmacies = pharmacyList
          .map((pharmacyJson) => PharmacyModel.fromJson(pharmacyJson))
          .toList();

      print("Pharmacies retrieved successfully: ${pharmacies.length} items");
      return pharmacies; 
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
