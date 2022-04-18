import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';

class BillDataWidget extends StatelessWidget {
  final bool isEmpty;
  final BillModel billModel;

  BillDataWidget({
    Key? key,
    required this.isEmpty,
    required this.billModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isEmpty)
      return Container(
        width: 600,
        height: 300,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: active.withOpacity(.4), width: .5),
          boxShadow: [BoxShadow(offset: Offset(0, 6), color: lightGrey.withOpacity(.1), blurRadius: 12)],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 30),
        child: Center(
          child: CustomText(
            text: 'No data to display',
            size: context.textSizeXL,
            color: Colors.black,
            textAlign: TextAlign.center,
            weight: FontWeight.bold,
          ),
        ),
      );
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: active.withOpacity(.4), width: .5),
        boxShadow: [BoxShadow(offset: Offset(0, 6), color: lightGrey.withOpacity(.1), blurRadius: 12)],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: CustomText(
              text: 'Bill data',
              size: context.textSizeXL,
              color: Colors.black,
              textAlign: TextAlign.center,
              weight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _dataRowWidget('rowDataStr', context),
          SizedBox(
            height: 10,
          ),
          _dataRowWidget('rowDataStr', context),
          SizedBox(
            height: 10,
          ),
          _dataRowWidget('rowDataStr', context),
          SizedBox(
            height: 10,
          ),
          _dataRowWidget('rowDataStr', context),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}

Widget _dataRowWidget(String rowDataStr, BuildContext context) {
  return CustomText(
    text: rowDataStr,
    color: Colors.black,
    weight: FontWeight.normal,
    size: context.textSizeM,
  );
}
