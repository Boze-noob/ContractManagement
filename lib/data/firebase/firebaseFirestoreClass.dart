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
}
