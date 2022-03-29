import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';

//TODO we will need to change properties so that they are more flexible
class RequestsDataTableWidget extends StatelessWidget {
  final String firstColumnName;
  final String secondColumnName;
  final String thirdColumnName;
  final String fourthColumnName;
  final String fifthColumnName;
  final List<String>? firstColumnValue;
  final List<String>? secondColumnValue;
  final List<String>? thirdColumnValue;
  final List<String>? fourthColumnValue;
  final List<String>? fifthColumnValue;
  final String? actionBtnTxt;
  final bool isEmpty;

  RequestsDataTableWidget({
    Key? key,
    required this.firstColumnName,
    required this.secondColumnName,
    required this.thirdColumnName,
    required this.fourthColumnName,
    required this.fifthColumnName,
    this.firstColumnValue,
    this.secondColumnValue,
    this.thirdColumnValue,
    this.fourthColumnValue,
    this.fifthColumnValue,
    required this.isEmpty,
    this.actionBtnTxt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isEmpty)
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
          firstColumnValue!.length,
          (index) => DataRow(
            cells: [
              DataCell(
                CustomText(text: firstColumnValue![index]),
              ),
              DataCell(
                CustomText(text: secondColumnValue![index]),
              ),
              DataCell(
                CustomText(
                  text: thirdColumnValue![index],
                ),
              ),
              DataCell(
                CustomText(
                  text: fourthColumnValue![index],
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
                    text: actionBtnTxt ?? 'Action',
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
