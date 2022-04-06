import 'dart:ui';
import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

class CompanyRequestWidget extends StatefulWidget {
  const CompanyRequestWidget({Key? key}) : super(key: key);

  @override
  _CompanyRequestWidgetState createState() => _CompanyRequestWidgetState();
}

class _CompanyRequestWidgetState extends State<CompanyRequestWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Obx(
            () => Row(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
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
              behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              }),
              child: ListView(
                children: [
                  CustomText(
                    text: 'Clients requests list',
                    color: Colors.black,
                    weight: FontWeight.bold,
                    size: context.textSizeXL,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  BlocBuilder<CompanyRequestsBloc, CompanyRequestsState>(
                    builder: (context, companyRequestsState) {
                      return ClientOrderDataTableWidget(
                        orderModels: companyRequestsState.orderModels,
                        viewBtnOnTap: (int index) => null,
                        respondBtnOnTap: (int index) => null,
                        isEmpty: companyRequestsState.orderModels.isEmpty,
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
