import '../../data/model/my_cart_model.dart';
import '../../../product/data/model/product_model.dart';
import '../entities/cart_model.dart';

abstract class CartRepository {
  Future<List<CartModel>> fetchCartItems(
      {required List<MyCartModel> cartItems,
      required List<CartModel> cartProducts});
  Future<String> addToCart({required ProductModel product});
  Future<String> deleteFromCart({required CartModel cartProduct});
}
