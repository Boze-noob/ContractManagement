import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

class WorkingDayWidget extends StatefulWidget {
  const WorkingDayWidget({Key? key}) : super(key: key);

  @override
  _WorkingDayWidgetState createState() => _WorkingDayWidgetState();
}

class _WorkingDayWidgetState extends State<WorkingDayWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkDiariesBloc, WorkDiariesState>(
      builder: (context, state) {
        context.workDiariesBloc
            .add(WorkDiariesUpdateEvent(workDiaryModel: state.workDiaryModel, workingDayModel: state.workingDayModel));
        if (state.workDiaryModels.isEmpty || state.workDiaryModel == null)
          return Center(
            child: CustomText(
              text: 'No date to show',
              size: context.textSizeXL,
              color: Colors.black,
            ),
          );
        else if (state.status == WorkDiariesStateStatus.loading)
          return Center(
            child: Loader(
              width: 100,
              height: 100,
              color: active,
            ),
          );
        WorkingDayModel dropdownValue = state.workDiaryModel!.workingDayModels.last;
        return Column(
          children: [
            SizedBox(
              height: 15,
            ),
            DropdownButton<WorkingDayModel>(
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
              items: state.workDiaryModel!.workingDayModels
                  .map<DropdownMenuItem<WorkingDayModel>>((WorkingDayModel value) {
                return DropdownMenuItem<WorkingDayModel>(
                  value: value,
                  child: Text(
                    value.dateTime.toLocal().formatDDMMYY(),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: active.withOpacity(.4), width: .5),
                boxShadow: [BoxShadow(offset: Offset(0, 6), color: lightGrey.withOpacity(.1), blurRadius: 12)],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 30),
              child: _EditWorkingDayWidget(),
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    //Creating new empty work day
    if (context.workDiariesBloc.state.workDiaryModel != null) {
      DateTime lastWorkingDayDate = context.workDiariesBloc.state.workDiaryModel!.workingDayModels.last.dateTime;
      num comparisonResult = lastWorkingDayDate.compareTo(DateTime.now());
      if (comparisonResult < 0)
        context.workDiariesBloc.add(
            WorkDiariesUpdateEvent(workingDayModel: WorkingDayModel(dateTime: DateTime.now()), workDiaryModel: null));
    }
  }
}

class _EditWorkingDayWidget extends StatefulWidget {
  const _EditWorkingDayWidget({Key? key}) : super(key: key);

  @override
  __EditWorkingDayWidgetState createState() => __EditWorkingDayWidgetState();
}

class __EditWorkingDayWidgetState extends State<_EditWorkingDayWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorkDiariesBloc, WorkDiariesState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: state.workingDayModel!.materials,
              // validator: (text) => context.editUserProfileValidator.firstName(editUserProfileState.model.copyWith(firstName: Optional(text))),
              //onChanged: (text) => context.editProfileBloc.add(EditProfileUpdateEvent(userModel: state.userModel.copyWith(displayName: text))),
              style: _inputFieldTextStyle(),
              maxLines: 8,
              decoration: _inputDecoration('Used materials'),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              initialValue: state.workingDayModel!.machines,
              // validator: (text) => context.editUserProfileValidator.firstName(editUserProfileState.model.copyWith(firstName: Optional(text))),
              //onChanged: (text) => context.editProfileBloc.add(EditProfileUpdateEvent(userModel: state.userModel.copyWith(displayName: text))),
              style: _inputFieldTextStyle(),
              decoration: _inputDecoration('Used machines'),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              initialValue: state.workingDayModel!.employers,
              // validator: (text) => context.editUserProfileValidator.firstName(editUserProfileState.model.copyWith(firstName: Optional(text))),
              //onChanged: (text) => context.editProfileBloc.add(EditProfileUpdateEvent(userModel: state.userModel.copyWith(displayName: text))),
              style: _inputFieldTextStyle(),
              decoration: _inputDecoration('Employers'),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              initialValue: state.workingDayModel!.weather,
              // validator: (text) => context.editUserProfileValidator.firstName(editUserProfileState.model.copyWith(firstName: Optional(text))),
              //onChanged: (text) => context.editProfileBloc.add(EditProfileUpdateEvent(userModel: state.userModel.copyWith(displayName: text))),
              style: _inputFieldTextStyle(),
              decoration: _inputDecoration('Weather'),
            ),
            SizedBox(
              height: 20,
            ),
            //TODO implement on tap
            Button(
              text: 'Save',
              shrinkWrap: true,
              color: active,
              isLoading: state.status == WorkDiariesStateStatus.loading,
              onTap: () => null,
            ),
          ],
        );
      },
    );
  }
}

TextStyle _inputFieldTextStyle() {
  return TextStyle(
    fontFamily: AppFonts.quicksandBold,
    fontSize: 14,
    color: Colors.black,
  );
}

InputDecoration _inputDecoration(String labelTxt) {
  return InputDecoration(
    labelText: labelTxt,
    labelStyle: const TextStyle(
      color: Colors.grey,
      fontFamily: AppFonts.quicksandRegular,
    ),
    border: OutlineInputBorder(),
  );
}
