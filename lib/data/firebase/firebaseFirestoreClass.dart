import 'package:contract_management/_all.dart';

//TODO fix methods names to be more specific
class FirebaseFirestoreClass {
  Future<bool> storeData(String collection, String? document, var model) async {
    bool completed = true;
    try {
      if (document != null)
        await fireStoreInstance
            .collection(collection)
            .doc(document)
            .set(model)
            .catchError((onError) => completed = false);
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
      return jsonData.exists ? jsonData.data() : null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future getDataWithFilter(String collection, String fieldName, dynamic fieldValue) async {
    try {
      final jsonData = await fireStoreInstance
          .collection(collection)
          .where(fieldName, isEqualTo: fieldValue)
          .get()
          .catchError((onError) => print('Error happen in get data with filter $onError'));
      return jsonData.docs.isEmpty ? null : jsonData.docs;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future getDataWithTwoFilters(
      String collection, String fieldName, dynamic fieldValue, String fieldName2, dynamic fieldValue2) async {
    try {
      final jsonData = await fireStoreInstance
          .collection(collection)
          .where(fieldName, isEqualTo: fieldValue)
          .where(fieldName2, isEqualTo: fieldValue2)
          .get();
      return jsonData.docs;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future getDataWithFilterAndNotEqual(
      String collection, String fieldName, dynamic fieldValue, String notFieldName, dynamic notFieldValue) async {
    try {
      final jsonData = await fireStoreInstance
          .collection(collection)
          .where(notFieldName, isNotEqualTo: notFieldValue)
          .where(fieldName, isEqualTo: fieldValue)
          .get()
          .catchError((onError) => print('Error happen in get data with filter $onError'));
      return jsonData.docs.isEmpty ? null : jsonData.docs;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future getNumberOfSpecificFields(String collection, String fieldName, dynamic fieldValue) async {
    try {
      num counter = 0;
      await fireStoreInstance
          .collection(collection)
          .where(fieldName, isEqualTo: fieldValue)
          .get()
          .then((value) => counter = value.size);
      return counter;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<String?> deleteData(String collection, String document) async {
    String? errorMessage;
    try {
      await fireStoreInstance
          .collection(collection)
          .doc(document)
          .delete()
          .catchError((onError) => errorMessage = onError);
      return errorMessage;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> deleteDataWithSpecificField(String collection, String fieldName, dynamic fieldValue) async {
    String? errorMessage;
    var snapshot = await fireStoreInstance
        .collection(collection)
        .where(fieldName, isEqualTo: fieldValue)
        .get()
        .catchError((onError) => errorMessage = onError);
    snapshot.docs.every((element) {
      element.reference.delete();
      return true;
    });
    return errorMessage;
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

  Future updateSpecificField(String collection, String document, String fieldName, dynamic fieldValue) async {
    String? errorMessage;
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(document)
        .update({fieldName: fieldValue}).catchError((onError) => errorMessage = onError.toString());
    if (errorMessage != null) return errorMessage;

    return errorMessage;
  }

  Future updaterSpecificFields(String collection, String document, List<String> fieldName, List fieldValue) async {
    String? errorMessage;

    for (int i = 0; i < fieldName.length; i++) {
      await FirebaseFirestore.instance
          .collection(collection)
          .doc(document)
          .update({fieldName[i]: fieldValue[i]}).catchError((onError) => errorMessage = onError.toString());
      if (errorMessage != null) return errorMessage;
    }
    return errorMessage;
  }
}
