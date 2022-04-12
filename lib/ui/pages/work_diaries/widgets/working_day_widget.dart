import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

class WorkingDayWidget extends StatefulWidget {
  const WorkingDayWidget({Key? key}) : super(key: key);

  @override
  _WorkingDayWidgetState createState() => _WorkingDayWidgetState();
}

class _WorkingDayWidgetState extends State<WorkingDayWidget> {
  late WorkingDayModel dropdownValue;

  @override
  Widget build(BuildContext context) {
    //Instead of using listener and builder we can use blocConsumer
    return BlocListener<WorkDiariesBloc, WorkDiariesState>(
      listener: (context, state) {
        if (state.status == WorkDiariesStateStatus.updateSuccessful) {
          showInfoMessage(state.message ?? 'Update successful', context);
          dropdownValue = state.workDiaryModel!.workingDayModels.last;
          context.workDiariesBloc.add(WorkDiariesInitEvent(
              workingDayModel: state.workDiaryModel!.workingDayModels.last));
        }
      },
      child: BlocBuilder<WorkDiariesBloc, WorkDiariesState>(
        builder: (context, state) {
          if (state.workingDayModel == null)
            return Center(
              child: CustomText(
                text: 'No date to show',
                size: context.textSizeXL,
                color: Colors.black,
              ),
            );
          else if (state.status == WorkDiariesStateStatus.loading ||
              state.status == WorkDiariesStateStatus.initializing)
            return Center(
              child: Loader(
                width: 100,
                height: 100,
                color: active,
              ),
            );
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
                    print(dropdownValue.dateTime.toLocal().formatDDMMYY());
                  });
                  context.workDiariesBloc.add(
                    WorkDiariesInitEvent(
                      workingDayModel: pickedValue!,
                    ),
                  );
                },
                items: state.workDiaryModel!.workingDayModels
                    .map<DropdownMenuItem<WorkingDayModel>>(
                        (WorkingDayModel value) {
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
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 6),
                        color: lightGrey.withOpacity(.1),
                        blurRadius: 12)
                  ],
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(16),
                margin: EdgeInsets.only(bottom: 30),
                child: _EditWorkingDayWidget(),
              )
            ],
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    //Creating new empty work day
    if (context.workDiariesBloc.state.workDiaryModel != null) {
      if (context
          .workDiariesBloc.state.workDiaryModel!.workingDayModels.isEmpty) {
        List<WorkingDayModel> workingDays = [
          WorkingDayModel(dateTime: DateTime.now())
        ];
        context.workDiariesBloc.add(WorkDiariesSubmitUpdateEvent(workingDays));
      } else {
        DateTime lastWorkingDayDate = context.workDiariesBloc.state
            .workDiaryModel!.workingDayModels.last.dateTime;
        bool comparisonResult = lastWorkingDayDate.isEqualDate(DateTime.now());

        if (comparisonResult != true) {
          List<WorkingDayModel> workingDays =
              context.workDiariesBloc.state.workDiaryModel!.workingDayModels;
          workingDays.insert(
              workingDays.length, WorkingDayModel(dateTime: DateTime.now()));
          context.workDiariesBloc
              .add(WorkDiariesSubmitUpdateEvent(workingDays));
        } else {
          final lastWorkingDay = context
              .workDiariesBloc.state.workDiaryModel!.workingDayModels.last;
          context.workDiariesBloc.add(
            WorkDiariesInitEvent(
              workingDayModel: lastWorkingDay,
            ),
          );
          dropdownValue = lastWorkingDay;
        }
      }
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
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 20,
            ),
            TextFormField(
              initialValue: state.workingDayModel!.materials.value,
              // validator: (text) => context.editUserProfileValidator.firstName(editUserProfileState.model.copyWith(firstName: Optional(text))),
              onChanged: (text) => context.workDiariesBloc.add(
                  WorkDiariesUpdateEvent(
                      workingDayModel:
                          state.workingDayModel!.copyWith(materials: text))),
              style: TextFormFieldStyle.inputFieldTextStyle(),
              maxLines: 4,
              decoration: TextFormFieldStyle.inputDecoration('Used materials'),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              initialValue: state.workingDayModel!.machines.value,
              // validator: (text) => context.editUserProfileValidator.firstName(editUserProfileState.model.copyWith(firstName: Optional(text))),
              onChanged: (text) => context.workDiariesBloc.add(
                  WorkDiariesUpdateEvent(
                      workingDayModel:
                          state.workingDayModel!.copyWith(machines: text))),
              style: TextFormFieldStyle.inputFieldTextStyle(),
              maxLines: 4,
              decoration: TextFormFieldStyle.inputDecoration('Used machines'),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              initialValue: state.workingDayModel!.employers.value,
              // validator: (text) => context.editUserProfileValidator.firstName(editUserProfileState.model.copyWith(firstName: Optional(text))),
              onChanged: (text) => context.workDiariesBloc.add(
                  WorkDiariesUpdateEvent(
                      workingDayModel:
                          state.workingDayModel!.copyWith(employers: text))),
              style: TextFormFieldStyle.inputFieldTextStyle(),
              maxLines: 4,
              decoration: TextFormFieldStyle.inputDecoration('Employers'),
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              initialValue: state.workingDayModel!.weather.value,
              // validator: (text) => context.editUserProfileValidator.firstName(editUserProfileState.model.copyWith(firstName: Optional(text))),
              onChanged: (text) => context.workDiariesBloc.add(
                  WorkDiariesUpdateEvent(
                      workingDayModel:
                          state.workingDayModel!.copyWith(weather: text))),
              style: TextFormFieldStyle.inputFieldTextStyle(),
              maxLines: 2,
              decoration: TextFormFieldStyle.inputDecoration('Weather'),
            ),
            SizedBox(
              height: 20,
            ),
            Button(
              text: 'Save',
              shrinkWrap: true,
              color: active,
              isLoading: state.status == WorkDiariesStateStatus.loading,
              onTap: () => context.workDiariesBloc
                  .add(WorkDiariesSubmitUpdateEvent(null)),
            ),
          ],
        );
      },
    );
  }
}
