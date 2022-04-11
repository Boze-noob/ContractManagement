import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

class WorkDiaryEdit extends StatefulWidget {
  const WorkDiaryEdit({Key? key}) : super(key: key);

  @override
  _WorkDiaryEditState createState() => _WorkDiaryEditState();
}

class _WorkDiaryEditState extends State<WorkDiaryEdit> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkDiariesBloc, WorkDiariesState>(
      builder: (context, workDiariesState) {
        if (workDiariesState.status == WorkDiariesStateStatus.loading)
          return Center(
            child: Loader(
              width: 100,
              height: 100,
              color: active,
            ),
          );
        else if (workDiariesState.workDiaryModel == null)
          return Center(
            child: CustomText(
              text: 'No data to show',
              size: context.textSizeXL,
              weight: FontWeight.bold,
              color: Colors.black,
            ),
          );
        return ListView(
          shrinkWrap: true,
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: workDiariesState.workDiaryModel!.projectName ??
                      'Project name not provided',
                ),
                IconButton(onPressed: () => null, icon: Icon(Icons.create)),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            CustomText(
              text: 'Diary ID ' + workDiariesState.workDiaryModel!.id,
              size: context.textSizeM,
              color: Colors.black,
            ),
            SizedBox(
              height: 8,
            ),
            CustomText(
              text: 'Announcement ID' +
                  workDiariesState.workDiaryModel!.announcementId,
              size: context.textSizeM,
              color: Colors.black,
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              initialValue: workDiariesState.workDiaryModel!.projectDescription,
              // validator: (text) => context.editUserProfileValidator.firstName(editUserProfileState.model.copyWith(firstName: Optional(text))),
              //onChanged: (text) => context.editProfileBloc.add(EditProfileUpdateEvent(userModel: state.userModel.copyWith(displayName: text))),
              style: TextFormFieldStyle.inputFieldTextStyle(),
              maxLines: 3,
              decoration:
                  TextFormFieldStyle.inputDecoration('Project description'),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              initialValue: workDiariesState.workDiaryModel!.interferences,
              // validator: (text) => context.editUserProfileValidator.firstName(editUserProfileState.model.copyWith(firstName: Optional(text))),
              //onChanged: (text) => context.editProfileBloc.add(EditProfileUpdateEvent(userModel: state.userModel.copyWith(displayName: text))),
              style: TextFormFieldStyle.inputFieldTextStyle(),
              maxLines: 3,
              decoration: TextFormFieldStyle.inputDecoration('Interferences'),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              initialValue:
                  workDiariesState.workDiaryModel!.additionalRequirements,
              // validator: (text) => context.editUserProfileValidator.firstName(editUserProfileState.model.copyWith(firstName: Optional(text))),
              //onChanged: (text) => context.editProfileBloc.add(EditProfileUpdateEvent(userModel: state.userModel.copyWith(displayName: text))),
              style: TextFormFieldStyle.inputFieldTextStyle(),
              maxLines: 3,
              decoration:
                  TextFormFieldStyle.inputDecoration('Additional requirements'),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              initialValue: workDiariesState.workDiaryModel!.specialCases,
              // validator: (text) => context.editUserProfileValidator.firstName(editUserProfileState.model.copyWith(firstName: Optional(text))),
              //onChanged: (text) => context.editProfileBloc.add(EditProfileUpdateEvent(userModel: state.userModel.copyWith(displayName: text))),
              style: TextFormFieldStyle.inputFieldTextStyle(),
              maxLines: 3,
              decoration: TextFormFieldStyle.inputDecoration('Special cases'),
            ),
            SizedBox(
              height: 8,
            ),
            _DatePickerWidget(
              onDateSelected: (dateTime) => null,
            ),
            SizedBox(
              height: 8,
            ),
            CustomText(
              text: 'Start date: ' +
                  workDiariesState.workDiaryModel!.startDate
                      .toLocal()
                      .formatDDMMYY(),
              size: context.textSizeM,
              color: Colors.black,
            ),
            SizedBox(
              height: 8,
            ),
            CustomText(
              text: 'Completion date: ' +
                  workDiariesState.workDiaryModel!.completionDateTime
                      .toLocal()
                      .formatDDMMYY(),
              size: context.textSizeM,
              color: Colors.black,
            ),
            SizedBox(
              height: 20,
            ),
            WorkingDayWidget(),
          ],
        );
      },
    );
  }
}

class _DatePickerWidget extends StatefulWidget {
  final void Function(DateTime dateTime) onDateSelected;
  _DatePickerWidget({
    required this.onDateSelected,
  }) : super();

  @override
  State<_DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<_DatePickerWidget> {
  late DateTime selectedDateTime;
  late DateTime dateTimeTxtValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Choose date',
              style: TextStyle(
                fontFamily: AppFonts.quicksandBold,
              ),
            ),
            content: Container(
              width: 300,
              height: 300,
              child: Theme(
                data: ThemeData(
                  colorScheme: ColorScheme.light(),
                ),
                child: BlocProvider(
                  create: (context) =>
                      OrderBloc(orderRepo: context.serviceProvider.orderRepo),
                  child: BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) {
                      return CalendarDatePicker(
                        firstDate: DateTime(1960),
                        lastDate: DateTime.now(),
                        initialDate: selectedDateTime,
                        onDateChanged: (DateTime dateTime) {
                          setState(() {
                            selectedDateTime = dateTime;
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  dateTimeTxtValue = selectedDateTime;
                  widget.onDateSelected(selectedDateTime);
                  Navigator.pop(context);
                },
                child: Text(
                  'Select',
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: AppFonts.quicksandBold,
                  ),
                ),
              )
            ],
          );
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                dateTimeTxtValue.formatDDMMYY().toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: AppFonts.quicksandRegular,
                ),
              ),
              const Icon(
                Icons.arrow_drop_down_sharp,
                color: Color(0xFF707070),
              ),
              const SizedBox(height: 10),
              Line.horizontal(
                color: Colors.grey,
                thickness: 0.5,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    selectedDateTime = DateTime.now();
    dateTimeTxtValue = DateTime.now();
    super.initState();
  }
}
