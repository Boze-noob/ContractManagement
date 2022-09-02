import 'package:collection/collection.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';

class CompaniesTable extends StatelessWidget {
  final Function(String message, bool successfulFlag) onEdited;

  CompaniesTable({
    required this.onEdited,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompanyEditBloc(companiesRepo: context.serviceProvider.companiesRepo),
      child: BlocBuilder<CompanyEditBloc, CompanyEditState>(
        builder: (context, companyEditState) {
          return BlocBuilder<CompaniesBloc, CompaniesState>(
            builder: (context, state) {
              if (state.status == CompaniesStateStatus.loading ||
                  companyEditState.status == CompanyEditStateStatus.submittedSuccessfully)
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
                    dataRowHeight: context.screenHeight / 13,
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
                        DataCell(Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.visibility,
                                  color: active,
                                ),
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) => CustomDialog(
                                    buttonText: 'Close',
                                    title: 'Company details',
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 55),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CustomText(
                                            text: 'Display name: ' + state.companies[index].displayName,
                                            size: context.textSizeL,
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          CustomText(
                                            text: 'Email: ' + state.companies[index].email,
                                            size: context.textSizeL,
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          CustomText(
                                            text: 'Role: ' + state.companies[index].role,
                                            size: context.textSizeL,
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          CustomText(
                                            text: 'Phone number: ' + state.companies[index].phoneNumber.value,
                                            size: context.textSizeL,
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          CustomText(
                                            text: 'Signed contract: ' + state.companies[index].contractId.value,
                                            size: context.textSizeL,
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
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) => BlocProvider(
                                    create: (context) =>
                                        CompanyEditBloc(companiesRepo: context.serviceProvider.companiesRepo)
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
                                                      onEdited('Error happen', false);
                                                    } else if (state.status ==
                                                        CompanyEditStateStatus.submittedSuccessfully) {
                                                      print("Submit success");
                                                      onEdited('Company updated', true);
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
                                                                companyModel:
                                                                    state.companyModel.copyWith(displayName: text),
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
                                          },
                                          title: 'Edit company parameters',
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: context.appTheme.danger,
                                ),
                                onPressed: () => context.companiesBloc.add(
                                  CompaniesDeleteEvent(companyId: state.companies[index].id),
                                ),
                              ),
                              BlocBuilder<ContractsBloc, ContractsState>(
                                builder: (context, contractsState) {
                                  print("Company id is" + state.companies[index].id.toString());
                                  print(contractsState.status.toString());
                                  print(contractsState.contracts.toString());
                                  contractsState.contracts.forEach((contract) {
                                    print("Contract is " + contract.companyId);
                                  });
                                  ContractModel? contractModel = contractsState.contracts.firstWhereOrNull(
                                    (contract) => contract.companyId == state.companies[index].id,
                                  );
                                  return IconButton(
                                    icon: Icon(Icons.description),
                                    onPressed: () => contractModel == null
                                        ? showInfoMessage("Company did not sign contract yet", context)
                                        : showDialog(
                                            context: context,
                                            builder: (context) => ContractDialog(
                                              createContractModel: contractsState.templates.firstWhere((template) =>
                                                  template.contractName == contractModel.contractTemplateId),
                                              contractModel: contractModel,
                                            ),
                                          ),
                                  );
                                },
                              )
                            ],
                          ),
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
        },
      ),
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
