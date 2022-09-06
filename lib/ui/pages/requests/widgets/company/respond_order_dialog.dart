import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyRespondDialog extends StatelessWidget {
  final void Function() declineOnTap;
  final void Function() acceptOnTap;
  const CompanyRespondDialog({required this.acceptOnTap, required this.declineOnTap}) : super();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Pick the option'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Button(
                    text: 'Accept',
                    color: Colors.green.withOpacity(0.7),
                    onTap: () {
                      acceptOnTap();
                      Get.back();
                    }),
              ),
              SizedBox(
                width: 15,
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Button(
                    text: 'Decline',
                    color: Colors.red.withOpacity(0.7),
                    onTap: () {
                      declineOnTap();
                      Get.back();
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
