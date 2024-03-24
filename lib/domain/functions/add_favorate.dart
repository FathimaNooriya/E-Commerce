import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/domain/model/store_model.dart';

Future<String> addToFavorate({required StoreModel product}) async {
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
