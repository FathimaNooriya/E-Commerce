import 'package:flutter/material.dart';

import '../../../domain/entities/cart_model.dart';

class IteamImage extends StatelessWidget {
  const IteamImage({
    required this.cartProduct,
    super.key,
  });
  final CartModel cartProduct;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: 150,
      child: FittedBox(
        fit: BoxFit.fill,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
                fit: BoxFit.fill,
                height: MediaQuery.of(context).size.height * .25,
                cartProduct.cartProduct.image!),
          ),
        ),
      ),
    );
  }
}
