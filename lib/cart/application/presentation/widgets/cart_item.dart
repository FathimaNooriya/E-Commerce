import 'package:flutter/material.dart';
import '../../../domain/entities/cart_model.dart';
import 'cart_image.dart';
import 'cart_item_data.dart';
import 'delete_from_cart.dart';
import 'item_quntity.dart';

class CartIteam extends StatelessWidget {
  const CartIteam({
    required this.cartProduct,
    super.key,
  });
  final CartModel cartProduct;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IteamImage(cartProduct: cartProduct),
                  ItemData(cartProduct: cartProduct),
                ],
              ),
              DeleteFromCart(cartProduct: cartProduct)
            ],
          ),
          Quantity(cartProduct: cartProduct),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}