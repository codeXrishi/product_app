import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_list/views/product_detail_view.dart';
import '../models/product_model.dart';
import '../controllers/product_controller.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final ProductController productController = Get.find<ProductController>();

  ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(product.thumbnail, height: 100, width: double.infinity, fit: BoxFit.contain),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.title, style: TextStyle(fontWeight: FontWeight.bold)),
                Text("\$${product.price.toStringAsFixed(2)}", style: TextStyle(color: Colors.green)),
                Text(product.category, style: TextStyle(color: Colors.grey)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.share),
                      onPressed: () => productController.shareProduct(product),
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      onPressed: () {
                        Get.to(()=>ProductDetailView(),arguments: product);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
