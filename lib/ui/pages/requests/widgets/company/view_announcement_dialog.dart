import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CompanyViewAnnouncementDialog extends StatelessWidget {
  AnnouncementModel announcementModel;
  CompanyViewAnnouncementDialog({Key? key, required this.announcementModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      buttonText: 'Close',
      title: 'Announcement details',
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Flex(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            direction: ResponsiveWidget.isSmallScreen(context) ? Axis.vertical : Axis.horizontal,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Receiver name: ${announcementModel.receiverName.value}',
                      weight: FontWeight.normal,
                      color: Colors.black,
                      size: 18,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: 'Employer name: ${announcementModel.employerName.value}',
                      weight: FontWeight.normal,
                      color: Colors.black,
                      size: 18,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: 'Create date time: ${announcementModel.createdDateTime.formatDDMMYY().value}',
                      weight: FontWeight.normal,
                      color: Colors.black,
                      size: 18,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Completion date time: ${announcementModel.completionDateTime.formatDDMMYY().value}',
                      weight: FontWeight.normal,
                      color: Colors.black,
                      size: 18,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: 'Price: ${announcementModel.price.value} KM',
                      weight: FontWeight.normal,
                      color: Colors.black,
                      size: 18,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: 'Status type: ${announcementModel.announcementStatusType.translate()}',
                      weight: FontWeight.normal,
                      color: Colors.black,
                      size: 18,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    (() {
                      if (announcementModel.announcementStatusType.translate() ==
                          AnnouncementStatusType.declined.translate())
                        return CustomText(
                          text: 'Comment: ${announcementModel.declineComment.value}',
                          weight: FontWeight.normal,
                          color: Colors.black,
                          size: 18,
                        );
                      else
                        return SizedBox();
                    }()),
                    CustomText(
                      text: 'Contract items:',
                      size: 18,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: announcementModel.contractItems.length,
                      itemBuilder: (context, i) {
                        return ListTile(
                          title: CustomText(
                            text: ' - ' + announcementModel.contractItems[i].translate(),
                            size: 18,
                          ),
                        );
                      },
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
}
