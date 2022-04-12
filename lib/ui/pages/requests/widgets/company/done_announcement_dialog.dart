import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

class DoneAnnouncementDialog extends StatefulWidget {
  final AnnouncementModel announcementModel;

  const DoneAnnouncementDialog({Key? key, required this.announcementModel})
      : super(key: key);

  @override
  _DoneAnnouncementDialogState createState() => _DoneAnnouncementDialogState();
}

class _DoneAnnouncementDialogState extends State<DoneAnnouncementDialog> {
  @override
  void initState() {
    super.initState();
    context.workDiariesBloc.add(WorkDiariesUpdateByIdEvent(
        announcementId: widget.announcementModel.id));
  }

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      buttonText: 'Send',
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
                        'Work diary id: ${workDiariesState.workDiaryModel!.id}',
                    size: context.textSizeM,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    text:
                        'Project name: ${workDiariesState.workDiaryModel!.projectName}',
                    size: context.textSizeM,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomText(
                    text: 'Billing',
                    size: context.textSizeL,
                    color: Colors.black,
                    weight: FontWeight.bold,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ),
                  _AdditionalCostWidget(),
                  SizedBox(
                    height: 10,
                  ),
                  _TotalCostWidget(
                    announcementModel: widget.announcementModel,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Button(
                    text: 'Send',
                    shrinkWrap: true,
                    onTap: () => null,
                  )
                ],
              );
            },
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
        IconButton(
          onPressed: () => showDialog(
            context: context,
            builder: (BuildContext context) => Dialog(
              child: Column(
                children: [
                  CustomText(
                    text: 'Additional costs details',
                    size: context.textSizeL,
                    textAlign: TextAlign.center,
                    weight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  CustomText(
                    text: context.workDiariesBloc.state.workDiaryModel!
                        .additionalRequirements,
                    size: context.textSizeM,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
          icon: Icon(
            Icons.info_outline,
          ),
        ),
        IconButton(
          onPressed: () => showDialog(
              context: context,
              builder: (BuildContext context) => Dialog(
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: additionalCost,
                          onChanged: (text) => setState(() {
                            additionalCost = text;
                          }),
                          style: TextFormFieldStyle.inputFieldTextStyle(),
                          decoration: TextFormFieldStyle.inputDecoration(
                              'Additional cost'),
                        )
                      ],
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
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: totalPrice,
                          onChanged: (text) => setState(() {
                            totalPrice = text;
                          }),
                          style: TextFormFieldStyle.inputFieldTextStyle(),
                          decoration:
                              TextFormFieldStyle.inputDecoration('Total price'),
                        )
                      ],
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
