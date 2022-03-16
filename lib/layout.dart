import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';

class SiteLayout extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

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
