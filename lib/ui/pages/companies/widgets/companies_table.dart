import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';

class CompaniesTable extends StatelessWidget {
  //Not good practice
  final BuildContext parentContext;

  CompaniesTable({required this.parentContext});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompaniesBloc, CompaniesState>(
      builder: (context, state) {
        if (state.status == CompaniesStateStatus.loading)
          return Center(
            child: Loader(
              width: 100,
              height: 100,
              color: active,
            ),
          );
        else if (state.companies.isNotEmpty) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: active.withOpacity(.4), width: .5),
              boxShadow: [BoxShadow(offset: Offset(0, 6), color: lightGrey.withOpacity(.1), blurRadius: 12)],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 30),
            child: DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 700,
              columns: [
                DataColumn2(
                  label: Text("Name"),
                  size: ColumnSize.L,
                ),
                DataColumn(
                  label: Text('Location'),
                ),
                DataColumn(
                  label: Text('Rating'),
                ),
                DataColumn2(
                  label: Text(' '),
                  size: ColumnSize.L,
                ),
              ],
              rows: List<DataRow>.generate(
                state.companies.length,
                (index) => DataRow(cells: [
                  DataCell(
                    CustomText(
                      text: state.companies[index].displayName,
                    ),
                  ),
                  DataCell(
                    CustomText(text: state.companies[index].location ?? ' '),
                  ),
                  DataCell(Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.deepOrange,
                        size: 18,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CustomText(
                        text: state.companies[index].rating ?? ' ',
                      )
                    ],
                  )),
                  DataCell(Row(
                    children: [
                      Button(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                        child: CustomText(
                          text: 'View',
                        ),
                        textColor: black,
                        shrinkWrap: true,
                        borderRadius: 40,
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => CustomDialog(
                            buttonText: 'Close',
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 55),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomText(
                                    text: 'Company details',
                                    size: context.textSizeXL,
                                    weight: FontWeight.bold,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CustomText(
                                    text: 'Display name: ' + state.companies[index].displayName,
                                    size: context.textSizeM,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  CustomText(
                                    text: 'Email: ' + state.companies[index].email,
                                    size: context.textSizeM,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  CustomText(
                                    text: 'Role: ' + state.companies[index].role,
                                    size: context.textSizeM,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  CustomText(
                                    text: 'Phone number: ' + state.companies[index].phoneNumber.value,
                                    size: context.textSizeM,
                                  ),
                                  CustomText(
                                    text: 'Signed contract: ' + state.companies[index].contractId.value,
                                    size: context.textSizeM,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Button(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                        child: CustomText(
                          text: 'Edit',
                          color: active,
                        ),
                        shrinkWrap: true,
                        borderRadius: 40,
                        //TODO update doesn't work properly
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => BlocProvider(
                            create: (context) => CompanyEditBloc(companiesRepo: context.serviceProvider.companiesRepo)
                              ..add(CompanyEditInitEvent(companyModel: state.companies[index])),
                            child: Builder(
                              builder: (context) {
                                return CustomDialog(
                                    buttonText: 'Save',
                                    child: Container(
                                      width: context.screenWidth / 2,
                                      child: Form(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 30),
                                          child: BlocListener<CompanyEditBloc, CompanyEditState>(
                                            listener: (context, state) {
                                              if (state.status == CompanyEditStateStatus.error) {
                                                showInfoMessage(state.errorMessage ?? 'Error happen', context);
                                              } else if (state.status == CompanyEditStateStatus.submittedSuccessfully) {
                                                showInfoMessage('Company updated', context);
                                                parentContext.companiesBloc.add(CompaniesGetEvent());
                                              }
                                            },
                                            child: BlocBuilder<CompanyEditBloc, CompanyEditState>(
                                              builder: (context, state) {
                                                if (state.status == CompanyEditStateStatus.loading)
                                                  return Loader(
                                                    width: 80,
                                                    height: 80,
                                                    color: active,
                                                  );
                                                return Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    CustomText(
                                                      text: 'Edit company parameters',
                                                      size: 22,
                                                      weight: FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                    SizedBox(
                                                      height: 16,
                                                    ),
                                                    TextFormField(
                                                      initialValue: state.companyModel.displayName,
                                                      decoration: InputDecoration(
                                                        icon: const Icon(Icons.email),
                                                        hintText: 'Edit displayName',
                                                        labelText: 'Display name',
                                                        fillColor: active,
                                                      ),
                                                      onChanged: (text) => context.companyEditBloc.add(
                                                        CompanyEditUpdateEvent(
                                                          companyModel: state.companyModel.copyWith(displayName: text),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextFormField(
                                                      initialValue: state.companyModel.rating,
                                                      decoration: const InputDecoration(
                                                        icon: const Icon(Icons.password),
                                                        hintText: 'Edit rating',
                                                        labelText: 'Rating',
                                                      ),
                                                      onChanged: (text) => context.companyEditBloc.add(
                                                        CompanyEditUpdateEvent(
                                                          companyModel: state.companyModel.copyWith(rating: text),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    _RoleWidget(
                                                      onRoleUpdate: (role) => context.companyEditBloc.add(
                                                        CompanyEditUpdateEvent(
                                                          companyModel: state.companyModel.copyWith(role: role),
                                                        ),
                                                      ),
                                                      role: state.companyModel.role,
                                                    ),
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
                                      context.companyEditBloc.add(CompanyEditSubmitEvent());
                                    });
                              },
                            ),
                          ),
                        ),
                      ),
                      Button(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 7),
                        child: CustomText(
                          text: 'Delete',
                          color: delete,
                        ),
                        shrinkWrap: true,
                        borderRadius: 40,
                        onTap: () => context.companiesBloc.add(
                          CompaniesDeleteEvent(uid: state.companies[index].id),
                        ),
                      ),
                    ],
                  )),
                ]),
              ),
            ),
          );
        }
        return Container(
          child: CustomText(
            text: 'No companies yet',
            size: context.textSizeXL,
            weight: FontWeight.bold,
          ),
        );
      },
    );
  }
}

class _RoleWidget extends StatefulWidget {
  final void Function(String role) onRoleUpdate;
  final String role;

  _RoleWidget({required this.role, required this.onRoleUpdate}) : super();

  @override
  _RoleWidgetState createState() => _RoleWidgetState();
}

class _RoleWidgetState extends State<_RoleWidget> {
  late String _selectedRoleType;

  @override
  Widget build(BuildContext context) {
    _selectedRoleType = widget.role;
    return Column(mainAxisSize: MainAxisSize.min, children: [
      //It would be nice to do this via List.builder
      ListTile(
        title: Text(RoleType.client.translate()),
        leading: Radio<String>(
          value: RoleType.client.translate(),
          groupValue: _selectedRoleType,
          onChanged: (String? value) {
            widget.onRoleUpdate(value!);
            setState(() {
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
            widget.onRoleUpdate(value!);
            setState(
              () {
                _selectedRoleType = value;
              },
            );
          },
        ),
      ),
    ]);
  }
}
