
import '../../data/model/product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> fetchData(
      {required List<ProductModel> productList});
  Future<String> addToFavorate({required ProductModel product});
}
