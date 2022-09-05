import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';

class CompanyAnnouncementDataTableWidget extends StatelessWidget {
  final bool isEmpty;
  final void Function(int index) viewBtnOnTap;
  final void Function(int index) inProgressBtnOnTap;
  final void Function(int index) doneBtnOnTap;
  final List<AnnouncementModel> announcementsModels;

  CompanyAnnouncementDataTableWidget({
    Key? key,
    required this.isEmpty,
    required this.viewBtnOnTap,
    required this.inProgressBtnOnTap,
    required this.doneBtnOnTap,
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
        dataRowHeight: context.screenHeight / 13,
        showCheckboxColumn: false,
        columns: [
          DataColumn2(
            label: Text('Order id'),
            size: ColumnSize.L,
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
            onSelectChanged: (isSelected) => viewBtnOnTap(index),
            color: MaterialStateProperty.all(announcementsModels[index].announcementStatusType.translate() ==
                    AnnouncementStatusType.declined.translate()
                ? Colors.red
                : Colors.transparent),
            cells: [
              DataCell(
                CustomText(text: announcementsModels[index].orderId),
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
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Visibility(
                    visible: !ResponsiveWidget.isSmallScreen(context),
                    child: Row(
                      children: [
                        Visibility(
                          visible: announcementsModels[index].announcementStatusType.translate() !=
                                  AnnouncementStatusType.inProgress.translate() &&
                              announcementsModels[index].announcementStatusType.translate() !=
                                  AnnouncementStatusType.approved.translate(),
                          child: Expanded(
                            child: Button(
                              text: 'In progress',
                              textColor: active,
                              borderRadius: 20,
                              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                              borderColor: active,
                              onTap: () => inProgressBtnOnTap(index),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: announcementsModels[index].announcementStatusType.translate() ==
                                  AnnouncementStatusType.inProgress.translate() ||
                              announcementsModels[index].announcementStatusType.translate() ==
                                  AnnouncementStatusType.declined.translate(),
                          child: Expanded(
                            child: Button(
                              text: 'Done',
                              textColor: active,
                              borderRadius: 20,
                              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                              borderColor: active,
                              onTap: () => doneBtnOnTap(index),
                            ),
                          ),
                        ),
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
