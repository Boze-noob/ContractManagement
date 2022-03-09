import 'package:contract_management/_all.dart';

class FirebaseFirestoreClass {
  bool storeData(String collection, String document, var model) {
    try {
      FirebaseFirestore.instance.collection(collection).doc(document).set(model);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future getData(String collection, String document) async {
    try {
      var jsonData = await FirebaseFirestore.instance.collection(collection).doc(document).get();
      return jsonData;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future getDataWithFilter(String collection, String fieldName, String fieldValue) async {
    try {
      var jsonData = FirebaseFirestore.instance.collection(collection).where(fieldName, isEqualTo: fieldValue);
      return jsonData;
    } catch (e) {
      print(e);
    }
  }
}
