
import '../../../product/data/model/product_model.dart';


class CartModel {
  int itemCount;
  String date;
  ProductModel cartProduct;

  CartModel(
      {required this.itemCount, required this.cartProduct, required this.date});
}
