import 'package:contract_management/_all.dart';
import 'package:contract_management/common/enumerations/role_type.dart';
import 'package:contract_management/ui/pages/companies/widgets/companies_table.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CompaniesPage extends StatefulWidget {
  CompaniesPage({Key? key}) : super(key: key);

  @override
  State<CompaniesPage> createState() => _CompaniesPageState();
}

class _CompaniesPageState extends State<CompaniesPage> {
  //TODO potrebno validaciju odradit
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Obx(
            () => Row(
              children: [
                Container(
                    margin: EdgeInsets.only(top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                    child: CustomText(
                      text: menuController.activeItem.value,
                      size: 24,
                      weight: FontWeight.bold,
                    )),
              ],
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  Expanded(
                    child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: Button(
                          text: 'Add company',
                          shrinkWrap: true,
                          textColor: Color(Colors.white.value),
                          color: active,
                          onTap: () => showDialog(
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
                          ),
                        ),
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CompaniesTable(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
