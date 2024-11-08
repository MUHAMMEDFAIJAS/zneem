

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api/api.dart';
import '../../model/product model/product_model.dart';

class ProductService {
  final Dio _dio = Dio();
 final String baseUrl = Api.baseUrl;
 
  Future<void> _setAuthToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');
    if (token != null) {
      _dio.options.headers['Authorization'] = 'Bearer $token';
    }
  }

  Future<List<ProductModel>> fetchProductsByCategory(int categoryId) async {
    await _setAuthToken();
    try {
      final response = await _dio.get(
        // 'http://192.168.1.124:8081/master/product/category',
        '$baseUrl/product/category',
        queryParameters: {'category_id': categoryId},
      );

      if (response.statusCode == 200) {
        final List productsData = response.data['responseData'];
        return productsData
            .map((product) => ProductModel.fromJson(product))
            .toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('No products available');
    }
  }

  Future<List<ProductModel>> fetchAllProducts() async {
    await _setAuthToken();
    try {
      final response =
          await _dio.get(
            // 'http://192.168.1.124:8081/master/product/getProduct'
            '$baseUrl/product/getProduct'
            );

      if (response.statusCode == 200) {
        final List productsData = response.data['responseData'];
        return productsData
            .map((product) => ProductModel.fromJson(product))
            .toList();
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: ${e.toString()}');
    }
  }

  Future<List<ProductModel>> searchProducts(String searchTerm) async {
    await _setAuthToken();
    try {
      final response = await _dio.get(
        // 'http://192.168.1.124:8081/master/product/search',
        '$baseUrl/product/search',
        queryParameters: {'query': searchTerm},
      );

      if (response.statusCode == 200) {
        final List productsData = response.data['responseData'];
        return productsData
            .map((product) => ProductModel.fromJson(product))
            .toList();
      } else {
        throw Exception('Failed to search products');
      }
    } catch (e) {
      throw Exception('No products found for the search term');
    }
  }
}
