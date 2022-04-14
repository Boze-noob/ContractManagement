import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoneAnnouncementDialog extends StatefulWidget {
  final AnnouncementModel announcementModel;

  const DoneAnnouncementDialog({Key? key, required this.announcementModel}) : super(key: key);

  @override
  _DoneAnnouncementDialogState createState() => _DoneAnnouncementDialogState();
}

class _DoneAnnouncementDialogState extends State<DoneAnnouncementDialog> {
  @override
  void initState() {
    super.initState();
    context.workDiariesBloc.add(WorkDiariesGetEvent(companyId: context.currentUserBloc.state.userModel!.id));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorkDiariesBloc, WorkDiariesState>(
      listener: (context, state) async {
        if (state.status == WorkDiariesStateStatus.loaded) {
          //added cuz app gets frozen
          await Future.delayed(Duration(seconds: 2));
          context.workDiariesBloc.add(
            WorkDiariesUpdateByIdEvent(
              announcementId: widget.announcementModel.id,
            ),
          );
        }
      },
      child: CustomDialog(
        buttonText: 'Send',
        onButtonPressed: () {
          context.companyRequestsBloc.add(
              CompanyEditAnnouncementRequestsEvent(
                  announcementStatusType:
                  AnnouncementStatusType.inProgress,
                  announcementId: widget.announcementModel.id));
          //TODO add announcement completed here


        } ,
        message: 'Documents will be sent to admin for approve',
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: BlocBuilder<WorkDiariesBloc, WorkDiariesState>(
              builder: (context, workDiariesState) {
                if (workDiariesState.status == WorkDiariesStateStatus.loading)
                  return Loader(
                    width: 100,
                    height: 100,
                    color: active,
                  );
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: CustomText(
                        text: 'Documentation',
                        weight: FontWeight.bold,
                        size: context.textSizeXL,
                        color: Colors.black,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 18,
                    ),
                    CustomText(
                      text: 'Announcement id: ${widget.announcementModel.id}',
                      size: context.textSizeM,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text:
                          'Work diary id: ${workDiariesState.workDiaryModel != null ? workDiariesState.workDiaryModel!.id.value : ' '}',
                      size: context.textSizeM,
                      color: Colors.black,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text:
                          'Project name: ${workDiariesState.workDiaryModel != null ? workDiariesState.workDiaryModel!.projectName.value : ' '}',
                      size: context.textSizeM,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                    ),
                    CustomText(
                      text: 'Billing',
                      size: context.textSizeL,
                      color: Colors.black,
                      weight: FontWeight.bold,
                    ),
                    _AdditionalCostWidget(),
                    SizedBox(
                      height: 5,
                    ),
                    _TotalCostWidget(
                      announcementModel: widget.announcementModel,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _AdditionalCostWidget extends StatefulWidget {
  const _AdditionalCostWidget({Key? key}) : super(key: key);

  @override
  __AdditionalCostWidgetState createState() => __AdditionalCostWidgetState();
}

class __AdditionalCostWidgetState extends State<_AdditionalCostWidget> {
  String additionalCost = '0';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(
          text: 'Additional costs: $additionalCost',
          size: context.textSizeS,
          color: Colors.black,
        ),
        SizedBox(
          width: 5,
        ),
        Builder(
          builder: (parentContext) {
            return IconButton(
              onPressed: () => showDialog(
                  context: parentContext,
                  builder: (BuildContext context) {
                    if (parentContext.workDiariesBloc.state.workDiaryModel == null)
                      return Loader(
                        width: 100,
                        height: 100,
                        color: active,
                      );
                    return Dialog(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'Additional costs details',
                              size: context.textSizeL,
                              textAlign: TextAlign.center,
                              weight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomText(
                              text: parentContext.workDiariesBloc.state.workDiaryModel!.additionalRequirements.value,
                              size: context.textSizeM,
                              color: Colors.black,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Button(
                              text: 'Ok',
                              shrinkWrap: true,
                              color: active,
                              onTap: () => Get.back(),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
              icon: Icon(
                Icons.info_outline,
              ),
            );
          },
        ),
        IconButton(
          onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) => Dialog(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            text: 'Edit price',
                            textAlign: TextAlign.center,
                            size: context.textSizeM,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            initialValue: additionalCost,
                            onChanged: (text) => setState(() {
                              additionalCost = text;
                            }),
                            style: TextFormFieldStyle.inputFieldTextStyle(),
                            decoration: TextFormFieldStyle.inputDecoration('Additional cost'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Button(
                            text: 'Ok',
                            shrinkWrap: true,
                            color: active,
                            onTap: () => Get.back(),
                          )
                        ],
                      ),
                    ),
                  )),
          icon: Icon(
            Icons.create,
          ),
        ),
      ],
    );
  }
}

class _TotalCostWidget extends StatefulWidget {
  final AnnouncementModel announcementModel;

  const _TotalCostWidget({
    Key? key,
    required this.announcementModel,
  }) : super(key: key);

  @override
  __TotalCostWidgetState createState() => __TotalCostWidgetState();
}

class __TotalCostWidgetState extends State<_TotalCostWidget> {
  late String totalPrice;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(
          text: 'Total: $totalPrice',
          size: context.textSizeM,
          color: Colors.black,
        ),
        SizedBox(
          width: 5,
        ),
        IconButton(
          onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) => Dialog(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            text: 'Edit price',
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            initialValue: totalPrice,
                            onChanged: (text) => setState(() {
                              totalPrice = text;
                            }),
                            style: TextFormFieldStyle.inputFieldTextStyle(),
                            decoration: TextFormFieldStyle.inputDecoration('Total price'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Button(
                            text: 'Ok',
                            shrinkWrap: true,
                            color: active,
                            onTap: () => Get.back(),
                          )
                        ],
                      ),
                    ),
                  )),
          icon: Icon(
            Icons.create,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    totalPrice = widget.announcementModel.price;
  }
}
