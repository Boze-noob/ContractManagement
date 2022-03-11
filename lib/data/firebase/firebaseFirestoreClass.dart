import 'dart:io';

import 'package:contract_management/_all.dart';

class FirebaseFirestoreClass {
  bool storeData(String collection, String document, var model) {
    try {
      fireStoreInstance.collection(collection).doc(document).set(model);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future getData(String collection, String document) async {
    try {
      var jsonData = await FirebaseFirestore.instance.collection(collection).doc(document).get();
      return jsonData.data() == null ? null : jsonData;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future getDataWithFilter(String collection, String fieldName, dynamic fieldValue) async {
    try {
      final jsonData = await fireStoreInstance.collection(collection).where(fieldName, isEqualTo: fieldValue).get();
      return jsonData.docs;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String?> deleteData(String collection, String document) async {
    String? errorMessage;
    try {
      await fireStoreInstance.collection(collection).doc(document).delete().catchError((onError) => errorMessage = onError);
      return errorMessage;
    } catch (e) {
      return e.toString();
    }
  }
}
