abstract class CompaniesEvent {}

class CompaniesInitEvent extends CompaniesEvent {}

class CompaniesGetEvent extends CompaniesEvent {}

class CompaniesDeleteEvent extends CompaniesEvent {
  String companyId;
  CompaniesDeleteEvent({required this.companyId});
}

class CompaniesGetCompaniesWithoutContract extends CompaniesEvent {}
