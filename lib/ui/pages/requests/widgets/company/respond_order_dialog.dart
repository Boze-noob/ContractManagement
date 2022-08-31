import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyRespondDialog extends StatelessWidget {
  final void Function() declineOnTap;
  final void Function() acceptOnTap;
  const CompanyRespondDialog({required this.acceptOnTap, required this.declineOnTap}) : super();

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      title: 'Pick the option',
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Button(
                    text: 'Accept',
                    color: Colors.green.withOpacity(0.7),
                    onTap: () {
                      acceptOnTap();
                      Get.back();
                    }),
                SizedBox(
                  width: 15,
                ),
                Button(
                    text: 'Decline',
                    color: Colors.red.withOpacity(0.7),
                    onTap: () {
                      declineOnTap();
                      Get.back();
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
