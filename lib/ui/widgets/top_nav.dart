import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';
import 'package:get/get.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) => AppBar(
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Image.asset(
                    "assets/icons/logo.png",
                    width: 28,
                  ),
                ),
              ],
            )
          : IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                key.currentState!.openDrawer();
              }),
      titleSpacing: 0,
      title: Container(
        child: Row(
          children: [
            Visibility(
                visible: ResponsiveWidget.isLargeScreen(context),
                child: CustomText(
                  text: "Contract Management",
                  color: lightGrey,
                  size: 18,
                  weight: FontWeight.bold,
                )),
            Expanded(child: Container()),
            Visibility(
              visible: RoleType.values[0].translate() == context.currentUserBloc.state.userModel!.role ? true : false,
              child: IconButton(
                  icon: Icon(
                    Icons.person_add,
                    color: dark,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => CustomDialog(
                          buttonText: 'Create account',
                          child: Container(
                            width: context.screenWidth / 2,
                            child: Form(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 30),
                                child: BlocListener<CreateUserBloc, CreateUserState>(
                                  listener: (context, state) {
                                    if (state.status == CreateUserStateStatus.error) {
                                      print('error happen in creating');
                                      if (state.errorMessage != null) showInfoMessage(state.errorMessage!, context);
                                    }
                                  },
                                  child: BlocBuilder<CreateUserBloc, CreateUserState>(
                                    builder: (context, state) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: 16,
                                          ),
                                          CustomText(
                                            text: 'Enter required parameters',
                                            size: 22,
                                            weight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                          SizedBox(
                                            height: 16,
                                          ),
                                          TextFormField(
                                            decoration: InputDecoration(
                                              icon: const Icon(Icons.email),
                                              hintText: 'Enter email',
                                              labelText: 'Email',
                                              fillColor: active,
                                            ),
                                            onChanged: (text) => context.createUserBloc.add(
                                              CreateUserUpdateModelEvent(
                                                userModel: state.userModel.copyWith(email: text),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            obscureText: true,
                                            decoration: const InputDecoration(
                                              icon: const Icon(Icons.password),
                                              hintText: 'Enter password',
                                              labelText: 'Password',
                                            ),
                                            onChanged: (text) => context.createUserBloc.add(
                                              CreateUserUpdateModelEvent(
                                                userModel: state.userModel.copyWith(password: text),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          TextFormField(
                                            decoration: InputDecoration(
                                              icon: const Icon(Icons.email),
                                              hintText: 'Enter display name',
                                              labelText: 'Display name',
                                              fillColor: active,
                                            ),
                                            onChanged: (text) => context.createUserBloc.add(
                                              CreateUserUpdateModelEvent(
                                                userModel: state.userModel.copyWith(displayName: text),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          RadioRow(),
                                          SizedBox(
                                            height: 30,
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                          onButtonPressed: () {
                            context.createUserBloc.add(
                              CreateUserSubmitEvent(),
                            );
                          }),
                    );
                  }),
            ),
            IconButton(
                icon: Icon(
                  Icons.settings,
                  color: dark,
                ),
                onPressed: () {}),
            _NotificationBellWidget(),
            Container(
              width: 1,
              height: 22,
              color: lightGrey,
            ),
            SizedBox(
              width: 24,
            ),
            BlocBuilder<CurrentUserBloc, CurrentUserState>(
              builder: (context, state) {
                if (state.userModel != null) {
                  return CustomText(
                    text: state.userModel!.displayName,
                    color: lightGrey,
                  );
                } else {
                  return Text(' ');
                }
              },
            ),
            SizedBox(
              width: 16,
            ),
            Container(
              decoration: BoxDecoration(color: active.withOpacity(.5), borderRadius: BorderRadius.circular(30)),
              child: Container(
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                padding: EdgeInsets.all(2),
                margin: EdgeInsets.all(2),
                child: CircleAvatar(
                  backgroundColor: light,
                  child: IconButton(
                    icon: Icon(Icons.person_outline),
                    color: dark,
                    onPressed: () {
                      menuController.changeActiveItemTo(myProfilePageDisplayName);
                      if (ResponsiveWidget.isSmallScreen(context)) Get.back();
                      navigationController.navigateTo(myProfilePageRoute);
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      iconTheme: IconThemeData(color: dark),
      elevation: 0,
      backgroundColor: Colors.transparent,
    );

class RadioRow extends StatefulWidget {
  const RadioRow({Key? key}) : super(key: key);

  @override
  _RadioRowState createState() => _RadioRowState();
}

class _RadioRowState extends State<RadioRow> {
  String _selectedRoleType = RoleType.getValue(0).translate();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      ListTile(
        title: Text(RoleType.admin.translate()),
        leading: Radio<String>(
          value: RoleType.admin.translate(),
          groupValue: _selectedRoleType,
          onChanged: (String? value) {
            setState(() {
              updateRoleInModel(value!, context);
              _selectedRoleType = value;
            });
          },
        ),
      ),
      ListTile(
        title: Text(RoleType.client.translate()),
        leading: Radio<String>(
          value: RoleType.client.translate(),
          groupValue: _selectedRoleType,
          onChanged: (String? value) {
            setState(() {
              updateRoleInModel(value!, context);
              _selectedRoleType = value;
            });
          },
        ),
      ),
      ListTile(
        title: Text(RoleType.company.translate()),
        leading: Radio<String>(
          value: RoleType.company.translate(),
          groupValue: _selectedRoleType,
          onChanged: (String? value) {
            setState(
              () {
                updateRoleInModel(value!, context);
                _selectedRoleType = value;
              },
            );
          },
        ),
      ),
    ]);
  }

  updateRoleInModel(String role, BuildContext context) {
    context.createUserBloc.add(
      CreateUserUpdateModelEvent(
        userModel: context.createUserBloc.state.userModel.copyWith(role: role),
      ),
    );
  }
}

class _NotificationBellWidget extends StatefulWidget {
  const _NotificationBellWidget({Key? key}) : super(key: key);

  @override
  _NotificationBellWidgetState createState() => _NotificationBellWidgetState();
}

class _NotificationBellWidgetState extends State<_NotificationBellWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationsBloc, NotificationsState>(
      listener: (context, state) {
        if (state.status == NotificationStateStatus.successfullyDeleted) {
          context.notificationsBloc.add(NotificationsLoadEvent(userId: context.currentUserBloc.state.userModel!.id));
        }
      },
      child: BlocBuilder<NotificationsBloc, NotificationsState>(
        builder: (context, state) {
          return Stack(
            children: [
              IconButton(
                  icon: Icon(
                    Icons.notifications,
                    color: dark.withOpacity(.7),
                  ),
                  onPressed: () {
                    _showOverlay(parentContext: context, state: state, onCloseDialog: () => context.notificationsBloc.add(NotificationsDeleteEvent(userId: context.currentUserBloc.state.userModel!.id)));
                  }),
              (() {
                if (state.status == NotificationStateStatus.loading) {
                  return Loader(
                    width: 10,
                    height: 10,
                    color: active,
                  );
                } else {
                  if (state.model.isNotEmpty) {
                    return Positioned(
                      top: 7,
                      right: 7,
                      child: Container(
                        width: 12,
                        height: 12,
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(color: active, borderRadius: BorderRadius.circular(30), border: Border.all(color: light, width: 2)),
                      ),
                    );
                  } else {
                    return SizedBox();
                  }
                }
              }()),
            ],
          );
        },
      ),
    );
  }

  void _showOverlay({required BuildContext parentContext, required NotificationsState state, required void Function() onCloseDialog}) async {
    OverlayState? overlayState = Overlay.of(parentContext);
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
          right: 70,
          top: 50,
          child: Container(
              width: 300,
              decoration: BoxDecoration(
                border: Border.all(
                  color: active,
                ),
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: (() {
                if (state.model.length == 0)
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                    child: Column(
                      children: [
                        CustomText(
                          text: 'No notifications',
                          textAlign: TextAlign.center,
                          weight: FontWeight.bold,
                          size: context.textSizeL,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Button(
                          child: CustomText(
                            text: 'Close',
                            size: 16,
                            color: active,
                          ),
                          textColor: active,
                          shrinkWrap: true,
                          onTap: () => overlayEntry.remove(),
                          color: Colors.transparent,
                        )
                      ],
                    ),
                  );
                else
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListView.builder(
                            itemCount: state.model.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              return Material(
                                child: ListTile(
                                  leading: Icon(Icons.notifications),
                                  title: CustomText(
                                    text: state.model[index].message,
                                    color: Colors.black,
                                    weight: FontWeight.normal,
                                    textAlign: TextAlign.center,
                                  ),
                                  minLeadingWidth: 10,
                                ),
                              );
                            }),
                        Builder(
                          builder: (context) {
                            return Button(
                              child: CustomText(
                                text: 'Close',
                                size: 16,
                                color: active,
                              ),
                              textColor: active,
                              shrinkWrap: true,
                              onTap: () {
                                onCloseDialog();
                                overlayEntry.remove();
                              },
                              color: Colors.transparent,
                            );
                          },
                        )
                      ],
                    ),
                  );
              }())));
    });

    // Inserting the OverlayEntry into the Overlay
    overlayState?.insert(overlayEntry);
  }
}
