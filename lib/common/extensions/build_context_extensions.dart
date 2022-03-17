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

  //Blocs
  AuthBloc get authBloc => read<AuthBloc>();
  ClientsBloc get clientsBloc => read<ClientsBloc>();
  ClientRequestBloc get clientRequestBloc => read<ClientRequestBloc>();
  CompaniesBloc get companiesBloc => read<CompaniesBloc>();
  CreateUserBloc get createUserBloc => read<CreateUserBloc>();
  ContractsBloc get contractsBloc => read<ContractsBloc>();
  ContractsTemplateListBloc get contractsTemplateListBloc => read<ContractsTemplateListBloc>();
  CreateContractBloc get createContractBloc => read<CreateContractBloc>();
  CurrentUserBloc get currentUserBloc => read<CurrentUserBloc>();
  EditProfileBloc get editProfileBloc => read<EditProfileBloc>();
  NavigatorBloc get navigatorBloc => read<NavigatorBloc>();
}
