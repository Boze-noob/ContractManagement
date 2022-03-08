import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';

import '../../common/enumerations/role_type.dart';

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
            IconButton(
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
            IconButton(
                icon: Icon(
                  Icons.settings,
                  color: dark,
                ),
                onPressed: () {}),
            Stack(
              children: [
                IconButton(
                    icon: Icon(
                      Icons.notifications,
                      color: dark.withOpacity(.7),
                    ),
                    onPressed: () {}),
                Positioned(
                  top: 7,
                  right: 7,
                  child: Container(
                    width: 12,
                    height: 12,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(color: active, borderRadius: BorderRadius.circular(30), border: Border.all(color: light, width: 2)),
                  ),
                )
              ],
            ),
            Container(
              width: 1,
              height: 22,
              color: lightGrey,
            ),
            SizedBox(
              width: 24,
            ),
            CustomText(
              text: "Daniel Buhač",
              color: lightGrey,
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
                  child: Icon(
                    Icons.person_outline,
                    color: dark,
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
