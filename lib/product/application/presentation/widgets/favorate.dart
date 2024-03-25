import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/model/product_model.dart';
import '../../business_logic/bloc/product_bloc.dart';
import 'one_item.dart';

class ProductWithFavorate extends StatelessWidget {
  const ProductWithFavorate({
    required this.oneProduct,
    super.key,
  });
  final ProductModel oneProduct;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        OneIteam(product: oneProduct),
        Align(
          alignment: const Alignment(.93, -.93),
          child: IconButton(
            onPressed: () {
              ProductModel favorateProduct = oneProduct;
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
                return oneProduct.favorite!
                    ? const Icon(
                        Icons.favorite,
                      )
                    : const Icon(Icons.favorite_border_outlined);
              },
              listener: (context, state) {},
            ),
          ),
        )
      ],
    );
  }
}
