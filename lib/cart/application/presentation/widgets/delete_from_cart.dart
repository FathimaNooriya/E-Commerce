


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/cart_model.dart';
import '../../business_logic/bloc/cart_bloc.dart';

class DeleteFromCart extends StatelessWidget {
  const DeleteFromCart({
    super.key,
    required this.cartProduct,
  });
  final CartModel cartProduct;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text(
                  "Are you sure that you want to remove ${cartProduct.cartProduct.title} from cart?"),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    context
                        .read<CartBloc>()
                        .add(DeleteFromCartEvent(cartItem: cartProduct));
                 
                    await Future.delayed(const Duration(seconds: 1));
                    context.read<CartBloc>().add(GetCartitems());
                
                    Navigator.of(context).pop();
                  },
                  child: BlocConsumer<CartBloc, CartState>(
                    listener: (context, state) {
                      // if (state is DeleteSucces) {
                      //   context.read<ProductBloc>().add(GetCartitems());
                      // }
                    },
                    builder: (context, state) {
                      if (state is DeleteCartLoading) {
                        return const FittedBox(
                          fit: BoxFit.cover,
                          child: CircularProgressIndicator(color: Colors.pink),
                        );
                      }
                      return const Text("Yes");
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cacel")),
              ],
            ),
          );
        },
        icon: const Icon(Icons.delete),
      ),
    );
  }
}