import 'package:contract_management/_all.dart';

abstract class IRequest {
  Future<List<ClientRequestModel>?> getRequests(String collection, String sortFieldName);
}

class RequestRepo implements IRequest {
  FirebaseFirestoreClass firebaseFirestoreClass;

  RequestRepo({
    required this.firebaseFirestoreClass,
  });

  @override
  Future<List<ClientRequestModel>?> getRequests(String collection, String sortFieldName) async {
    final jsonData = await firebaseFirestoreClass.getAllDataFromCollection(collection, sortFieldName);
    return jsonData.map<ClientRequestModel>((json) => ClientRequestModel.fromMap(json))?.toList() ?? jsonData;
  }
}
