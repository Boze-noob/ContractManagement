import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';
import 'package:intl/intl.dart';

class ContractsDataTableWidget extends StatelessWidget {
  final String firstColumnName;
  final String secondColumnName;
  final String thirdColumnName;
  final String fourthColumnName;
  final String fifthColumnName;
  final String action;
  final ContractsState contractsState;
  final void Function(ContractModel contractModel) onTap;

  ContractsDataTableWidget({
    Key? key,
    required this.firstColumnName,
    required this.secondColumnName,
    required this.thirdColumnName,
    required this.fourthColumnName,
    required this.fifthColumnName,
    required this.action,
    required this.contractsState,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (contractsState.contracts.isEmpty)
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
        dataRowHeight: context.screenHeight / 13,
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
          contractsState.contracts.length,
          (index) => DataRow(
            cells: [
              DataCell(
                CustomText(text: contractsState.contracts[index].companyName),
              ),
              DataCell(
                CustomText(text: contractsState.contracts[index].contractTemplateId),
              ),
              DataCell(
                CustomText(
                  text: contractsState.contracts[index].contractStatus.translate().toUpperCase(),
                ),
              ),
              DataCell(
                CustomText(
                  text: DateFormat('yyyy-MM-dd – kk:mm').format(contractsState.contracts[index].completionDateTime),
                ),
              ),
              DataCell(
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: GestureDetector(
                    onTap: () => onTap(contractsState.contracts[index]),
                    child: Container(
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
