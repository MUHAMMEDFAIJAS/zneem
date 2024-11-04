import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/address model/address_model.dart';

class AddressController extends GetxController {
  final Dio _dio = Dio();
  final String baseUrl = "http://192.168.1.124:8081/master/address/userDetails";

  var addresses = <AddressModel>[].obs;  // Observable list for addresses
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

  Future<void> fetchAddresses() async {
    try {
      isLoading(true);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('authToken'); 

      if (token != null) {
        _dio.options.headers['Authorization'] = 'Bearer $token';

        final response = await _dio.get(baseUrl);

        if (response.statusCode == 200) {
          List<dynamic> data = response.data['responseData'];
          addresses.value = data.map((json) => AddressModel.fromJson(json)).toList();
        } else {
          throw Exception('Failed to load addresses');
        }
      } else {
        throw Exception('Token not found!');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load addresses');
    } finally {
      isLoading(false);
    }
  }
}
