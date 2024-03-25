import 'package:flutter/material.dart';
import '../../../data/model/product_model.dart';
import '../widgets/details.dart';
import '../widgets/main_image.dart';
import '../widgets/many_image.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({required this.product, super.key});
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          MainImage(product: product),
          DifferentImages(product: product),
          DetailsOfIteam(product: product),
        ],
      ),
    );
  }
}
