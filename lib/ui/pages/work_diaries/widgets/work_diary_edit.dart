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
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: workDiariesState.workDiaryModel!.projectName ?? 'Project name not provided',
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
              text: 'Announcement ID' + workDiariesState.workDiaryModel!.announcementId,
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
              style: _inputFieldTextStyle(),
              decoration: _inputDecoration('Project description'),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              initialValue: workDiariesState.workDiaryModel!.interferences,
              // validator: (text) => context.editUserProfileValidator.firstName(editUserProfileState.model.copyWith(firstName: Optional(text))),
              //onChanged: (text) => context.editProfileBloc.add(EditProfileUpdateEvent(userModel: state.userModel.copyWith(displayName: text))),
              style: _inputFieldTextStyle(),
              decoration: _inputDecoration('Interferences'),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              initialValue: workDiariesState.workDiaryModel!.additionalRequirements,
              // validator: (text) => context.editUserProfileValidator.firstName(editUserProfileState.model.copyWith(firstName: Optional(text))),
              //onChanged: (text) => context.editProfileBloc.add(EditProfileUpdateEvent(userModel: state.userModel.copyWith(displayName: text))),
              style: _inputFieldTextStyle(),
              decoration: _inputDecoration('Additional requirements'),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              initialValue: workDiariesState.workDiaryModel!.specialCases,
              // validator: (text) => context.editUserProfileValidator.firstName(editUserProfileState.model.copyWith(firstName: Optional(text))),
              //onChanged: (text) => context.editProfileBloc.add(EditProfileUpdateEvent(userModel: state.userModel.copyWith(displayName: text))),
              style: _inputFieldTextStyle(),
              decoration: _inputDecoration('Special cases'),
            ),
            SizedBox(
              height: 8,
            ),
            CustomText(
              text: 'Start date: ' + workDiariesState.workDiaryModel!.startDate.toLocal().formatDDMMYY(),
              size: context.textSizeM,
              color: Colors.black,
            ),
            SizedBox(
              height: 8,
            ),
            CustomText(
              text: 'End date: ' + workDiariesState.workDiaryModel!.endDate.toLocal().formatDDMMYY(),
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
