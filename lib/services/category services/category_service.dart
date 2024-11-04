import 'package:dio/dio.dart';
import '../../model/category model/category_model.dart';

class CategoryService {
  final Dio _dio = Dio();

  Future<List<CategoryModel>> fetchCategories() async {
    String url = 'http://192.168.1.124:8081/master/categories/fetchCat';
    try {
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        final List<CategoryModel> categories =
            (response.data['responseData'] as List)
                .map((categoryJson) => CategoryModel.fromJson(categoryJson))
                .toList();
        return categories;
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Error fetching categories: $e');
    }
  }
}
