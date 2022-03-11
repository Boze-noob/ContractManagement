abstract class CompaniesEvent {}

class CompaniesInitEvent extends CompaniesEvent {}

class CompaniesGetEvent extends CompaniesEvent {}

class CompaniesDeleteEvent extends CompaniesEvent {
  String uid;
  CompaniesDeleteEvent({required this.uid});
}
