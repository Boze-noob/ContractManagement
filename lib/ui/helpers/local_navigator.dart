import 'package:contract_management/_all.dart';

Navigator localNavigator(BuildContext context) {
  return Navigator(
    key: navigationController.navigatorKey,
    initialRoute: getInitialRouteName(context),
    onGenerateRoute: generateRoute,
  );
}

String getInitialRouteName(BuildContext context) {
  late String role;
  if (context.currentUserBloc.state.userModel != null)
    role = context.currentUserBloc.state.userModel!.role;
  else
    role = RoleType.admin.translate();

  if (RoleType.admin.translate() == role)
    return overviewPageRoute;
  else if (RoleType.client.translate() == role) {
    return createRequestPageRoute;
  } else if (RoleType.company.translate() == role)
    return requestsPageRoute;
  else
    return overviewPageRoute;
}
