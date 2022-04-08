import 'dart:ui';
import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

class WorkDiariesPage extends StatefulWidget {
  WorkDiariesPage({Key? key}) : super(key: key);

  @override
  State<WorkDiariesPage> createState() => _WorkDiariesPageState();
}

class _WorkDiariesPageState extends State<WorkDiariesPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Obx(
            () => Row(
              children: [
                Container(
                  margin: EdgeInsets.only(top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                  child: CustomText(
                    text: menuController.activeItem.value,
                    size: 24,
                    weight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              child: GridView.count(
                crossAxisCount: 3,
                childAspectRatio: 3.5,
                mainAxisSpacing: 40,
                crossAxisSpacing: 20,
                children: List.generate(100, (index) {
                  return Center(
                    child: Container(
                      height: 500,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Center(
                        child: CustomText(
                          text: 'Item $index',
                          size: context.textSizeL,
                          color: Colors.black,
                          weight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
