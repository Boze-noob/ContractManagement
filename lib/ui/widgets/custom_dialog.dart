import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog extends StatelessWidget {
  final Widget? child;
  final String? message;
  final Function? onClose;
  final String? buttonText;
  final Function? onButtonPressed;
  final String title;

  CustomDialog({
    this.child,
    this.message,
    this.onClose,
    this.buttonText,
    this.onButtonPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: context.screenWidth / 8),
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: active,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: CustomText(
                          weight: FontWeight.bold,
                          text: title,
                          color: Colors.white,
                          size: 20,
                          paddingAllValue: 15,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    child ??
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                          child: Text(
                            message ?? ' ',
                            softWrap: true,
                            style: const TextStyle(fontFamily: AppFonts.quicksandRegular),
                          ),
                        ),
                  ],
                ),
              ],
            ),
          ),
          (() {
            if (buttonText != null) {
              return Positioned(
                bottom: -25,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Button(
                      margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                      onTap: () async {
                        if (onButtonPressed != null) {
                          onButtonPressed!();
                        }
                        if (onClose != null) {
                          onClose!();
                        }
                        await Future.delayed(Duration(milliseconds: 200));
                        Get.back();
                      },
                      color: active,
                      child: Text(buttonText!,
                          style: TextStyle(color: Colors.white, fontFamily: AppFonts.quicksandRegular)),
                    ),
                  ],
                ),
              );
            } else {
              return SizedBox();
            }
          }())
        ],
      ),
    );
  }
}
