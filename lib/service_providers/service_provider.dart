import 'package:contract_management/_all.dart';
import 'package:flutter/foundation.dart';

class DevelopmentServiceProvider extends ServiceProvider {}

abstract class ServiceProvider {
  late IUserAuth userAuth;
  late IAccount account;

  //Add new repositories and services here
  //...

  Future<void> init() async {
    print('service provider------');
    await initFirebase();
    await initRepositories();
  }

  Future<void> initRepositories() async {
    account = AccountRepo();
    userAuth = UserAuthRepo(account: account);
  }

  Future initFirebase() async {
    print('Initializing firebase');
    if (!kIsWeb) {
      await Firebase.initializeApp();
      print('firebase initialized for mobile');
    } else {
      print('firebase initialized for web');
      await Firebase.initializeApp(
        options: FirebaseOptions(apiKey: "AIzaSyC1vKgkFIYOVH6rZanSRXrpJKt13osljE8", authDomain: "contractmanagement-d8f7f.firebaseapp.com", projectId: "contractmanagement-d8f7f", storageBucket: "contractmanagement-d8f7f.appspot.com", messagingSenderId: "1059163966516", appId: "1:1059163966516:web:0a34dce6233d9611450e61", measurementId: "G-68H02GDMN1"),
      );
    }
    print('Firebase initialized');
  }
}

Future<ServiceProvider> resolveServiceProviderFromEnvironment() async {
  ServiceProvider serviceProvider = DevelopmentServiceProvider();
  await serviceProvider.init();

  return serviceProvider;
}
