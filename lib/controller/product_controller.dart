import 'package:get/get.dart';
import '../../model/product model/product_model.dart';
import '../../services/product service/product_service.dart';

class ProductController extends GetxController {
  final ProductService _productService = ProductService();
  var products = <ProductModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchProducts(int categoryId) async {
    try {
      isLoading(true);
      errorMessage('');
      final fetchedProducts = await _productService.fetchProductsByCategory(categoryId);
      products.assignAll(fetchedProducts);
    } catch (e) {
      errorMessage('Failed to load products');
    } finally {
      isLoading(false);
    }
  }
}
