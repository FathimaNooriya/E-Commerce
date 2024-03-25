import 'package:flutter/material.dart';

import '../../../data/model/product_model.dart';
import '../screens/details.dart';

class OneIteam extends StatelessWidget {
  const OneIteam({
    required this.product,
    super.key,
  });
  final ProductModel product;
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
                    Text("₹ ${product.price!.toString()}",
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
