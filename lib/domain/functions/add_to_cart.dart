import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import '../model/my_cart_model.dart';
import '../model/store_model.dart';

Future<String> addToCart({required StoreModel product}) async {
  DateTime date = DateTime.now();
  try {
    FirebaseFirestore.instance.collection("Cart_Items").add(MyCartModel(
          productId: product.id!,
          date: DateFormat("yyyy-MM-dd").format(date),
          itemCount: 1,
        ).toJson());
    return "Success";
  } catch (e) {
    return ("Error adding data: $e");
  }
}
