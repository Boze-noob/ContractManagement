import 'package:contract_management/_all.dart';
import 'package:contract_management/data/repositories/announcement.dart';
import 'package:contract_management/data/repositories/revenue.dart';
import 'package:flutter/foundation.dart';

class DevelopmentServiceProvider extends ServiceProvider {}

abstract class ServiceProvider {
  late IUserAuth userAuth;
  late IAccount accountRepo;
  late IAnnouncement announcementRepo;
  late IBill billRepo;
  late IClients clientsRepo;
  late ICompanies companiesRepo;
  late IContracts contractsRepo;
  late INotifications notificationsRepo;
  late IOrder orderRepo;
  late ICompanyRequest companyRequestRepo;
  late IRevenue revenueRepo;
  late IWorkDiaries workDiaries;

  late FirebaseAuthClass firebaseAuthClass;
  late FirebaseFirestoreClass firebaseFirestoreClass;

  //Add new repositories and services here
  //...

  Future<void> init() async {
    await initFirebase();
    await initRepositories();
  }

  Future<void> initRepositories() async {
    firebaseAuthClass = FirebaseAuthClass();
    firebaseFirestoreClass = FirebaseFirestoreClass();

    notificationsRepo = NotificationsRepo(firebaseFirestoreClass: firebaseFirestoreClass);
    accountRepo = AccountRepo();
    announcementRepo =
        AnnouncementRepo(firebaseFirestoreClass: firebaseFirestoreClass, notificationsRepo: notificationsRepo);
    billRepo = BillRepo(firebaseFirestoreClass: firebaseFirestoreClass);
    clientsRepo = ClientsRepo(firebaseFirestoreClass: firebaseFirestoreClass, notificationsRepo: notificationsRepo);
    companiesRepo = CompaniesRepo(firebaseFirestoreClass: firebaseFirestoreClass, firebaseAuthClass: firebaseAuthClass);
    contractsRepo = ContractsRepo(firebaseFirestoreClass: firebaseFirestoreClass, notificationsRepo: notificationsRepo);
    orderRepo = OrderRepo(
        firebaseFirestoreClass: firebaseFirestoreClass,
        notificationsRepo: notificationsRepo,
        contractsRepo: contractsRepo,
        companiesRepo: companiesRepo);
    companyRequestRepo =
        CompanyRequestRepo(firebaseFirestoreClass: firebaseFirestoreClass, notificationsRepo: notificationsRepo);
    revenueRepo = RevenueRepo(firebaseFirestoreClass: firebaseFirestoreClass);
    userAuth = UserAuthRepo(account: accountRepo, firebaseFirestoreClass: firebaseFirestoreClass);
    workDiaries = WorkDiaries(firebaseFirestoreClass: firebaseFirestoreClass);
  }

  Future initFirebase() async {
    //Check if we use browser or mobile device
    if (!kIsWeb) {
      await Firebase.initializeApp();
    } else {
      await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyC1vKgkFIYOVH6rZanSRXrpJKt13osljE8",
            authDomain: "contractmanagement-d8f7f.firebaseapp.com",
            projectId: "contractmanagement-d8f7f",
            storageBucket: "contractmanagement-d8f7f.appspot.com",
            messagingSenderId: "1059163966516",
            appId: "1:1059163966516:web:0a34dce6233d9611450e61",
            measurementId: "G-68H02GDMN1"),
      );
    }
  }
}

Future<ServiceProvider> resolveServiceProviderFromEnvironment() async {
  ServiceProvider serviceProvider = DevelopmentServiceProvider();
  await serviceProvider.init();

  return serviceProvider;
}
