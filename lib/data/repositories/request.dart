import 'package:contract_management/_all.dart';

abstract class IRequest {
  Future<List<ClientRequestModel>?> getRequests(String collection, String sortFieldName);
  Future<List<AdminRequestModel>?> getAdminRequests(String companyId);
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

  @override
  Future<List<AdminRequestModel>?> getAdminRequests(String companyId) async {
    //TODO add parameters
    final jsonData = await firebaseFirestoreClass.getDataWithFilter(collection, fieldName, fieldValue);
    return jsonData.map<AdminRequestModel>((json) => AdminRequestModel.fromMap(json))?.toList() ?? jsonData;

  }
}
