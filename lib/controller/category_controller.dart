import 'package:get/get.dart';
import '../../model/category model/category_model.dart';
import '../../services/category services/category_service.dart';

class CategoryController extends GetxController {
  final CategoryService _categoryService = CategoryService();
  var categories = <CategoryModel>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      isLoading(true);
      categories.value = await _categoryService.fetchCategories();
      if (categories.isEmpty) {
        errorMessage('No categories found.');
      } else {
        errorMessage('');
      }
    } catch (e) {
      errorMessage('Error fetching categories: $e');
    } finally {
      isLoading(false);
    }
  }
}
