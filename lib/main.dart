import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/product_list_view.dart';
import 'views/product_detail_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product Listing App',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system, // Auto switch based on system settings
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => ProductListView()),
        GetPage(name: '/productDetail', page: () => ProductDetailView()),
      ],
    );
  }
}
