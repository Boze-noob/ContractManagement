import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ViewAnnouncementDialog extends StatelessWidget {
  AnnouncementModel announcementModel;
  ViewAnnouncementDialog({Key? key, required this.announcementModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      buttonText: 'Close',
      title: 'Announcement details',
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Id: ${announcementModel.id.value}',
                weight: FontWeight.normal,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: 'Order id: ${announcementModel.orderId.value}',
                weight: FontWeight.normal,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: 'Receiver id: ${announcementModel.receiverId.value}',
                weight: FontWeight.normal,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: 'Receiver name: ${announcementModel.receiverName.value}',
                weight: FontWeight.normal,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: 'Create date time: ${announcementModel.createdDateTime.formatDDMMYY().value}',
                weight: FontWeight.normal,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: 'Completion date time: ${announcementModel.completionDateTime.formatDDMMYY().value}',
                weight: FontWeight.normal,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: 'Price: ${announcementModel.price.value}',
                weight: FontWeight.normal,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: 'Status type: ${announcementModel.announcementStatusType.translate()}',
                weight: FontWeight.normal,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              (() {
                if (announcementModel.announcementStatusType.translate() == AnnouncementStatusType.declined.translate())
                  return CustomText(
                    text: 'Comment: ${announcementModel.declineComment.value}',
                    weight: FontWeight.normal,
                    color: Colors.black,
                  );
                else
                  return SizedBox();
              }()),
              Divider(
                color: Colors.black12.withOpacity(0.6),
              ),
              CustomText(text: 'Contract items:'),
              SizedBox(
                height: 5,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: announcementModel.contractItems.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(' - ' + announcementModel.contractItems[i].translate()),
                  );
                },
              ),
              Divider(
                color: Colors.black12.withOpacity(0.6),
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: 'Employer name: ${announcementModel.employerName.value}',
                weight: FontWeight.normal,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
