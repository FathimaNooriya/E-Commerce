import 'package:flutter/material.dart';

import '../../../data/model/product_model.dart';

class MainImage extends StatelessWidget {
  const MainImage({
    required this.product,
    super.key,
  });
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      product.image!,
      height: MediaQuery.of(context).size.height * .75,
      width: double.infinity,
    );
  }
}
