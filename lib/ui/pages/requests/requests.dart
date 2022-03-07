import 'dart:ui';

import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({Key? key}) : super(key: key);

  @override
  _RequestsPageState createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Obx(() => Row(
            children: [
              Container(
                  margin: EdgeInsets.only(top:
                  ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
                  child: CustomText(text: menuController.activeItem.value, size: 24, weight: FontWeight.bold,)),
            ],
          ),),

          Expanded(child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            }),
            child: ListView(
              children: [
                DataTableWidget(firstColumnName: 'Client', secondColumnName: 'Location', thirdColumnName: 'Rating', fourthColumnName: 'Action', action: 'View request')
              ],
            ),
          ),),

        ],
      ),
    );
  }
}
