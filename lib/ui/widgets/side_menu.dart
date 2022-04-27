import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';
import 'package:get/get.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Container(
      color: light,
      child: ListView(
        children: [
          if (ResponsiveWidget.isSmallScreen(context))
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    SizedBox(width: _width / 48),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Image.asset("assets/icons/logo.png"),
                    ),
                    Flexible(
                      child: CustomText(
                        text: "Dash",
                        size: 20,
                        weight: FontWeight.bold,
                        color: active,
                      ),
                    ),
                    SizedBox(width: _width / 48),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          Divider(
            color: lightGrey.withOpacity(.1),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: getMenuItems(context)
                .map(
                  (item) => SideMenuItem(
                    itemName: item.name,
                    onTap: () {
                      if (!menuController.isActive(item.name) && item.name != authenticationPageDisplayName) {
                        menuController.changeActiveItemTo(item.name);
                        if (ResponsiveWidget.isSmallScreen(context)) Get.back();
                        navigationController.navigateTo(item.route);
                      }

                      if (item.name == authenticationPageDisplayName) {
                        menuController.changeActiveItemTo(overviewPageDisplayName);
                        context.read<AuthBloc>().add(
                              AuthSignOutEvent(),
                            );
                      }
                    },
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    final role = context.currentUserBloc.state.userModel!.role;
    if (role == RoleType.client.translate()) {
      menuController.changeActiveItemTo(createRequestDisplayName);
    } else if (role == RoleType.company.translate()) {
      menuController.changeActiveItemTo(requestsPageDisplayName);
    }
    super.initState();
  }
}

List getMenuItems(BuildContext context) {
  final role = context.currentUserBloc.state.userModel!.role;
  if (role == RoleType.client.translate()) {
    return clientMenuItemRoutes;
  } else if (role == RoleType.company.translate()) {
    return companyMenuItemRoutes;
  } else {
    return sideMenuItemRoutes;
  }
}
