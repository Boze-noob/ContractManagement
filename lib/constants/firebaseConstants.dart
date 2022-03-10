import 'package:contract_management/_all.dart';

FirebaseAuth firebaseAuthInstance = FirebaseAuth.instance;
FirebaseFirestore fireStoreInstance = FirebaseFirestore.instance;
String userUid = firebaseAuthInstance.currentUser!.uid;
