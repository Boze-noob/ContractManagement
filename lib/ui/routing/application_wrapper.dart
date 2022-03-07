import 'package:contract_management/_all.dart';

class ApplicationNavigationWrapper extends StatefulWidget {
  @override
  _ApplicationNavigationWrapperState createState() => _ApplicationNavigationWrapperState();
}

class _ApplicationNavigationWrapperState extends State<ApplicationNavigationWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        if (authState.status == AuthStateStatus.Checking) {
          return const SplashPage();
        } else if (authState.status == AuthStateStatus.Unauthenticated) {
          return AuthenticationPage();
        } else if (authState.status == AuthStateStatus.Authenticated) {
          return SiteLayout();
        }
        return const SplashPage();
      },
    );
  }
}
