import 'package:shared_preferences/shared_preferences.dart';

class Api {
  static String baseUrl = "http://192.168.1.124:8081/master";
  static String? authToken;  

  static Future<void> setAuthToken(String token) async {
    authToken = token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('authToken', token);
  }

  static Future<String?> getAuthToken() async {
    if (authToken != null) {
      return authToken;
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('authToken');
    }
  }

  static Future<void> clearAuthToken() async {
    authToken = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
  }
}
