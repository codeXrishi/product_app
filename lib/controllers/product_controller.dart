import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../models/product_model.dart';
import '../services/api_service.dart';

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = <Product>[].obs;
  var filteredList = <Product>[].obs;
  var isGridView = false.obs;
  var isDarkMode = false.obs;
  var selectedCategory = "".obs;
  var categories = <String>[].obs; // Stores unique categories

  final ApiService apiService = ApiService();
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    fetchProducts();
    super.onInit();
  }

  /// Fetch products and update state
  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await apiService.fetchProducts();
      productList.assignAll(products);
      filteredList.assignAll(products);
      
      // filtering data by category
      categories.assignAll(products.map((p) => p.category).toSet().toList());
      categories.insert(0, "All"); // Add "All" category
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  /// Toggles between Grid & List view
  void toggleView() {
    isGridView.value = !isGridView.value;
  }

  /// Toggles between Dark & Light theme
  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(isDarkMode.value ? ThemeMode.dark : ThemeMode.light);
  }

  /// Filters products based on search & selected category
  void filterProducts() {
    String query = searchController.text.toLowerCase();
    String category = selectedCategory.value;

    filteredList.assignAll(productList.where((p) {
      bool matchesSearch = p.title.toLowerCase().contains(query);
      bool matchesCategory = (category == "All" || p.category == category);
      return matchesSearch && matchesCategory;
    }).toList());
  }

  /// Shares product details using `share_plus`
  void shareProduct(Product product) {
    String message = "Check out this product: ${product.title}\nPrice: \$${product.price}\n${product.thumbnail}";
    Share.share(message);
  }
}
