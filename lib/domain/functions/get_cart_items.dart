import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/domain/model/cart_model.dart';
import 'package:e_commerce/domain/model/my_cart_model.dart';
import 'package:e_commerce/domain/model/store_model.dart';

import 'cart_product.dart';

Future<List<CartModel>> fetchCartItems(
    {required List<MyCartModel> cartItems,
    required List<CartModel> cartProducts}) async {
  cartProducts.clear();
  try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Cart_Items').get();

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      cartItems.add(MyCartModel.fromJson(
        data,
      ));
      StoreModel? cartProdu =
          await getDocumentById(documentId: data["Product_Id"]);
      cartProducts.add(CartModel(
          itemCount: data["Item_Count"],
          cartProduct: cartProdu!,
          date: data["Date"]));
    }
  } catch (e) {
    throw ("Error fetching data: $e");
  }
  return cartProducts;
}
