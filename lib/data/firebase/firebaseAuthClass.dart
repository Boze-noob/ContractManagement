import 'package:contract_management/_all.dart';

class FirebaseAuthClass {
  Future<bool> changeUserPassword(String password) async {
    try {
      if (firebaseAuthInstance.currentUser != null) {
        await firebaseAuthInstance.currentUser!.updatePassword(password);
        return true;
      } else
        return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> changeUserEmail(String email) async {
    try {
      if (firebaseAuthInstance.currentUser != null) {
        await firebaseAuthInstance.currentUser!.updateEmail(email);
        return true;
      } else
        return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future createUser(String email, String password) async {
    final account = await firebaseAuthInstance.createUserWithEmailAndPassword(email: email, password: password);
    return account;
  }

  Future deleteCurrentUser() async {
    await firebaseAuthInstance.currentUser!.delete();
  }
}
