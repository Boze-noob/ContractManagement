import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';

/// Example without datasource
class AvailableCompaniesTable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompaniesBloc(companiesRepo: context.serviceProvider.companiesRepo)..add(CompaniesGetEvent()),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: active.withOpacity(.4), width: .5),
          boxShadow: [BoxShadow(offset: Offset(0, 6), color: lightGrey.withOpacity(.1), blurRadius: 12)],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                CustomText(
                  text: "Available Companies",
                  color: lightGrey,
                  weight: FontWeight.bold,
                ),
              ],
            ),
            BlocBuilder<CompaniesBloc, CompaniesState>(
              builder: (context, state) {
                return DataTable2(
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: 600,
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
                      label: Text('Action'),
                    ),
                  ],
                  rows: List<DataRow>.generate(
                    state.companies.length,
                    (index) => DataRow(
                      cells: [
                        DataCell(CustomText(text: state.companies[index].displayName)),
                        DataCell(CustomText(text: state.companies[index].location)),
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
                              text: state.companies[index].rating,
                            )
                          ],
                        )),
                        DataCell(Container(
                            decoration: BoxDecoration(
                              color: light,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: active, width: .5),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            child: CustomText(
                              text: "Send contract",
                              color: active.withOpacity(.7),
                              weight: FontWeight.bold,
                            ))),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
