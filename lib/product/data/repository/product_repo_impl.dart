import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/product_model.dart';
import '../../domain/repository/product_repository.dart';

class ProductRepoImpl implements ProductRepository {
  ProductRepoImpl();

  @override
  Future<List<ProductModel>> fetchData(
      {required List<ProductModel> productList}) async {
    productList.clear();
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Products').get();
      for (var doc in querySnapshot.docs) {
        String id = doc.id;

        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        productList.add(ProductModel.fromJson(
          data,
          id,
        ));
      }
    } catch (e) {
      throw ("Error fetching data: $e");
    }
    return productList;
  }

  @override
  Future<String> addToFavorate({required ProductModel product}) async {
    try {
      await FirebaseFirestore.instance
          .collection('Products') // Assuming 'students' is the collection name
          .doc(product
              .id) // Assuming 'id' is the document ID of the student to update
          .update(product.toJson());
      return "Success";
    } catch (error) {
      return 'Error updating student data: $error';
      // Handle the error as needed
    }
  }
}
