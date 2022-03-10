import 'dart:io';

import 'package:contract_management/_all.dart';

abstract class IClients {
  Future<List<UserModel>?> getClients();
}

class ClientsRepo implements IClients {
  FirebaseFirestoreClass firebaseFirestoreClass;

  ClientsRepo({required this.firebaseFirestoreClass});

  @override
  Future<List<UserModel>?> getClients() async {
    final jsonData = await firebaseFirestoreClass.getDataWithFilter("users", "role", "Client");
    print("Data is :--------");
    print(jsonData.toString());
    if (jsonData == null) {
      return null;
    } else {
      print('We enter into else part of getClients');
      return jsonData.map<UserModel>((json) => UserModel.fromMap(json))?.toList();
    }
  }
}
