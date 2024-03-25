

import 'package:flutter/material.dart';

import '../../../domain/entities/cart_model.dart';

class Quantity extends StatelessWidget {
  const Quantity({
    required this.cartProduct,
    super.key,
  });
  final CartModel cartProduct;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 2),
      child: Row(children: [
        const Card(
          shape: CircleBorder(
            eccentricity: 0,
          ),
          color: Colors.white,
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(9.0),
            child: Text("-"),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: Text(
            cartProduct.itemCount.toString(),
            style: const TextStyle(color: Colors.black),
          ),
        ),
        const Card(
          shape: CircleBorder(
            eccentricity: 0,
          ),
          color: Colors.white,
          elevation: 5,
          child: Padding(
            padding: EdgeInsets.all(7.0),
            child: Text("+"),
          ),
        ),
      ]),
    );
  }
}
