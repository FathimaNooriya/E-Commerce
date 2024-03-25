import 'package:flutter/cupertino.dart';
import '../../../data/model/product_model.dart';

class DifferentImages extends StatelessWidget {
  const DifferentImages({
    required this.product,
    super.key,
  });
  final ProductModel product;
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
              ),
              child: Image.network(
                product.image!,
                fit: BoxFit.fill,
              ),
            ),
          );
        },
      ),
    );
  }
}
