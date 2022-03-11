import 'package:contract_management/_all.dart';

abstract class IClients {
  Future<List<UserModel>?> getClients();
  Future<String?> deleteClient(String uid);
}

class ClientsRepo implements IClients {
  FirebaseFirestoreClass firebaseFirestoreClass;

  ClientsRepo({required this.firebaseFirestoreClass});

  @override
  Future<List<UserModel>?> getClients() async {
    final jsonData = await firebaseFirestoreClass.getDataWithFilter("users", "role", "Client");
    if (jsonData == null) {
      return null;
    } else {
      return jsonData.map<UserModel>((json) => UserModel.fromMap(json))?.toList();
    }
  }

  @override
  Future<String?> deleteClient(String userId) async {
    final result = await firebaseFirestoreClass.deleteData('users', userId);
    return result;
  }
}
