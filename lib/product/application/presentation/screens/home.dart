import 'package:e_commerce/cart/application/presentation/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cart/application/business_logic/bloc/cart_bloc.dart';
import '../../business_logic/bloc/product_bloc.dart';
import '../widgets/favorate.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<ProductBloc>().add(GetAllProductsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: false,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 143, 241, 196),
        // Color.fromARGB(228, 248, 101, 182),
        //     const Color.fromARGB(255, 114, 190, 155),
        actions: [
          IconButton(
            onPressed: () async {
              context.read<CartBloc>().add(GetCartitems());
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CartPage()));
            },
            icon: const Icon(Icons.shopping_cart),
          ),

        ],
        scrolledUnderElevation: 5,
        toolbarOpacity: .9,
        bottomOpacity: .5,
        toolbarHeight: 75,
        title: const Text("My Store"),
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (State is FetchProductsFailed) {
            const SnackBar(content: Text("failed"));
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FetchProductsFailed) {
            return const Center(child: Text(" No Data"));
          } else if (context.read<ProductBloc>().productList.isNotEmpty) {
            return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: GridView.builder(
                    itemCount: context.read<ProductBloc>().productList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1 / 1.8, crossAxisCount: 2),
                    itemBuilder: (context, index) {
                      final product =
                          context.read<ProductBloc>().productList[index];
                      return ProductWithFavorate(oneProduct: product);
                    }));
          } else if (context.read<ProductBloc>().productList.isEmpty) {
            return const Center(child: Text(" No Data"));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}



