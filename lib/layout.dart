import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';

class SiteLayout extends StatefulWidget {
  @override
  State<SiteLayout> createState() => _SiteLayoutState();
}

class _SiteLayoutState extends State<SiteLayout> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    //TODO cause null
    /*
    if (context.currentUserBloc.state.userModel!.role != RoleType.client.translate() &&
        context.currentUserBloc.state.userModel!.role != RoleType.company.translate()) {
      InspectRevenue.checkRevenueDates(context.revenueBloc.state.revenueModel);
    }

     */
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrentUserBloc, CurrentUserState>(
      builder: (context, state) {
        if (state.status == CurrentUserStateStatus.getting)
          return Loader(
            width: 100,
            height: 100,
            color: active,
          );
        else
          return Scaffold(
            key: scaffoldKey,
            extendBodyBehindAppBar: true,
            appBar: topNavigationBar(context, scaffoldKey),
            drawer: Drawer(
              child: SideMenu(),
            ),
            body: ResponsiveWidget(
              largeScreen: LargeScreen(),
              smallScreen: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: localNavigator(context),
              ),
            ),
          );
      },
    );
  }
}
