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
        dataRowHeight: context.screenHeight / 13,
        showCheckboxColumn: false,
        columns: [
          DataColumn2(
            label: CustomText(text: 'Receiver'),
            size: ColumnSize.L,
            tooltip: "Name of company who received announcement",
          ),
          DataColumn(
            label: CustomText(text: 'Employer'),
            tooltip: "Employer which created announcement",
          ),
          DataColumn(
            label: CustomText(text: 'Price'),
          ),
          DataColumn(
            label: CustomText(text: 'Date time'),
            tooltip: "Date when announcement is created",
          ),
          DataColumn(
            label: CustomText(text: 'Status'),
            tooltip: "Status of the announcement",
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
            color: MaterialStateProperty.all(
              _getRowColor(
                announcementsModels[index].announcementStatusType,
              ),
            ),
            cells: [
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
                  text: announcementsModels[index].price + ' KM',
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
                Visibility(
                  visible: ResponsiveWidget.isLargeScreen(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      (() {
                        if (announcementsModels[index].announcementStatusType.translate() ==
                            AnnouncementStatusType.done.translate())
                          return IconButton(
                            icon: Icon(
                              Icons.zoom_in,
                              color: active,
                            ),
                            onPressed: () => inspectOnTap(index),
                          );
                        else
                          return SizedBox();
                      }()),
                      Visibility(
                        visible: announcementsModels[index].announcementStatusType.translate() ==
                                AnnouncementStatusType.waiting.translate() &&
                            context.currentUserBloc.state.userModel!.role != RoleType.announcementEmployer.translate(),
                        child: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: active,
                          ),
                          onPressed: () => sendBtnOnTap(index),
                        ),
                      ),
                      Visibility(
                        visible: announcementsModels[index].announcementStatusType.translate() ==
                                AnnouncementStatusType.waiting.translate() ||
                            announcementsModels[index].announcementStatusType.translate() ==
                                AnnouncementStatusType.approved.translate() ||
                            announcementsModels[index].announcementStatusType.translate() ==
                                AnnouncementStatusType.declined.translate(),
                        child: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: context.appTheme.danger,
                          ),
                          onPressed: () => deleteBtnOnTap(index),
                        ),
                      ),
                    ],
                  ),
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
