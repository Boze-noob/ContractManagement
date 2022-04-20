import 'dart:ui';
import 'package:contract_management/_all.dart';
import 'package:contract_management/ui/pages/requests/widgets/company/announcement_data_table_widget.dart';
import 'package:contract_management/ui/pages/requests/widgets/company/done_announcement_dialog.dart';
import 'package:flutter/material.dart';

class CompanyRequestWidget extends StatefulWidget {
  const CompanyRequestWidget({Key? key}) : super(key: key);

  @override
  _CompanyRequestWidgetState createState() => _CompanyRequestWidgetState();
}

class _CompanyRequestWidgetState extends State<CompanyRequestWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompanyRequestsBloc(companyRequestRepo: context.serviceProvider.companyRequestRepo)
        ..add(CompanyGetRequestsEvent(receiverId: context.currentUserBloc.state.userModel!.id)),
      child: Container(
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
            BlocListener<CompanyRequestsBloc, CompanyRequestsState>(
              listener: (context, state) {
                if (state.status == CompanyRequestsStateStatus.orderEditSuccessful) {
                  showInfoMessage(state.message ?? 'Edit successful', context);
                  context.companyRequestsBloc
                      .add(CompanyGetOrderRequestsEvent(receiverId: context.currentUserBloc.state.userModel!.id));
                } else if (state.status == CompanyRequestsStateStatus.announcementEditSuccessful) {
                  showInfoMessage(state.message ?? 'Edit successful', context);
                  context.companyRequestsBloc.add(
                      CompanyGetAnnouncementRequestsEvent(receiverId: context.currentUserBloc.state.userModel!.id));
                } else if (state.status == CompanyRequestsStateStatus.error)
                  showInfoMessage(state.message ?? 'Error happen', context);
              },
              child: Expanded(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  }),
                  child: ListView(
                    children: [
                      CustomText(
                        text: 'Order list',
                        color: Colors.black,
                        weight: FontWeight.bold,
                        size: context.textSizeXL,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      BlocBuilder<CompanyRequestsBloc, CompanyRequestsState>(
                        builder: (parentContext, companyRequestsState) {
                          if (companyRequestsState.status == CompanyRequestsStateStatus.loading)
                            return Loader(
                              width: 100,
                              height: 100,
                              color: active,
                            );
                          return CompanyOrderDataTableWidget(
                            orderModels: companyRequestsState.orderModels,
                            viewBtnOnTap: (int index) => showDialog(
                              context: parentContext,
                              builder: (context) => CompanyViewOrderDialog(
                                orderModel: companyRequestsState.orderModels[index],
                              ),
                            ),
                            respondBtnOnTap: (int index) => showDialog(
                              context: parentContext,
                              builder: (context) => CompanyRespondDialog(
                                acceptOnTap: () => parentContext.companyRequestsBloc.add(
                                  CompanyEditOrderRequestEvent(
                                    orderStatusType: OrderStatusType.accepted,
                                    orderId: companyRequestsState.orderModels[index].id,
                                  ),
                                ),
                                declineOnTap: () => parentContext.companyRequestsBloc.add(
                                  CompanyEditOrderRequestEvent(
                                    orderStatusType: OrderStatusType.declined,
                                    orderId: companyRequestsState.orderModels[index].id,
                                  ),
                                ),
                              ),
                            ),
                            isEmpty: companyRequestsState.orderModels.isEmpty,
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomText(
                        text: 'Announcement list',
                        color: Colors.black,
                        weight: FontWeight.bold,
                        size: context.textSizeXL,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      BlocBuilder<CompanyRequestsBloc, CompanyRequestsState>(
                        builder: (context, companyRequestsState) {
                          if (companyRequestsState.status == CompanyRequestsStateStatus.loading)
                            return Loader(
                              width: 100,
                              height: 100,
                              color: active,
                            );
                          return Builder(builder: (parentContext) {
                            //TODO when we click on 'in progress' we create new work diary and bill no matter if it already exist or not(make it to be just one)
                            return CompanyAnnouncementDataTableWidget(
                              isEmpty: companyRequestsState.announcementsModels.isEmpty,
                              viewBtnOnTap: (index) => showDialog(
                                context: context,
                                builder: (context) => CompanyViewAnnouncementDialog(
                                  announcementModel: companyRequestsState.announcementsModels[index],
                                ),
                              ),
                              inProgressBtnOnTap: (index) {
                                context.companyRequestsBloc.add(CompanyEditAnnouncementRequestsEvent(
                                    announcementStatusType: AnnouncementStatusType.inProgress,
                                    announcementId: companyRequestsState.announcementsModels[index].id));
                                context.workDiariesBloc.add(
                                  WorkDiariesCreateEvent(
                                    workDiaryModel: WorkDiaryModel(
                                      id: generateRandomId(),
                                      startDate: DateTime.now(),
                                      completionDateTime:
                                          companyRequestsState.announcementsModels[index].completionDateTime,
                                      announcementId: companyRequestsState.announcementsModels[index].id,
                                      workingDayModels: List.empty(),
                                      companyId:
                                          companyRequestsState.announcementsModels[index].receiverId ?? 'Not defined',
                                    ),
                                  ),
                                );
                              },
                              doneBtnOnTap: (index) => showDialog(
                                context: context,
                                builder: (BuildContext context) => DoneAnnouncementDialog(
                                  onButtonTap: (price) =>
                                      parentContext.companyRequestsBloc.add(CompanyEditAnnouncementRequestsEvent(
                                    announcementStatusType: AnnouncementStatusType.done,
                                    announcementId: companyRequestsState.announcementsModels[index].id,
                                  )),
                                  announcementModel: companyRequestsState.announcementsModels[index],
                                ),
                              ),
                              announcementsModels: companyRequestsState.announcementsModels,
                            );
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
