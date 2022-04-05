import 'package:contract_management/_all.dart';

abstract class ICompanyRequest {
  Future<List<ClientRequestModel>?> getRequests(
      String collection, String sortFieldName);
  Future<List<AdminRequestModel>?> getAdminRequests(String companyId);
}

class CompanyRequestRepo implements ICompanyRequest {
  FirebaseFirestoreClass firebaseFirestoreClass;

  CompanyRequestRepo({
    required this.firebaseFirestoreClass,
  });

  @override
  Future<List<ClientRequestModel>?> getRequests(
      String collection, String sortFieldName) async {
    final jsonData = await firebaseFirestoreClass.getAllDataFromCollection(
        collection, sortFieldName);
    return jsonData
            .map<ClientRequestModel>((json) => ClientRequestModel.fromMap(json))
            ?.toList() ??
        jsonData;
  }

  @override
  Future<List<AdminRequestModel>?> getAdminRequests(String companyId) async {
    final jsonData = await firebaseFirestoreClass.getDataWithFilter(
        'adminRequests', 'companyId', companyId);
    return jsonData != null
        ? jsonData
            .map<AdminRequestModel>((json) => AdminRequestModel.fromMap(json))
            ?.toList()
        : null;
  }
}
