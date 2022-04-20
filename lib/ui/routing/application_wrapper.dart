import 'package:contract_management/_all.dart';

class ApplicationNavigationWrapper extends StatefulWidget {
  @override
  _ApplicationNavigationWrapperState createState() => _ApplicationNavigationWrapperState();
}

class _ApplicationNavigationWrapperState extends State<ApplicationNavigationWrapper> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CurrentUserBloc, CurrentUserState>(
      listener: (context, state) {
        if (state.status == CurrentUserStateStatus.success) if (state.userModel!.role != RoleType.client.translate() &&
            state.userModel!.role != RoleType.company.translate()) {
          InspectRevenue.checkRevenueDates(context.revenueBloc.state.revenueModel, context);
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          if (authState.status == AuthStateStatus.Checking) {
            return const SplashPage();
          }
          //"Current user bloc" is here because I can't delete user from FirebaseAuth only from database, so I'm checking if user is in database here
          //One of possible solutions is using firebase cloud function
          else if (authState.status == AuthStateStatus.Unauthenticated) {
            return AuthenticationPage();
          } else if (authState.status == AuthStateStatus.Authenticated) {
            return SiteLayout();
          }
          return const SplashPage();
        },
      ),
    );
  }
}
