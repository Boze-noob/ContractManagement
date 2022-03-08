import 'package:contract_management/_all.dart';
import 'package:contract_management/data/firebase/firebaseFirestoreClass.dart';

abstract class IAccount {
  bool storeUserToDatabase(UserModel userModel);
  Future<UserModel?> getUserFromDatabase();
  Future<String?> createAccount(String email, String password, String displayName, String role);
}

class AccountRepo implements IAccount {
  AccountRepo();
  FirebaseFirestoreClass firebaseFirestoreClass = FirebaseFirestoreClass();
  FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;

  @override
  bool storeUserToDatabase(UserModel userModel) {
    //TODO vidit sta je sa ovim usklicnikom, moze li se slusat u auth blocu ili provjeravat jeli current user null ili nije(automatski generirat uid ako jest
    bool result = firebaseFirestoreClass.storeData('users', userModel.id, userModel.toMap());
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
      final uid = await firebaseAuthInstance.createUserWithEmailAndPassword(email: email, password: password);
      UserModel userModel = UserModel(id: uid.user!.uid, email: email, password: password, displayName: displayName, role: role);
      storeUserToDatabase(userModel);
      return null;
    } catch (error) {
      print(error.toString());
      return error.toString();
    }
  }
}
