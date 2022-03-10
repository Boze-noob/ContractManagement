import 'package:contract_management/_all.dart';

extension BuildContextExtensions on BuildContext {
  ServiceProvider get serviceProvider => RepositoryProvider.of<ServiceProvider>(this);
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get screenWidth => mediaQuery.size.width;
  double get screenHeight => mediaQuery.size.height;
  double get textSizeS => 12;
  double get textSizeM => 16;
  double get textSizeL => 20;

  //Blocs
  AuthBloc get authBloc => read<AuthBloc>();
  ClientsBloc get clientsBloc => read<ClientsBloc>();
  CreateUserBloc get createUserBloc => read<CreateUserBloc>();
  CurrentUserBloc get currentUserBloc => read<CurrentUserBloc>();
  EditProfileBloc get editProfileBloc => read<EditProfileBloc>();
}
