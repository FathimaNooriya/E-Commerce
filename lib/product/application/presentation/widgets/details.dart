
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../cart/application/business_logic/bloc/cart_bloc.dart';
import '../../../../cart/application/presentation/cart.dart';
import '../../../data/model/product_model.dart';
import '../../business_logic/bloc/product_bloc.dart';
import '../screens/home.dart';

class DetailsOfIteam extends StatelessWidget {
  const DetailsOfIteam({
    required this.product,
    super.key,
  });
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title!,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(product.category!),
          const SizedBox(
            height: 10,
          ),
          Text(
            " ₹ ${product.price!}",
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(product.description!),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(5)) // Background color
                      ),
                  onPressed: () {},
                  child: const Text(
                    "Buy Now",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 143, 241, 196),
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(5)) // Background color
                          ),
                      onPressed: () {
                        context
                            .read<CartBloc>()
                            .add(AddToCartEvent(product: product));
                        context.read<CartBloc>().add(GetCartitems());
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const CartPage()));
                      },
                      child: BlocConsumer<ProductBloc, ProductState>(
                        builder: (context, state) {
                          if (state is AddToCartLoading) {
                            return const FittedBox(
                                fit: BoxFit.cover,
                                child: CircularProgressIndicator());
                          }
                          return const Text(
                            "Add to Cart",
                            style: TextStyle(color: Colors.black),
                          );
                        },
                        listener: (context, state) {
                          if (state is AddingSucces) {
                            const SnackBar(
                                content: Text("Poduct added to cart"));
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const HomeScreen()));
                          } else if (state is AddingFailed) {
                            const SnackBar(
                                content: Text("Poduct adding failed"));
                          }
                        },
                      ))),
            ],
          ),
        ],
      ),
    );
  }
}
