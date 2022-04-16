import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';

class AnnouncementDataTableWidget extends StatelessWidget {
  final bool isEmpty;
  final void Function(int index) viewBtnOnTap;
  final void Function(int index) sendBtnOnTap;
  final void Function(int index) deleteBtnOnTap;
  final void Function(int index) inspectOnTap;
  final List<AnnouncementModel> announcementsModels;

  AnnouncementDataTableWidget({
    Key? key,
    required this.isEmpty,
    required this.viewBtnOnTap,
    required this.sendBtnOnTap,
    required this.deleteBtnOnTap,
    required this.inspectOnTap,
    required this.announcementsModels,
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
            label: Text('Order id'),
            size: ColumnSize.L,
          ),
          DataColumn(
            label: Text('Receiver name'),
          ),
          DataColumn(
            label: Text('Employer name'),
          ),
          DataColumn(
            label: Text('Price'),
          ),
          DataColumn(
            label: Text('Date time'),
          ),
          DataColumn(
            label: Text('Status type'),
          ),
          DataColumn2(
            label: Text(' '),
            size: ColumnSize.L,
          ),
        ],
        rows: List<DataRow>.generate(
          announcementsModels.length,
          (index) => DataRow(
            color: MaterialStateProperty.all(
              _getRowColor(
                announcementsModels[index].announcementStatusType,
              ),
            ),
            cells: [
              DataCell(
                CustomText(text: announcementsModels[index].orderId),
              ),
              DataCell(
                CustomText(text: announcementsModels[index].receiverName),
              ),
              DataCell(
                CustomText(
                  text: announcementsModels[index].employerName,
                ),
              ),
              DataCell(
                CustomText(
                  text: announcementsModels[index].price + '\$',
                ),
              ),
              DataCell(
                CustomText(
                  text: announcementsModels[index].createdDateTime.toLocal().formatDDMMYY(),
                ),
              ),
              DataCell(
                CustomText(
                  text: announcementsModels[index].announcementStatusType.translate(),
                ),
              ),
              DataCell(
                Row(
                  children: [
                    (() {
                      if (announcementsModels[index].announcementStatusType.translate() ==
                          AnnouncementStatusType.done.translate())
                        return Expanded(
                          child: Button(
                            text: 'Inspect',
                            textColor: active,
                            borderRadius: 20,
                            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                            borderColor: active,
                            onTap: () => inspectOnTap(index),
                          ),
                        );
                      return Expanded(
                        child: Button(
                          text: 'View',
                          textColor: active,
                          borderRadius: 20,
                          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                          borderColor: active,
                          onTap: () => viewBtnOnTap(index),
                        ),
                      );
                    }()),
                    Visibility(
                      visible: announcementsModels[index].announcementStatusType.translate() ==
                          AnnouncementStatusType.waiting.translate(),
                      child: Expanded(
                        child: Button(
                          text: 'Send',
                          textColor: active,
                          borderRadius: 20,
                          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                          borderColor: active,
                          onTap: () => sendBtnOnTap(index),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: announcementsModels[index].announcementStatusType.translate() ==
                              AnnouncementStatusType.waiting.translate() ||
                          announcementsModels[index].announcementStatusType.translate() ==
                              AnnouncementStatusType.approved.translate() ||
                          announcementsModels[index].announcementStatusType.translate() ==
                              AnnouncementStatusType.declined.translate(),
                      child: Expanded(
                        child: Button(
                          text: 'Delete',
                          textColor: active,
                          borderRadius: 20,
                          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                          borderColor: active,
                          onTap: () => deleteBtnOnTap(index),
                        ),
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

  Color _getRowColor(AnnouncementStatusType status) {
    switch (status.index) {
      case 3:
        return Colors.yellow.withOpacity(0.8);
      case 4:
        return Colors.green.withOpacity(0.8);
      default:
        return Colors.transparent;
    }
  }
}
