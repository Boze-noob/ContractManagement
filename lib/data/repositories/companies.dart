import 'package:contract_management/_all.dart';

abstract class ICompanies {
  Future<List<UserModel>?> getCompanies();
  Future<List<UserModel>?> getCompaniesWithoutContract();
  Future<String?> deleteCompany(String uid);
  Future<bool> editCompany(UserModel model);
}

class CompaniesRepo implements ICompanies {
  Api api;
  FirebaseFirestoreClass firebaseFirestoreClass;
  FirebaseAuthClass firebaseAuthClass;

  CompaniesRepo({required this.api, required this.firebaseFirestoreClass, required this.firebaseAuthClass});

  @override
  Future<String?> deleteCompany(String uid) async {
    await api.delete("user/delete", {"id": uid});
    return await firebaseFirestoreClass.deleteData('users', uid);
  }

  @override
  Future<bool> editCompany(UserModel model) async {
    return await firebaseFirestoreClass.storeData('users', model.id, model.toMap());
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
