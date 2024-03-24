import 'package:e_commerce/application/business_logic/bloc/product_bloc.dart';
import 'package:e_commerce/application/presentation/screens/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/model/store_model.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({required this.product, super.key});
  final StoreModel product;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        //   physics: NeverScrollableScrollPhysics(),
        children: [
          MainImage(product: product),
          DifferentImages(product: product),
          DetailsOfIteam(product: product),
        ],
      ),
    );
  }
}

class MainImage extends StatelessWidget {
  const MainImage({
    required this.product,
    super.key,
  });
  final StoreModel product;
  @override
  Widget build(BuildContext context) {
    return Image.network(
      product.image!,
      //  "https://www.jiomart.com/images/product/original/rvcws2fyqc/bruton-trendy-sports-shoes-for-men-blue-product-images-rvcws2fyqc-0-202209021256.jpg?im=Resize=(500,630)",
      height: MediaQuery.of(context).size.height * .75,
      width: double.infinity,
    );
  }
}

class DifferentImages extends StatelessWidget {
  const DifferentImages({
    required this.product,
    super.key,
  });
  final StoreModel product;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      child: ListView.builder(
        itemCount: 7,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 75,
              width: 55,
              decoration: const BoxDecoration(
                color: CupertinoColors.activeOrange,
                // border: Border.all(color: Colors.black),
              ),
              child: Image.network(
                product.image!,
                //  "https://www.jiomart.com/images/product/original/rvcws2fyqc/bruton-trendy-sports-shoes-for-men-blue-product-images-rvcws2fyqc-0-202209021256.jpg?im=Resize=(500,630)",
                fit: BoxFit.fill,
              ),
            ),
          );
        },
      ),
    );
  }
}

class DetailsOfIteam extends StatelessWidget {
  const DetailsOfIteam({
    required this.product,
    super.key,
  });
  final StoreModel product;
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
                            .read<ProductBloc>()
                            .add(AddToCartEvent(product: product));
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
