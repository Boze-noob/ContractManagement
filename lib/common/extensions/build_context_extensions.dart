import 'package:contract_management/_all.dart';

extension BuildContextExtensions on BuildContext {
  ServiceProvider get serviceProvider => RepositoryProvider.of<ServiceProvider>(this);
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get screenWidth => mediaQuery.size.width;
  double get screenHeight => mediaQuery.size.height;
  double get textSizeS => 12;
  double get textSizeM => 16;
  double get textSizeL => 20;
  double get textSizeXL => 23;
  double get textSizeXXL => 26;

  //Blocs
  AnnouncementBloc get announcementBloc => read<AnnouncementBloc>();
  AuthBloc get authBloc => read<AuthBloc>();
  BillBloc get billBloc => read<BillBloc>();
  ClientsBloc get clientsBloc => read<ClientsBloc>();
  ClientRequestBloc get clientRequestBloc => read<ClientRequestBloc>();
  CompaniesBloc get companiesBloc => read<CompaniesBloc>();
  CompanyRequestsBloc get companyRequestsBloc => read<CompanyRequestsBloc>();
  CreateUserBloc get createUserBloc => read<CreateUserBloc>();
  ContractsBloc get contractsBloc => read<ContractsBloc>();
  ContractsTemplateListBloc get contractsTemplateListBloc => read<ContractsTemplateListBloc>();
  CreateContractBloc get createContractBloc => read<CreateContractBloc>();
  CurrentUserBloc get currentUserBloc => read<CurrentUserBloc>();
  DeleteContractRequestBloc get deleteContractRequestBloc => read<DeleteContractRequestBloc>();
  EditProfileBloc get editProfileBloc => read<EditProfileBloc>();
  CompanyEditBloc get companyEditBloc => read<CompanyEditBloc>();
  MyContractBloc get myContractBloc => read<MyContractBloc>();
  NavigatorBloc get navigatorBloc => read<NavigatorBloc>();
  NotificationsBloc get notificationsBloc => read<NotificationsBloc>();
  SendContractRequestBloc get sendContractRequestBloc => read<SendContractRequestBloc>();
  OrderBloc get orderBloc => read<OrderBloc>();
  WorkDiariesBloc get workDiariesBloc => read<WorkDiariesBloc>();
}
