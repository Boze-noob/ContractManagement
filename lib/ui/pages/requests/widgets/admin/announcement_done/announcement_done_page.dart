import 'dart:ui';
import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnnouncementDonePage extends StatefulWidget {
  final AnnouncementModel announcementModel;
  final Function(String declineComment) announcementDeclineOnTap;
  final Function() announcementApprovedOnTap;
  const AnnouncementDonePage({
    Key? key,
    required this.announcementModel,
    required this.announcementDeclineOnTap,
    required this.announcementApprovedOnTap,
  }) : super(key: key);

  @override
  _AnnouncementDonePageState createState() => _AnnouncementDonePageState();
}

class _AnnouncementDonePageState extends State<AnnouncementDonePage> {
  final TextEditingController declineTextEditingController = TextEditingController();
  final TextEditingController approveTextEditingController = TextEditingController();

  @override
  void dispose() {
    declineTextEditingController.dispose();
    approveTextEditingController.dispose();
    super.dispose();
  }

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
            AnnouncementDataWidget(
              isEmpty: false,
              announcementModel: widget.announcementModel,
            ),
            BillDataWidget(
              isEmpty: false,
              announcementId: widget.announcementModel.id,
            ),
            WorkDiaryDataWidget(
              isEmpty: false,
              announcementId: widget.announcementModel.id,
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
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => CustomDialog(
                      buttonText: 'Send',
                      onButtonPressed: () async {
                        widget.announcementDeclineOnTap(declineTextEditingController.text.value);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomText(
                              text: 'Enter a comment',
                              size: context.textSizeXL,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 350,
                              child: TextFormField(
                                controller: declineTextEditingController,
                                style: TextFormFieldStyle.inputFieldTextStyle(),
                                decoration: TextFormFieldStyle.inputDecoration('Comment'),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  color: Colors.red,
                ),
                SizedBox(
                  width: 20,
                ),
                Button(
                  text: 'Approve',
                  shrinkWrap: true,
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) => CustomDialog(
                            buttonText: 'Send',
                            onButtonPressed: () {
                              widget.announcementApprovedOnTap();
                              context.revenueBloc.add(
                                RevenueProfitEvent(
                                  profit: int.parse(
                                    approveTextEditingController.text,
                                  ),
                                ),
                              );
                              Get.back();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomText(
                                    text: 'Enter profit',
                                    size: context.textSizeXL,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  SizedBox(
                                    width: 350,
                                    child: TextFormField(
                                      style: TextFormFieldStyle.inputFieldTextStyle(),
                                      controller: approveTextEditingController,
                                      decoration: TextFormFieldStyle.inputDecoration('Profit'),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                ],
                              ),
                            ),
                          )),
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
