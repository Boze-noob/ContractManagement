import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';

class DataTableWidget extends StatelessWidget {
  final String firstColumnName;
  final String secondColumnName;
  final String thirdColumnName;
  final String fourthColumnName;
  final String action;
  //TODO not good practice to do it this way
  final List dataList;

  DataTableWidget({
    Key? key,
    required this.firstColumnName,
    required this.secondColumnName,
    required this.thirdColumnName,
    required this.fourthColumnName,
    required this.action,
    required this.dataList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (dataList.isEmpty)
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
        ],
        rows: List<DataRow>.generate(
          dataList.length,
          (index) => DataRow(
            cells: [
              DataCell(
                CustomText(text: dataList[index].companyName),
              ),
              DataCell(
                CustomText(text: dataList[index].contractTemplateId),
              ),
              DataCell(
                CustomText(
                  text: dataList[index].contractStatus.translate(),
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
