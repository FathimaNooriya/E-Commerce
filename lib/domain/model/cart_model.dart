import 'package:e_commerce/domain/model/store_model.dart';

class CartModel {
  int itemCount;
  String date;
  StoreModel cartProduct;

  CartModel(
      {required this.itemCount, required this.cartProduct, required this.date});

  // CartModel.fromJson(Map<String, dynamic> json) {
  //   cartId = json["id"] as int;
  //   date = json["date"] as String;
  //   cartProduct = <Product>[];
  //   if (json['products'] != null) {
  //     json['products'].forEach(
  //       (e) {
  //         cartProduct!.add(
  //           Product.fromJson(e as Map<String, dynamic>),
  //         );
  //       },
  //     );
  //   } else {
  //     print("Product list is null");
  //   }
  // }
  // static List<CartModel> toCartProductList(List<dynamic> jsonList) {
  //   return jsonList.map((e) => CartModel.fromJson(e)).toList();
  // }
}

// class Product {
//   int? productId;
//   int? quantity;

//   Product({required this.productId, required this.quantity});

//   Product.fromJson(Map<String, dynamic> json) {
//     productId = json["productId"] as int;
//     quantity = json["quantity"] as int;
//   }
  // static List<product> toCartProductList(List<dynamic> jsonList) {
  //   return jsonList.map((e) => product.fromJson(e)).toList();
  // }
//}
