import 'package:contract_management/_all.dart';

abstract class IAccount {
  Future<bool> storeUserToDatabase(UserModel userModel);
  Future<UserModel?> getUserFromDatabase();
  Future<String?> createAccount(String email, String password, String displayName, String role);
  Future<bool> editAccount(UserModel userModel);
  Future<String?> deleteCurrentUser(String uid);
}

class AccountRepo implements IAccount {
  Api api;
  AccountRepo({required this.api});
  FirebaseFirestoreClass firebaseFirestoreClass = FirebaseFirestoreClass();
  FirebaseAuthClass firebaseAuthClass = FirebaseAuthClass();
  FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;

  @override
  Future<bool> storeUserToDatabase(UserModel userModel) async {
    bool result = await firebaseFirestoreClass.storeData('users', userModel.id, userModel.toMap());
    return result;
  }

  @override
  Future<UserModel?> getUserFromDatabase() async {
    final String userId = firebaseAuthInstance.currentUser!.uid;
    var userModelJson = await firebaseFirestoreClass.getData('users', userId);
    if (userModelJson != null) {
      return UserModel.fromMap(userModelJson);
    } else {
      return null;
    }
  }

  @override
  Future<String?> createAccount(String email, String password, String role, String displayName) async {
    try {
      final account = await firebaseAuthClass.createUser(email, password);
      UserModel userModel =
          UserModel(id: account.user!.uid, email: email, password: password, displayName: displayName, role: role);
      storeUserToDatabase(userModel);
      return null;
    } catch (error) {
      print(error.toString());
      return error.toString();
    }
  }

  @override
  Future<bool> editAccount(UserModel userModel) async {
    final fireStoreResult = await firebaseFirestoreClass.storeData('users', userUid, userModel.toMap());
    bool firebaseAuthResult = false;
    if (userModel.password != null) {
      firebaseAuthResult = await firebaseAuthClass.changeUserPassword(userModel.password!);
    }
    await firebaseAuthClass.changeUserEmail(userModel.email);
    if (!fireStoreResult && !firebaseAuthResult) {
      return false;
    } else
      return true;
  }

  @override
  Future<String?> deleteCurrentUser(String uid) async {
    await api.delete("user/delete", {"id": uid});
    return await firebaseFirestoreClass.deleteData('users', firebaseAuthInstance.currentUser!.uid);
  }
}
