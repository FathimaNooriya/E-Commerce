import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/domain/model/store_model.dart';
import 'package:flutter/foundation.dart';

Future<StoreModel?> getDocumentById({required String documentId}) async {
  try {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("Products")
        .doc(documentId)
        .get();
    if (documentSnapshot.exists) {
      StoreModel mypro = StoreModel.fromJson(
          documentSnapshot.data() as Map<String, dynamic>, documentId);
      return mypro;
    } else {
      debugPrint('Document does not exist');
      return null;
    }
  } catch (e) {
    debugPrint('Error getting document: $e');
    return null;
  }
}
