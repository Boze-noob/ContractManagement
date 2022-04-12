import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

class DoneAnnouncementDialog extends StatefulWidget {
  const DoneAnnouncementDialog({Key? key}) : super(key: key);

  @override
  _DoneAnnouncementDialogState createState() => _DoneAnnouncementDialogState();
}

class _DoneAnnouncementDialogState extends State<DoneAnnouncementDialog> {
  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      buttonText: 'Close',
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: CustomText(
                  text: 'Announcement documents',
                  weight: FontWeight.bold,
                  size: context.textSizeXL,
                  color: Colors.black,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 18,
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
