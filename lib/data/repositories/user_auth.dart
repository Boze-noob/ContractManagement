import 'package:contract_management/_all.dart';

abstract class IUserAuth {
  Future<bool> isAuthenticated();
  Future<String?> signIn(String email, String password, bool rememberMe);
  Future<bool> signOut();
}

class UserAuthRepo extends IUserAuth {
  final FirebaseAuth _userAuth = FirebaseAuth.instance;
  final IAccount account;

  UserAuthRepo({required this.account});

  @override
  Future<bool> isAuthenticated() async {
    var box = await Hive.openBox('authBox');
    bool? isUserAuth = box.get('auth');
    print(isUserAuth);
    return isUserAuth != null ? true : false;
  }

  @override
  Future<String?> signIn(String email, String password, bool rememberMe) async {
    try {
      await _userAuth.signInWithEmailAndPassword(email: email, password: password);
      if (rememberMe) {
        print('We enter into remember me in repo');
        //FirebaseAuth does not work for flutter web so I stored info about auth in hive, mobile works fine
        var box = await Hive.openBox('authBox');
        box.put('auth', true);
      }
      return null;
    } catch (error) {
      print(error.toString());
      return error.toString();
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
