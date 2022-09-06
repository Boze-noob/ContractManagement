import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';

class AnnouncementDataWidget extends StatelessWidget {
  final bool isEmpty;
  final AnnouncementModel announcementModel;

  AnnouncementDataWidget({
    Key? key,
    required this.isEmpty,
    required this.announcementModel,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: CustomText(
              text: 'Announcement data',
              size: context.textSizeXL,
              color: Colors.black,
              textAlign: TextAlign.center,
              weight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _dataRowWidget('Id: ' + announcementModel.id, context),
          SizedBox(
            height: 10,
          ),
          _dataRowWidget('Order id: ' + announcementModel.orderId, context),
          SizedBox(
            height: 10,
          ),
          _dataRowWidget('Receiver id: ' + announcementModel.receiverId.value, context),
          SizedBox(
            height: 10,
          ),
          _dataRowWidget('Receiver name: ' + announcementModel.receiverName.value, context),
          SizedBox(
            height: 10,
          ),
          _dataRowWidget(
              'Contract items: ' + announcementModel.contractItems.map((e) => e.translate()).toString(), context),
          SizedBox(
            height: 10,
          ),
          _dataRowWidget('Price: ' + announcementModel.price + ' KM', context),
          SizedBox(
            height: 10,
          ),
          _dataRowWidget('Created date time: ' + announcementModel.createdDateTime.toLocal().formatDDMMYY(), context),
          SizedBox(
            height: 10,
          ),
          _dataRowWidget(
              'Completion date time: ' + announcementModel.completionDateTime.toLocal().formatDDMMYY(), context),
          SizedBox(
            height: 10,
          ),
          _dataRowWidget('Employer name: ' + announcementModel.employerName, context),
          SizedBox(
            height: 10,
          ),
          _dataRowWidget('Status type: ' + announcementModel.announcementStatusType.translate(), context),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

Widget _dataRowWidget(String rowDataStr, BuildContext context) {
  return CustomText(
    text: rowDataStr,
    color: Colors.black,
    weight: FontWeight.normal,
    size: context.textSizeM,
  );
}
