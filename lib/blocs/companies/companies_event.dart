import 'package:contract_management/_all.dart';

abstract class CompaniesEvent {}

class CompaniesInitEvent extends CompaniesEvent {}

class CompaniesGetEvent extends CompaniesEvent {}

class CompaniesDeleteEvent extends CompaniesEvent {
  String uid;
  CompaniesDeleteEvent({required this.uid});
}

class CompaniesGetCompaniesWithoutContract extends CompaniesEvent {}
