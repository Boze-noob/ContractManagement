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

  Future getDataWithFilter(String collection, String fieldName, String fieldValue) async {
    try {
      final jsonData = await fireStoreInstance.collection(collection).where(fieldName, isEqualTo: fieldValue).get();
      return jsonData.docs;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> deleteData(String collection, String document) async {
    try {
      await fireStoreInstance.collection(collection).doc(document).delete().catchError((onError) => print(onError));
      return true;
    } catch (e) {
      return false;
    }
  }
}
