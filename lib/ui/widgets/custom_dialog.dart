import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog extends StatelessWidget {
  final Widget? child;
  final String? message;
  final Function? onClose;
  final String? buttonText;
  final Function? onButtonPressed;

  CustomDialog({
    this.child,
    this.message,
    this.onClose,
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
            child: Row(
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
