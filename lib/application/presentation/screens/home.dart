import 'package:e_commerce/application/business_logic/bloc/product_bloc.dart';
import 'package:e_commerce/application/presentation/screens/cart.dart';
import 'package:e_commerce/application/presentation/screens/details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/model/store_model.dart';

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
              context.read<ProductBloc>().add(GetCartitems());
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CartPage()));
            },
            icon: const Icon(Icons.shopping_cart),
          ),
          IconButton(onPressed: () async {}, icon: const Icon(Icons.add)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.login))
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

class ProductWithFavorate extends StatelessWidget {
  const ProductWithFavorate({
    required this.oneProduct,
    super.key,
  });
  final StoreModel oneProduct;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        OneIteam(product: oneProduct),
        Align(
          alignment: const Alignment(.93, -.93),
          child: IconButton(
              onPressed: () {
                StoreModel favorateProduct = oneProduct;
                favorateProduct.favorite == true
                    ? favorateProduct.favorite = false
                    : favorateProduct.favorite = true;
                context
                    .read<ProductBloc>()
                    .add(AddToFavorateEvent(product: favorateProduct));
              },
              icon: BlocConsumer<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is FavorateSucces) {
                    return oneProduct.favorite!
                        ? const Icon(
                            Icons.favorite,
                          )
                        : const Icon(Icons.favorite_border_outlined);
                  }
                  return const Icon(Icons.favorite_border_outlined);
                },
                listener: (context, state) {},
              )

              // ? Icon(
              //     Icons.favorite,
              //   )
              // :
              //  Icon(Icons.favorite_border_outlined)
              ),
        )
      ],
    );
  }
}

class OneIteam extends StatelessWidget {
  const OneIteam({
    required this.product,
    super.key,
  });
  final StoreModel product;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailsPage(
                product: product,
              ))),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          height: MediaQuery.of(context).size.height * .5,
          decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 233, 226, 226),
              ),
              borderRadius: BorderRadius.circular(5)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .3,
                  child: ClipRRect(
                    child: Image.network(
                      fit: BoxFit.cover,
                      product.image!,
                    ),
                    //     Image(
                    //   // fit: BoxFit.contain,
                    //   image: Image.network (product.image!),
                    // )
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .09,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title!,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text("₹ ${(product.price! * 84).ceil().toString()}",
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
