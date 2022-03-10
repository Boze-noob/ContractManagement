import 'package:contract_management/_all.dart';

abstract class IUserAuth {
  Future<bool> isAuthenticated();
  Future<String?> signIn(String email, String password, bool rememberMe);
  Future<bool> signOut();
}

class UserAuthRepo implements IUserAuth {
  final FirebaseAuth _userAuth = FirebaseAuth.instance;
  final IAccount account;
  final FirebaseFirestoreClass firebaseFirestoreClass;

  UserAuthRepo({
    required this.account,
    required this.firebaseFirestoreClass,
  });

  @override
  Future<bool> isAuthenticated() async {
    //var box = await Hive.openBox('authBox');
    //bool? isUserAuth = box.get('auth');
    //print(isUserAuth);

    return _userAuth.currentUser != null ? true : false;
  }

  @override
  Future<String?> signIn(String email, String password, bool rememberMe) async {
    try {
      await _userAuth.signInWithEmailAndPassword(email: email, password: password);
      if (rememberMe) {
        //FirebaseAuth does not work for flutter web so I stored info about auth in hive, mobile works fine
        var box = await Hive.openBox('authBox');
        box.put('auth', true);
      }
      //TODO check this
      //"Current user bloc" is here because I can't delete user from FirebaseAuth only from database, so I'm checking if user is in database here
      //One of possible solutions is using firebase cloud function
      final result = await firebaseFirestoreClass.getData('users', _userAuth.currentUser!.uid);
      if (result == null)
        return 'User doesn\'t exist in database';
      else
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
