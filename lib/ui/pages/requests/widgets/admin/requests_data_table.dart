import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';

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
  final void Function(int index) createOnTap;
  final void Function(int index) viewOnTap;

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
    required this.createOnTap,
    required this.viewOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isEmpty)
      return Container(
        width: 600,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: active.withOpacity(.4), width: .5),
          boxShadow: [BoxShadow(offset: Offset(0, 6), color: lightGrey.withOpacity(.1), blurRadius: 12)],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 30),
        child: Center(
          child: CustomText(
            text: 'No data to display',
            size: context.textSizeXL,
            color: Colors.black,
            textAlign: TextAlign.center,
            weight: FontWeight.bold,
          ),
        ),
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
        dataRowHeight: context.screenHeight / 13,
        showCheckboxColumn: false,
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
            onSelectChanged: (isSelected) => viewOnTap(index),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Visibility(
                      visible: ResponsiveWidget.isLargeScreen(context),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => createOnTap(index),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
