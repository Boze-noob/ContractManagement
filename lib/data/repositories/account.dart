import 'package:contract_management/_all.dart';
import 'package:contract_management/data/firebase/firebaseFirestoreClass.dart';

abstract class IAccount {
  bool storeUserToDatabase(UserModel userModel);
}

class AccountRepo implements IAccount {
  AccountRepo();
  FirebaseFirestoreClass firebaseFirestoreClass = FirebaseFirestoreClass();
  FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;

  @override
  bool storeUserToDatabase(UserModel userModel) {
    //TODO vidit sta je sa ovim usklicnikom, moze li se slusat u auth blocu ili provjeravat jeli current user null ili nije(automatski generirat uid ako jest
    bool result = firebaseFirestoreClass.storeData('users', firebaseAuthInstance.currentUser!.uid, userModel);
    return result;
  }
}
