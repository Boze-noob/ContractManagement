import 'dart:ui';
import 'package:contract_management/_all.dart';
import 'package:contract_management/ui/pages/work_diaries/widgets/work_diary_edit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:contract_management/blocs/navigator/navigator_state.dart' as navigatorState;

class WorkDiariesPage extends StatefulWidget {
  WorkDiariesPage({Key? key}) : super(key: key);

  @override
  State<WorkDiariesPage> createState() => _WorkDiariesPageState();
}

class _WorkDiariesPageState extends State<WorkDiariesPage> {
  @override
  void initState() {
    context.workDiariesBloc.add(WorkDiariesGetEvent(companyId: context.currentUserBloc.state.userModel!.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigatorBloc(),
      child: BlocBuilder<WorkDiariesBloc, WorkDiariesState>(
        builder: (context, workDiariesState) {
          if (workDiariesState.status == WorkDiariesStateStatus.loading)
            return Center(
              child: Loader(
                width: 100,
                height: 100,
                color: active,
              ),
            );
          else if (workDiariesState.workDiaryModels.isEmpty)
            return Center(
              child: CustomText(
                text: 'No data to display',
                size: context.textSizeXL,
                color: Colors.black,
                weight: FontWeight.bold,
              ),
            );
          return BlocBuilder<NavigatorBloc, navigatorState.NavigatorState>(
            builder: (context, state) {
              if (state.index == 0)
                return Container(
                  child: Column(
                    children: [
                      Obx(
                        () => Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: ResponsiveWidget.isSmallScreen(context) ? 56 : 6),
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
                          behavior: ScrollConfiguration.of(context).copyWith(
                            dragDevices: {
                              PointerDeviceKind.touch,
                              PointerDeviceKind.mouse,
                            },
                          ),
                          child: GridView.count(
                            crossAxisCount: 3,
                            childAspectRatio: 3.5,
                            mainAxisSpacing: 40,
                            crossAxisSpacing: 20,
                            children: List.generate(workDiariesState.workDiaryModels.length, (index) {
                              return Center(
                                child: GestureDetector(
                                  onTap: () {
                                    context.workDiariesBloc.add(WorkDiariesUpdateEvent(
                                        workDiaryModel: workDiariesState.workDiaryModels[index],
                                        workingDayModel: null));
                                    context.navigatorBloc.add(NavigatorUpdateEvent(1));
                                  },
                                  child: Container(
                                    height: 500,
                                    width: 350,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 1,
                                          blurRadius: 7,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Center(
                                      child: CustomText(
                                        text: workDiariesState.workDiaryModels[index].projectName ??
                                            'Work diary number $index',
                                        size: context.textSizeL,
                                        color: Colors.black,
                                        weight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              return WorkDiaryEdit();
            },
          );
        },
      ),
    );
  }
}
