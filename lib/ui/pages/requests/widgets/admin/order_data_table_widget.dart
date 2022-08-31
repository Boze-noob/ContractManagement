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
  final bool isEmpty;
  final List<OrderStatusType> isSent;
  final void Function(int index) sendBtnOnTap;
  final void Function(int index) createBtnOnTap;
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
    required this.isSent,
    required this.sendBtnOnTap,
    required this.createBtnOnTap,
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
          DataColumn2(
            label: Text(sixthColumnName),
            size: ColumnSize.L,
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
              DataCell((() {
                if (isSent[index].translate() == OrderStatusType.waiting.translate() &&
                    context.currentUserBloc.state.userModel!.role != RoleType.announcementEmployer.translate()) {
                  return Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Visibility(
                      visible: ResponsiveWidget.isLargeScreen(context),
                      child: Row(
                        children: [
                          Expanded(
                            child: Button(
                              text: 'Send',
                              textColor: active,
                              borderRadius: 20,
                              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                              borderColor: active,
                              onTap: () => sendBtnOnTap(index),
                            ),
                          ),
                          Expanded(
                            child: Button(
                              text: 'View',
                              textColor: active,
                              borderRadius: 20,
                              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                              borderColor: active,
                              onTap: () => viewBtnOnTap(index),
                            ),
                          ),
                          Expanded(
                            child: Button(
                              text: 'Edit',
                              textColor: Colors.lightBlueAccent,
                              borderRadius: 20,
                              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                              borderColor: active,
                              onTap: () => editBtnOnTap(index),
                            ),
                          ),
                          Expanded(
                            child: Button(
                              text: 'Delete',
                              textColor: Colors.red.withOpacity(0.5),
                              borderRadius: 20,
                              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                              borderColor: active,
                              onTap: () => deleteBtnOnTap(index),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else if (isSent[index].translate() != OrderStatusType.waiting.translate())
                  return Visibility(
                    visible: ResponsiveWidget.isLargeScreen(context),
                    child: Row(
                      children: [
                        Visibility(
                          visible: context.currentUserBloc.state.userModel!.role ==
                              RoleType.announcementEmployer.translate(),
                          child: Expanded(
                            child: Button(
                              text: 'Create',
                              textColor: active,
                              borderRadius: 20,
                              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                              borderColor: active,
                              //TOD add func
                              onTap: () => createBtnOnTap(index),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Button(
                            text: 'Delete',
                            textColor: active,
                            borderRadius: 20,
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                            borderColor: active,
                            //TOD add func
                            onTap: () => deleteBtnOnTap(index),
                          ),
                        ),
                      ],
                    ),
                  );
                else
                  return CustomText(
                    text: 'No actions allowed',
                    color: Colors.black,
                    weight: FontWeight.normal,
                    textAlign: TextAlign.center,
                  );
              }())),
            ],
          ),
        ),
      ),
    );
  }
}
