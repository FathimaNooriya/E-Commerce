import 'package:e_commerce/cart/application/business_logic/bloc/cart_bloc.dart';
import 'package:e_commerce/product/application/presentation/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'widgets/cart_item.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomeScreen()))),
          backgroundColor: const Color.fromARGB(255, 143, 241, 196),
          title: const Text("My Cart"),
          scrolledUnderElevation: 5,
          toolbarOpacity: .9,
          bottomOpacity: .5,
          toolbarHeight: 75,
        ),
        body: BlocConsumer<CartBloc, CartState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is CartLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FetchCartFailed) {
                return const Center(
                  child: Text("Failed to fetch"),
                );
              }
              if (context.read<CartBloc>().cartProducts.isNotEmpty) {
                return ListView.builder(
                    itemCount: context.read<CartBloc>().cartProducts.length,
                    itemBuilder: (context, index) {
                      final cartProduct =
                          context.read<CartBloc>().cartProducts[index];
                      return CartIteam(
                        cartProduct: cartProduct,
                      );
                    });
              }
              // else if (context.read<CartBloc>().cartProducts.isEmpty) {
              //   return const Center(
              //     child: Text(" Cart is Empty"),
              //   );
              // }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
