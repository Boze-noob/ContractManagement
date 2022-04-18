import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

class WorkingDayDataWidget extends StatefulWidget {
  final List<WorkingDayModel> workingDayModels;
  const WorkingDayDataWidget({Key? key, required this.workingDayModels}) : super(key: key);

  @override
  _WorkingDayDataWidgetState createState() => _WorkingDayDataWidgetState();
}

class _WorkingDayDataWidgetState extends State<WorkingDayDataWidget> {
  late WorkingDayModel dropdownValue;

  @override
  void initState() {
    dropdownValue = widget.workingDayModels[0];
    super.initState();
  }

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
          child: DropdownButton<WorkingDayModel>(
            value: dropdownValue,
            icon: const Icon(Icons.access_time),
            elevation: 16,
            style: TextStyle(color: active),
            underline: Container(
              height: 2,
              color: active,
            ),
            onChanged: (WorkingDayModel? pickedValue) {
              setState(() {
                dropdownValue = pickedValue!;
              });
            },
            items: widget.workingDayModels.map<DropdownMenuItem<WorkingDayModel>>((WorkingDayModel value) {
              return DropdownMenuItem<WorkingDayModel>(
                value: value,
                child: Text(
                  value.dateTime.toLocal().formatDDMMYY(),
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
          child: Align(alignment: Alignment.centerLeft, child: _EditWorkingDayDataWidget(workingDayModel: dropdownValue,)),
        )
      ],
    );
  }
}

class _EditWorkingDayDataWidget extends StatefulWidget {
  final WorkingDayModel workingDayModel;
  const _EditWorkingDayDataWidget({Key? key, required this.workingDayModel}) : super(key: key);

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
        _dataRowWidget('Date time: ' + widget.workingDayModel.dateTime.toLocal().formatDDMMYY(), context),
        SizedBox(
          height: 10,
        ),
        _dataRowWidget('Weather: ' + widget.workingDayModel.weather.value, context),
        SizedBox(
          height: 10,
        ),
        _dataRowWidget('Employers: ' + widget.workingDayModel.employers.value, context),
        SizedBox(
          height: 10,
        ),
        _dataRowWidget('Machines: ' + widget.workingDayModel.machines.value, context),
        SizedBox(
          height: 10,
        ),
        _dataRowWidget('Materials: ' + widget.workingDayModel.materials.value, context),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
