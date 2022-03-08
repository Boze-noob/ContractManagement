import 'package:contract_management/_all.dart';

extension BuildContextExtensions on BuildContext {
  ServiceProvider get serviceProvider => RepositoryProvider.of<ServiceProvider>(this);
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get screenWidth => mediaQuery.size.width;
  double get screenHeight => mediaQuery.size.height;

  //Blocs
  CreateUserBloc get createUserBloc => read<CreateUserBloc>();
}
