import 'package:contract_management/_all.dart';

extension BuildContextExtensions on BuildContext {
  ServiceProvider get serviceProvider =>
      RepositoryProvider.of<ServiceProvider>(this);
}
