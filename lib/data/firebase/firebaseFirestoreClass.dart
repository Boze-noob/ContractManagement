import 'package:contract_management/_all.dart';

class FirebaseFirestoreClass {
  Future<bool> storeData(String collection, String? document, var model) async {
    bool completed = true;
    try {
      if (document != null)
        await fireStoreInstance.collection(collection).doc(document).set(model).catchError((onError) => completed = false);
      else
        await fireStoreInstance.collection(collection).add(model);
      return completed;
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

  Future getNumberOfSpecificField(String collection, String fieldName, dynamic fieldValue) async {
    try {
      num counter = 0;
      await fireStoreInstance.collection(collection).where(fieldName, isEqualTo: fieldValue).get().then((value) => counter = value.size);
      return counter;
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

  Future getAllDataFromCollection(String collection, String? sortFieldName) async {
    try {
      final jsonData;
      if (sortFieldName == null)
        jsonData = await fireStoreInstance.collection(collection).get();
      else
        jsonData = await fireStoreInstance.collection(collection).orderBy(sortFieldName).get();
      return jsonData.docs;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
