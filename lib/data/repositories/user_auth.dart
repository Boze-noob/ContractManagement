import 'package:contract_management/_all.dart';

abstract class IUserAuth {
  Future<bool> isAuthenticated();
  Future<bool> signIn(String email, String password);
  Future<bool> signOut();
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
