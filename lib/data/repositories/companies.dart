import 'package:contract_management/_all.dart';

abstract class ICompanies {
  Future<List<UserModel>?> getCompanies();
  Future<List<UserModel>?> getCompaniesWithoutContract();
  Future<String?> deleteCompany(String uid);
  Future<String?> editCompany();
}

class CompaniesRepo implements ICompanies {
  FirebaseFirestoreClass firebaseFirestoreClass;

  CompaniesRepo({required this.firebaseFirestoreClass});

  @override
  Future<String?> deleteCompany(String uid) async {
    return await firebaseFirestoreClass.deleteData('users', uid);
  }

  @override
  Future<String?> editCompany() {
    // TODO: implement editCompany
    throw UnimplementedError();
  }

  @override
  Future<List<UserModel>?> getCompanies() async {
    final jsonData = await firebaseFirestoreClass.getDataWithFilter('users', 'role', 'Company');
    if (jsonData == null) {
      return null;
    } else {
      return jsonData.map<UserModel>((json) => UserModel.fromMap(json))?.toList();
    }
  }

  @override
  Future<List<UserModel>?> getCompaniesWithoutContract() async {
    final jsonData = await firebaseFirestoreClass.getDataWithTwoFilters('users', 'role', 'Company', 'contractId', null);
    if (jsonData == null) {
      return null;
    } else {
      return jsonData.map<UserModel>((json) => UserModel.fromMap(json))?.toList();
    }
  }
}
