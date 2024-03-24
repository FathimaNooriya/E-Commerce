import 'package:e_commerce/application/business_logic/bloc/product_bloc.dart';
import 'package:e_commerce/application/presentation/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/model/cart_model.dart';

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
        body: BlocConsumer<ProductBloc, ProductState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is Loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FetchCartFailed) {
                return const Center(
                  child: Text("Failed to fetch"),
                );
              }
              if (context.read<ProductBloc>().cartProducts.isNotEmpty) {
                return ListView.builder(
                    itemCount: context.read<ProductBloc>().cartProducts.length,
                    // state.cartProducts.length,
                    itemBuilder: (context, index) {
                      final cartProduct =
                          context.read<ProductBloc>().cartProducts[index];
                      //   final cartProduct = state.cartProducts[index];
                      return CartIteam(
                        cartProduct:
                            //  CartModel(
                            //     cartId: 1,
                            //     cartProduct: [
                            //       Product(
                            //         productId: 1,
                            //         quantity: 1,
                            //       )
                            //     ],
                            //     date: "date")
                            cartProduct,
                      );
                    });
              } else if (context.read<ProductBloc>().cartProducts.isEmpty) {
                return const Center(
                  child: Text(" Cart is Empty"),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}

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
                  AboutIteam(cartProduct: cartProduct),
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
                        .read<ProductBloc>()
                        .add(DeleteFromCartEvent(cartItem: cartProduct));
                    print("Deleted");
                    await Future.delayed(const Duration(seconds: 1));

                    context.read<ProductBloc>().add(GetCartitems());
                    print("Feched");
                    Navigator.of(context).pop();
                  },
                  child: BlocConsumer<ProductBloc, ProductState>(
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
                      return Text("Yes");
                    },
                  ),
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cacel")),
              ],
            ),
          );
          // context
          //     .read<ProductBloc>()
          //     .add(DeleteFromCartEvent(cartItem: cartProduct));
        },
        icon:
            // BlocConsumer<ProductBloc, ProductState>(
            //   listener: (context, state) {
            //     if (state is DeleteSucces) {
            //       context.read<ProductBloc>().add(GetCartitems());
            //     }
            //   },
            //   builder: (context, state) {
            //     if (state is DeleteCartLoading) {
            //       return const FittedBox(
            //         fit: BoxFit.cover,
            //         child: CircularProgressIndicator(color: Colors.pink),
            //       );
            //     }
            // return
            const Icon(Icons.delete),
        //   },
        //)
      ),
    );
  }
}

class IteamImage extends StatelessWidget {
  const IteamImage({
    required this.cartProduct,
    super.key,
  });
  final CartModel cartProduct;

  @override
  Widget build(BuildContext context) {
    // cartNumber--;
    return SizedBox(
      height: 130,
      width: 150,
      child: FittedBox(
        fit: BoxFit.fill,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child:
                //  BlocConsumer<BlocBloc, BlocState>(
                //   listener: (context, state) {
                //     // cartNumber;
                //   },
                //   builder: (context, state) {
                //     return
                Image.network(
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height * .25,
                    cartProduct.cartProduct.image!
                    //  state.products[cartProduct.cartProduct![0].productId!].image!,
                    // "https://rukminim2.flixcart.com/image/850/1000/xif0q/shirt/z/g/d/xl-st2-vebnor-original-imagpw72vhqfczsp.jpeg?q=90",
                    ),
            //;
            //   },
          ),
        ),
      ),
      // ),
    );
  }
}

class AboutIteam extends StatelessWidget {
  const AboutIteam({
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
        child:
            //  BlocBuilder<BlocBloc, BlocState>(
            //   builder: (context, state) {
            //     return
            Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cartProduct.cartProduct.title!,
              // state.products[cartProduct.cartProduct![0].productId!].title!,
              overflow: TextOverflow.ellipsis,
              // "Mens Wear",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(cartProduct.date),
            Text((cartProduct.cartProduct.price).toString()),
          ],
          //   );
          //  },
        ),
      ),
    );
  }
}

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
