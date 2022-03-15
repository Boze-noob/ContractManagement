import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';

class RequestsDataTableWidget extends StatelessWidget {
  final String firstColumnName;
  final String secondColumnName;
  final String thirdColumnName;
  final String fourthColumnName;
  final String fifthColumnName;
  final String action;
  final List<ClientRequestModel> clientRequestsList;

  RequestsDataTableWidget({
    Key? key,
    required this.firstColumnName,
    required this.secondColumnName,
    required this.thirdColumnName,
    required this.fourthColumnName,
    required this.fifthColumnName,
    required this.action,
    required this.clientRequestsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (clientRequestsList.isEmpty)
      return CustomText(
        text: 'No data to display',
        size: context.textSizeXL,
        color: Colors.black,
        weight: FontWeight.bold,
      );
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
        minWidth: 600,
        columns: [
          DataColumn2(
            label: Text(firstColumnName),
            size: ColumnSize.L,
          ),
          DataColumn(
            label: Text(secondColumnName),
          ),
          DataColumn(
            label: Text(thirdColumnName),
          ),
          DataColumn(
            label: Text(fourthColumnName),
          ),
          DataColumn(
            label: Text(fifthColumnName),
          ),
        ],
        rows: List<DataRow>.generate(
          clientRequestsList.length,
          (index) => DataRow(
            cells: [
              DataCell(
                CustomText(text: clientRequestsList[index].displayName),
              ),
              DataCell(
                CustomText(text: clientRequestsList[index].email),
              ),
              DataCell(
                CustomText(
                  text: clientRequestsList[index].location,
                ),
              ),
              DataCell(
                CustomText(
                  text: clientRequestsList[index].createdDateTime.toLocal().toString(),
                ),
              ),
              DataCell(
                Container(
                  decoration: BoxDecoration(
                    color: light,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: active, width: .5),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: CustomText(
                    text: action,
                    color: active.withOpacity(.7),
                    weight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
