import 'dart:ui';

import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

class AnnouncementDonePage extends StatefulWidget {
  const AnnouncementDonePage({Key? key}) : super(key: key);

  @override
  _AnnouncementDonePageState createState() => _AnnouncementDonePageState();
}

class _AnnouncementDonePageState extends State<AnnouncementDonePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 20),
          children: [
            Align(
              alignment: Alignment.center,
              child: CustomText(
                text: 'Announcement inspect',
                color: Colors.black,
                size: context.textSizeXXL,
                weight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            AnnouncementDataWidget(isEmpty: false),
            BillDataWidget(
              isEmpty: false,
              billModel: BillModel(
                price: '120',
                additionalReqPrice: '50',
                announcementId: '12',
                id: '15',
              ),
            ),
            WorkDiaryDataWidget(
              isEmpty: false,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Button(
                  text: 'Decline',
                  shrinkWrap: true,
                  onTap: () => null,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 20,
                ),
                Button(
                  text: 'Approve',
                  shrinkWrap: true,
                  onTap: () => null,
                  color: active,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
