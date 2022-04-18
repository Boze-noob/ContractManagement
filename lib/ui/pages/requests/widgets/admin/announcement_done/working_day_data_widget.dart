import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

class WorkingDayDataWidget extends StatefulWidget {
  const WorkingDayDataWidget({Key? key}) : super(key: key);

  @override
  _WorkingDayDataWidgetState createState() => _WorkingDayDataWidgetState();
}

class _WorkingDayDataWidgetState extends State<WorkingDayDataWidget> {
  String dropdownValue = 'String1';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        CustomText(
          text: 'Pick the date',
          color: Colors.black,
          size: context.textSizeM,
          weight: FontWeight.bold,
        ),
        Material(
          child: DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.access_time),
            elevation: 16,
            style: TextStyle(color: active),
            underline: Container(
              height: 2,
              color: active,
            ),
            onChanged: (String? pickedValue) {
              setState(() {
                dropdownValue = pickedValue!;
              });
            },
            items: ['DateTime.now()', 'String1'].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            }).toList(),
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.all(16),
          margin: EdgeInsets.only(bottom: 30),
          child: Align(alignment: Alignment.centerLeft, child: _EditWorkingDayDataWidget()),
        )
      ],
    );
  }
}

class _EditWorkingDayDataWidget extends StatefulWidget {
  const _EditWorkingDayDataWidget({Key? key}) : super(key: key);

  @override
  __EditWorkingDayDataWidgetState createState() => __EditWorkingDayDataWidgetState();
}

class __EditWorkingDayDataWidgetState extends State<_EditWorkingDayDataWidget> {
  Widget _dataRowWidget(String rowDataStr, BuildContext context) {
    return CustomText(
      text: rowDataStr,
      color: Colors.black,
      weight: FontWeight.normal,
      size: context.textSizeM,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 20,
        ),
        CustomText(
          text: 'Working day details',
          size: context.textSizeL,
          color: Colors.black,
          textAlign: TextAlign.center,
          weight: FontWeight.bold,
        ),
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
        _dataRowWidget('rowDataStr', context),
        SizedBox(
          height: 10,
        ),
        _dataRowWidget('rowDataStr', context),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
