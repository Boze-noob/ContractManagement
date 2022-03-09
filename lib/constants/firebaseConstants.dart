import 'package:contract_management/_all.dart';

FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;
String userUid = firebaseAuthInstance.currentUser!.uid;
