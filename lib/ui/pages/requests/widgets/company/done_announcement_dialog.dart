import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoneAnnouncementDialog extends StatefulWidget {
  final AnnouncementModel announcementModel;
  final Function(String totalPrice) onButtonTap;

  const DoneAnnouncementDialog({Key? key, required this.announcementModel, required this.onButtonTap})
      : super(key: key);

  @override
  _DoneAnnouncementDialogState createState() => _DoneAnnouncementDialogState();
}

class _DoneAnnouncementDialogState extends State<DoneAnnouncementDialog> {
  @override
  void initState() {
    context.billBloc.add(BillUpdateEvent(
      billModel: context.billBloc.state.billModel.copyWith(
          price: widget.announcementModel.price, announcementId: widget.announcementModel.id, additionalReqPrice: '0'),
    ));
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
      child: BlocBuilder<BillBloc, BillState>(
        builder: (context, billState) {
          return CustomDialog(
            buttonText: 'Send',
            onButtonPressed: () {
              if (context.workDiariesBloc.state.workDiaryModel!.endDate != null) {
                widget.onButtonTap(billState.billModel.price);
                context.billBloc.add(BillSubmitEvent());
              } else
                showInfoMessage('Please define end date of project in work diary', context);
            },
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
                          text: 'Agreed costs: ${widget.announcementModel.price}',
                          size: context.textSizeM,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text:
                              'Work diary end date: ${workDiariesState.workDiaryModel != null ? (workDiariesState.workDiaryModel!.endDate != null ? workDiariesState.workDiaryModel!.endDate!.toLocal().formatDDMMYY() : 'Not defined') : 'Not defined'}',
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
          );
        },
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillBloc, BillState>(
      builder: (context, billState) {
        return Row(
          children: [
            CustomText(
              text: 'Additional costs: ${billState.billModel.additionalReqPrice.value}',
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
                                  text:
                                      parentContext.workDiariesBloc.state.workDiaryModel!.additionalRequirements.value,
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
                                initialValue: billState.billModel.additionalReqPrice.value,
                                onChanged: (text) => context.billBloc.add(
                                    BillUpdateEvent(billModel: billState.billModel.copyWith(additionalReqPrice: text))),
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
      },
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
    return BlocBuilder<BillBloc, BillState>(
      builder: (context, billState) {
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
                                onChanged: (text) {
                                  setState(() {
                                    totalPrice = text;
                                  });
                                  context.billBloc
                                      .add(BillUpdateEvent(billModel: billState.billModel.copyWith(price: text)));
                                },
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
      },
    );
  }

  @override
  void initState() {
    super.initState();
    totalPrice = widget.announcementModel.price;
  }
}
