import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChangeProjectNameDialog extends StatelessWidget {
  final void Function(String string) onEditTap;
  final String? currentProjectName;

  ChangeProjectNameDialog({
    Key? key,
    required this.onEditTap,
    this.currentProjectName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    return CustomDialog(
      buttonText: 'Change',
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
                  text: 'Edit project name',
                  weight: FontWeight.bold,
                  size: context.textSizeXL,
                  color: Colors.black,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 18,
              ),
              TextFormField(
                initialValue: currentProjectName,
                style: TextFormFieldStyle.inputFieldTextStyle(),
                decoration:
                    TextFormFieldStyle.inputDecoration('Current project name'),
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
