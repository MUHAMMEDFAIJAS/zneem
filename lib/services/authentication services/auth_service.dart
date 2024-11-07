

import 'package:dio/dio.dart' as dio; 
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/Auth model/auth_model.dart';
import '../../views/login/login_screen.dart';

class AuthService extends GetxController {
  final dio.Dio _dio = dio.Dio();
  final String baseUrl = "http://192.168.1.124:8081/master";

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

        String token = response.data['responseData']['TOKEN'];
        print('Token: $token');

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('authToken', token);
        await prefs.setBool('isLoggedIn', true);

        //  Get.offAll(() => BottomBar());
      } else {
        print(
            "Failed to login: ${response.data['responseDescription'] ?? response.statusMessage}");
      }
    } catch (e) {
      print("Error during login: $e");
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
    await prefs.setBool('isLoggedIn', false);

    Get.offAll(() => LoginScreen());
    print("User logged out.");
  }
}
