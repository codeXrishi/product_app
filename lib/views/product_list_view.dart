import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Widgets/product_card.dart';
import '../controllers/product_controller.dart';

class ProductListView extends StatelessWidget {
  final ProductController productController = Get.put(ProductController());

  ProductListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
        actions: [
          IconButton(
            icon: Icon(Icons.grid_view),
            onPressed: productController.toggleView,
          ),
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: productController.toggleTheme,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: productController.searchController,
              onChanged: (value) => productController.filterProducts(),
              decoration: InputDecoration(
                labelText: "Search Products...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          // Category Filter Dropdown
          Obx(() => Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: productController.selectedCategory.value.isEmpty
                      ? "All"
                      : productController.selectedCategory.value,
                  items: productController.categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) {
                    productController.selectedCategory.value = value!;
                    productController.filterProducts();
                  },
                  isExpanded: true,
                ),
              )),
          // Product List/Grid View
          Expanded(
            child: Obx(() {
              if (productController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (productController.filteredList.isEmpty) {
                return const Center(child: Text("No products found."));
              }
              return productController.isGridView.value
                  ? GridView.builder(
                      padding: const EdgeInsets.all(8),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 0.7,
                        mainAxisExtent: 280,
                      ),
                      itemCount: productController.filteredList.length,
                      itemBuilder: (context, index) {
                        final product = productController.filteredList[index];
                        return ProductCard(product: product);
                      },
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: productController.filteredList.length,
                      itemBuilder: (context, index) {
                        final product = productController.filteredList[index];
                        return ProductCard(product: product);
                      },
                    );
            }),
          ),
        ],
      ),
    );
  }
}
