import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/cart_model.dart';

Future<String> deleteFromCart({required CartModel cartProduct}) async {
  try {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('Cart_Items')
        .where('Product_Id', isEqualTo: cartProduct.cartProduct.id)
        .get();
    if (querySnapshot.docs.isNotEmpty) {
      String cartId = "";
      for (var doc in querySnapshot.docs) {
        cartId = doc.id;
      }
      await FirebaseFirestore.instance
          .collection('Cart_Items') // Specify the collection name
          .doc(cartId) // Specify the document ID
          .delete();
      return "Success";
    } else {
      return "error in id";
    }
  } catch (e) {
    return "Error deleting document: $e";
  }
}
