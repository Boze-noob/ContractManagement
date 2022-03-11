import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';

class CompaniesTable extends StatelessWidget {
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
                DataColumn(
                  label: Text(' '),
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
                                    text: 'Phone number: ',
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
                      SizedBox(
                        width: 10,
                      ),
                      //TODO add edit
                      Button(
                        child: CustomText(
                          text: 'Edit',
                          color: active,
                        ),
                        shrinkWrap: true,
                        borderRadius: 40,
                        onTap: () => showDialog(
                          context: context,
                          builder: (context) => CustomDialog(
                            buttonText: 'Save',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Button(
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
