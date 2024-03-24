import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/store_model.dart';

Future<List<StoreModel>> fetchData({required List<StoreModel> productList}) async {
  productList.clear();
  try {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Products').get();

    querySnapshot.docs.forEach((doc) {
      // doc.data().id;
      String id = doc.id;
      print(id);
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

      productList.add(StoreModel.fromJson(
        data,
        id,
      ));

      // productList.add(StoreModel.fromJson(data));
    });
  } catch (e) {
    print("Error fetching data: $e");
  }
  return productList;
}
