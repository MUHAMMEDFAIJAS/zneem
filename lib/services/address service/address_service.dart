


import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/address model/address_model.dart';

class AddressService {
  final Dio _dio = Dio();
  final String baseUrl = "http://192.168.1.124:8081/master/address/useraddress";

  Future<void> addUserAddress(AddressModel address) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('authToken'); 

      if (token != null) {
        _dio.options.headers['Authorization'] = 'Bearer $token';

        final response = await _dio.post(
          baseUrl,
          data: address.toJson(),
        );

        if (response.statusCode == 200 &&
            response.data['responseStatus'] == "Success") {
          print("Address added successfully");
        } else {
          throw Exception(
              'Failed to add address: ${response.data['responseDescription']}');
        }
      } else {
        throw Exception('Token not found!');
      }
    } catch (e) {
      throw Exception("Failed to add user address: $e");
    }
  }

  Future<List<AddressModel>> fetchAddresses() async {
    const String url = 'http://192.168.1.124:8081/master/address/userDetails';

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('authToken'); 

      if (token != null) {
        Response response = await _dio.get(
          url,
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );

        if (response.statusCode == 200) {
          List<dynamic> data = response.data['responseData'];
          return data.map((json) => AddressModel.fromJson(json)).toList();
        } else {
          throw Exception('Failed to load addresses');
        }
      } else {
        throw Exception('Token not found!');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load addresses');
    }
  }
}
