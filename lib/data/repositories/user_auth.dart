import 'package:contract_management/_all.dart';

abstract class IUserAuth {
  Future<bool> isAuthenticated();
  Future<bool> signIn(String email, String password);
  Future<bool> signOut();
  Future<bool> register(String? email, String? password, String? role);
}

class UserAuthRepo extends IUserAuth {
  final FirebaseAuth _userAuth = FirebaseAuth.instance;
  final IAccount account;

  UserAuthRepo({required this.account});

  @override
  Future<bool> isAuthenticated() async {
    // ignore: unnecessary_null_comparison
    return _userAuth.currentUser!.uid != null ? true : false;
  }

  @override
  Future<bool> register(String? email, String? password, String? role) async {
    try {
      final uid = await _userAuth.signInWithEmailAndPassword(email: email!, password: password!);
      UserModel userModel = UserModel(id: uid.user!.uid, email: email, password: password, role: role);
      await account.storeUserToDatabase(userModel);
      return true;
    } catch (error) {
      print(error.toString());
      return false;
    }
  }

  @override
  Future<bool> signIn(String email, String password) async {
    try {
      await _userAuth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (error) {
      print(error.toString());
      return false;
    }
  }

  @override
  Future<bool> signOut() async {
    try {
      await _userAuth.signOut();
      return true;
    } catch (error) {
      print(error.toString());
      return false;
    }
  }
}
