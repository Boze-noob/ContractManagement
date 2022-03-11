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
  CreateUserBloc get createUserBloc => read<CreateUserBloc>();
  CompaniesBloc get companiesBloc => read<CompaniesBloc>();
  ContractsBloc get contractsBloc => read<ContractsBloc>();
  CurrentUserBloc get currentUserBloc => read<CurrentUserBloc>();
  EditProfileBloc get editProfileBloc => read<EditProfileBloc>();
}
