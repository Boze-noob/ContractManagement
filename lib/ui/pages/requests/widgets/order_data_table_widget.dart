import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';

//too much boilerplate code
class OrderDataTableWidget extends StatelessWidget {
  final String firstColumnName;
  final String secondColumnName;
  final String thirdColumnName;
  final String fourthColumnName;
  final String fifthColumnName;
  final String sixthColumnName;
  final List<String>? firstColumnValue;
  final List<String>? secondColumnValue;
  final List<String>? thirdColumnValue;
  final List<String>? fourthColumnValue;
  final List<String>? fifthColumnValue;
  final String viewBtnTxt;
  final String editBtnTxt;
  final String deleteBtnTxt;
  final bool isEmpty;
  final void Function(int index) viewBtnOnTap;
  final void Function(int index) editBtnOnTap;
  final void Function(int index) deleteBtnOnTap;

  OrderDataTableWidget({
    Key? key,
    required this.firstColumnName,
    required this.secondColumnName,
    required this.thirdColumnName,
    required this.fourthColumnName,
    required this.fifthColumnName,
    required this.sixthColumnName,
    this.firstColumnValue,
    this.secondColumnValue,
    this.thirdColumnValue,
    this.fourthColumnValue,
    this.fifthColumnValue,
    required this.isEmpty,
    required this.viewBtnTxt,
    required this.editBtnTxt,
    required this.deleteBtnTxt,
    required this.viewBtnOnTap,
    required this.editBtnOnTap,
    required this.deleteBtnOnTap,
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
          DataColumn(
            label: Text(sixthColumnName),
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
                CustomText(
                  text: fifthColumnValue![index],
                ),
              ),
              DataCell(Row(
                children: [
                  Button(
                    text: viewBtnTxt,
                    textColor: active,
                    borderRadius: 20,
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    borderColor: active,
                    //TOD add func
                    onTap: () => viewBtnOnTap(index),
                  ),
                  Button(
                    text: editBtnTxt,
                    textColor: Colors.lightBlueAccent,
                    borderRadius: 20,
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    borderColor: active,
                    onTap: () => editBtnOnTap(index),
                  ),
                  Button(
                    text: deleteBtnTxt,
                    textColor: Colors.red.withOpacity(0.5),
                    borderRadius: 20,
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    borderColor: active,
                    onTap: () => deleteBtnOnTap(index),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
