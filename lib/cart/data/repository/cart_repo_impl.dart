import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/cart/domain/repository/cart_repository.dart';
import 'package:intl/intl.dart';
import '../model/my_cart_model.dart';
import '../../../product/data/model/product_model.dart';
import '../../domain/entities/cart_model.dart';
import '../../domain/usecases/get_product_by_id.dart';

class CartRepoImpl implements CartRepository {
  @override
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
        ProductModel? cartProdu =
            await getProductById(documentId: data["Product_Id"]);
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

  @override
  Future<String> addToCart({required ProductModel product}) async {
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

  @override
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
}
