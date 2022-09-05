import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';

class CompanyOrderDataTableWidget extends StatelessWidget {
  final bool isEmpty;
  final void Function(int index) viewBtnOnTap;
  final void Function(int index) respondBtnOnTap;
  final List<OrderModel> orderModels;

  CompanyOrderDataTableWidget({
    Key? key,
    required this.isEmpty,
    required this.viewBtnOnTap,
    required this.respondBtnOnTap,
    required this.orderModels,
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
            label: Text('Employer name'),
            size: ColumnSize.L,
          ),
          DataColumn(
            label: Text('Location'),
          ),
          DataColumn(
            label: Text('Order status type'),
          ),
          DataColumn(
            label: Text('Price'),
          ),
          DataColumn(
            label: Text('Date time'),
          ),
          DataColumn2(
            label: Text(' '),
            size: ColumnSize.L,
          ),
        ],
        rows: List<DataRow>.generate(
          orderModels.length,
          (index) => DataRow(
            onSelectChanged: (isSelected) => viewBtnOnTap(index),
            cells: [
              DataCell(
                CustomText(text: orderModels[index].employerName),
              ),
              DataCell(
                CustomText(text: orderModels[index].orderLocation),
              ),
              DataCell(
                CustomText(
                  text: orderModels[index].orderStatusType.translate(),
                ),
              ),
              DataCell(
                CustomText(
                  text: orderModels[index].price + '\$',
                ),
              ),
              DataCell(
                CustomText(
                  text: orderModels[index].sentDateTime != null
                      ? orderModels[index].sentDateTime!.toLocal().formatDDMMYY()
                      : 'Not defined',
                ),
              ),
              DataCell(
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Visibility(
                    visible: !ResponsiveWidget.isSmallScreen(context),
                    child: Row(
                      children: [
                        (() {
                          if (orderModels[index].orderStatusType.translate() == OrderStatusType.declined.translate() ||
                              orderModels[index].orderStatusType.translate() == OrderStatusType.accepted.translate())
                            return SizedBox();
                          else
                            return Expanded(
                              child: Button(
                                text: 'Response',
                                textColor: active,
                                borderRadius: 20,
                                padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                                borderColor: active,
                                onTap: () => respondBtnOnTap(index),
                              ),
                            );
                        }())
                      ],
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
