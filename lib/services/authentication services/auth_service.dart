import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zneempharmacy/api/api.dart';
import '../../model/Auth model/auth_model.dart';
import '../../views/login/login_screen.dart';

class AuthService extends GetxController {
  final dio.Dio _dio = dio.Dio();
  final String baseUrl = Api.baseUrl;

  Future<void> register(AuthModel authModel) async {
    try {
      dio.Response response = await _dio.post(
        '$baseUrl/user/signup',
        data: authModel.toJson(),
      );

      if (response.statusCode == 200) {
        print("Registration successful!");
      } else {
        print("Failed to register: ${response.statusMessage}");
      }
    } catch (e) {
      print("Error during registration: $e");
    }
  }

  Future<void> login(String email, String password) async {
    try {
      dio.Response response = await _dio.post(
        '$baseUrl/user/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200 &&
          response.data['responseStatus'] == "Success") {
        print("Login successful!");

        // Retrieve required fields from response data
        String token = response.data['responseData']['TOKEN'];
        int pharmacyId = response.data['responseData']['pharmacistID'];
        String pharmacyName = response.data['responseData']['Pharmacy Name '];
        String userEmail = response.data['responseData']['email'];

        // Save token and user details to SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);
        await prefs.setInt('pharmacyId', pharmacyId);
        await prefs.setString('pharmacyName', pharmacyName);
        await prefs.setString('userEmail', userEmail);
        await prefs.setBool('isLoggedIn', true);

        print('Token: $token');
        print('Pharmacy ID: $pharmacyId');
        print('Pharmacy Name: $pharmacyName');
      } else {
        print("Failed to login: ${response.data['responseDescription'] ?? response.statusMessage}");
      }
    } catch (e) {
      print("Error during login: $e");
    }
  }

  Future<void> logout() async {
    // Clear token and user details from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
    await prefs.remove('pharmacyId');
    await prefs.remove('pharmacyName');
    await prefs.remove('userEmail');
    await prefs.setBool('isLoggedIn', false);

    // Navigate to LoginScreen
    Get.offAll(() => LoginScreen());
    print("User logged out.");
  }
}
