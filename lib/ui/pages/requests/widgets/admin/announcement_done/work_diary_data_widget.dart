import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';

class WorkDiaryDataWidget extends StatelessWidget {
  final bool isEmpty;
  final String announcementId;

  WorkDiaryDataWidget({
    Key? key,
    required this.isEmpty,
    required this.announcementId,
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
    return BlocProvider(
      create: (context) => WorkDiariesBloc(workDiariesRepo: context.serviceProvider.workDiaries)
        ..add(WorkDiariesGetSingleEvent(announcementId: announcementId)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: active.withOpacity(.4), width: .5),
          boxShadow: [BoxShadow(offset: Offset(0, 6), color: lightGrey.withOpacity(.1), blurRadius: 12)],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 30),
        child: BlocBuilder<WorkDiariesBloc, WorkDiariesState>(
          builder: (context, state) {
            if (state.status == WorkDiariesStateStatus.loading)
              return Loader(
                width: 50,
                height: 50,
                color: active,
              );
            else if (state.workDiaryModel == null)
              return Center(
                child: CustomText(
                  text: 'No data found',
                  size: context.textSizeL,
                  color: Colors.black,
                  weight: FontWeight.bold,
                ),
              );
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CustomText(
                    text: 'Work diary data',
                    size: context.textSizeXL,
                    color: Colors.black,
                    textAlign: TextAlign.center,
                    weight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _dataRowWidget('Id: ' + state.workDiaryModel!.id, context),
                SizedBox(
                  height: 10,
                ),
                _dataRowWidget('Announcement id: ' + state.workDiaryModel!.announcementId, context),
                SizedBox(
                  height: 10,
                ),
                _dataRowWidget('Company id: ' + state.workDiaryModel!.companyId, context),
                SizedBox(
                  height: 10,
                ),
                _dataRowWidget('Project name: ' + state.workDiaryModel!.projectName.value, context),
                SizedBox(
                  height: 10,
                ),
                _dataRowWidget('Project description: ' + state.workDiaryModel!.projectDescription.value, context),
                SizedBox(
                  height: 10,
                ),
                _dataRowWidget('Interferences: ' + state.workDiaryModel!.interferences.value, context),
                SizedBox(
                  height: 10,
                ),
                _dataRowWidget('Additional requirements' + state.workDiaryModel!.additionalRequirements.value, context),
                SizedBox(
                  height: 10,
                ),
                _dataRowWidget('Special cases: ' + state.workDiaryModel!.specialCases.value, context),
                SizedBox(
                  height: 10,
                ),
                _dataRowWidget('Start date: ' + state.workDiaryModel!.startDate.toLocal().formatDDMMYY(), context),
                SizedBox(
                  height: 10,
                ),
                _dataRowWidget(
                    'End date: ' +
                        (state.workDiaryModel!.endDate != null
                            ? state.workDiaryModel!.endDate!.toLocal().formatDDMMYY()
                            : 'Not defined'),
                    context),
                SizedBox(
                  height: 10,
                ),
                _dataRowWidget(
                    'Completion date: ' + state.workDiaryModel!.completionDateTime.toLocal().formatDDMMYY(), context),
                SizedBox(
                  height: 10,
                ),
                WorkingDayDataWidget(
                  workingDayModels: [],
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            );
          },
        ),
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
