import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CompanyViewAnnouncementDialog extends StatelessWidget {
  AnnouncementModel announcementModel;
  CompanyViewAnnouncementDialog({Key? key, required this.announcementModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      buttonText: 'Close',
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: CustomText(
                  text: 'Announcement details',
                  weight: FontWeight.bold,
                  size: context.textSizeXL,
                  color: Colors.black,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 18,
              ),
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
                text:
                    'Create date time: ${announcementModel.createdDateTime.formatDDMMYY().value}',
                weight: FontWeight.normal,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text:
                    'Completion date time: ${announcementModel.completionDateTime.formatDDMMYY().value}',
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
                text:
                    'Status type: ${announcementModel.announcementStatusType.translate()}',
                weight: FontWeight.normal,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
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
                    title: Text(
                        ' - ' + announcementModel.contractItems[i].translate()),
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
