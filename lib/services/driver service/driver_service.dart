
import 'package:dio/dio.dart';
import '../../api/api.dart';
import '../../model/driver model/driver_model.dart';

class DriverService {
  final Dio _dio = Dio();
final String baseUrl = Api.baseUrl;

  Future<List<DriverModel>> fetchDrivers(String token) async {
    final response = await _dio.get(
      '$baseUrl/driver/getdriver',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      final data = response.data['responseData'] as List;
      return data.map((driverJson) => DriverModel.fromJson(driverJson)).toList();
    } else {
      throw Exception('Failed to load drivers: ${response.data['responseDescription']}');
    }
  }
}
