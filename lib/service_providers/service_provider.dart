import 'package:contract_management/_all.dart';
import 'package:contract_management/data/repositories/companies.dart';
import 'package:contract_management/data/repositories/request.dart';
import 'package:flutter/foundation.dart';

class DevelopmentServiceProvider extends ServiceProvider {}

abstract class ServiceProvider {
  late IUserAuth userAuth;
  late IAccount accountRepo;
  late IClients clientsRepo;
  late ICompanies companiesRepo;
  late IContracts contractsRepo;
  late IRequest requestRepo;

  late FirebaseAuthClass firebaseAuthClass;
  late FirebaseFirestoreClass firebaseFirestoreClass;

  //Add new repositories and services here
  //...

  Future<void> init() async {
    print('service provider------');
    await initFirebase();
    await initRepositories();
  }

  Future<void> initRepositories() async {
    firebaseAuthClass = FirebaseAuthClass();
    firebaseFirestoreClass = FirebaseFirestoreClass();

    accountRepo = AccountRepo();
    clientsRepo = ClientsRepo(firebaseFirestoreClass: firebaseFirestoreClass);
    companiesRepo = CompaniesRepo(firebaseFirestoreClass: firebaseFirestoreClass);
    contractsRepo = ContractsRepo(firebaseFirestoreClass: firebaseFirestoreClass);
    requestRepo = RequestRepo(firebaseFirestoreClass: firebaseFirestoreClass);
    userAuth = UserAuthRepo(account: accountRepo, firebaseFirestoreClass: firebaseFirestoreClass);
  }

  Future initFirebase() async {
    //Check if we use browser or mobile device
    if (!kIsWeb) {
      await Firebase.initializeApp();
    } else {
      await Firebase.initializeApp(
        options: FirebaseOptions(apiKey: "AIzaSyC1vKgkFIYOVH6rZanSRXrpJKt13osljE8", authDomain: "contractmanagement-d8f7f.firebaseapp.com", projectId: "contractmanagement-d8f7f", storageBucket: "contractmanagement-d8f7f.appspot.com", messagingSenderId: "1059163966516", appId: "1:1059163966516:web:0a34dce6233d9611450e61", measurementId: "G-68H02GDMN1"),
      );
    }
  }
}

Future<ServiceProvider> resolveServiceProviderFromEnvironment() async {
  ServiceProvider serviceProvider = DevelopmentServiceProvider();
  await serviceProvider.init();

  return serviceProvider;
}
