import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/product_model.dart';
import '../controllers/product_controller.dart';

class ProductDetailView extends StatelessWidget {
  final ProductController productController = Get.find<ProductController>();
  
  @override
  Widget build(BuildContext context) {
    final Product product = Get.arguments as Product;

    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () => productController.shareProduct(product),
          ),
        ],
      ),
      body: Column(
        children: [
          Image.network(product.thumbnail, height: 200),
          Text(product.title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          Text("\$${product.price}", style: TextStyle(fontSize: 18)),
          Expanded(child: SingleChildScrollView(child: Text(product.description))),
        ],
      ),
    );
  }
}
