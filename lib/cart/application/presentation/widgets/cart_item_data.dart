

import 'package:flutter/material.dart';

import '../../../domain/entities/cart_model.dart';

class ItemData extends StatelessWidget {
  const ItemData({
    required this.cartProduct,
    super.key,
  });
  final CartModel cartProduct;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cartProduct.cartProduct.title!,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(cartProduct.date),
            Text((cartProduct.cartProduct.price).toString()),
          ],
        ),
      ),
    );
  }
}
