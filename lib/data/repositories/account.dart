import 'package:contract_management/_all.dart';

abstract class IAccount {
  //TODO change to model return type
  Future<bool> storeUserToDatabase(UserModel userModel);
}

class AccountRepo implements IAccount {
  AccountRepo();

  @override
  Future<bool> storeUserToDatabase(UserModel userModel) {
    // TODO: implement storeUserToDatabase
    throw UnimplementedError();
  }
}
