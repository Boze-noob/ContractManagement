import 'dart:ui';
import 'package:contract_management/_all.dart';
import 'package:contract_management/ui/pages/requests/widgets/admin/announcement_data_table_widget.dart';
import 'package:contract_management/ui/pages/requests/widgets/admin/create_announcement_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminRequestWidget extends StatefulWidget {
  const AdminRequestWidget({Key? key}) : super(key: key);

  @override
  _AdminRequestWidgetState createState() => _AdminRequestWidgetState();
}

class _AdminRequestWidgetState extends State<AdminRequestWidget> {
  SortType clientRequestsSortType = SortType.oldest;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              RequestsBloc(companyRequest: context.serviceProvider.companyRequestRepo)..add(RequestsLoadEvent()),
        ),
        BlocProvider(
          create: (context) => OrderBloc(orderRepo: context.serviceProvider.orderRepo)..add(OrderGetEvent()),
        ),
        BlocProvider(
            create: (context) => AnnouncementBloc(announcementRepo: context.serviceProvider.announcementRepo)
              ..add(AnnouncementGetEvent())),
      ],
      child: BlocListener<RequestsBloc, RequestsState>(
        listener: (context, state) {
          if (state.status == RequestsStateStatus.error) showInfoMessage(state.errorMessage ?? 'Error happen', context);
        },
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
              Expanded(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  }),
                  child: BlocBuilder<CurrentUserBloc, CurrentUserState>(
                    builder: (context, currentUserState) {
                      return ListView(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: 'Clients requests list',
                                color: Colors.black,
                                weight: FontWeight.bold,
                                size: context.textSizeXL,
                                textAlign: TextAlign.center,
                              ),
                              DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  icon: Icon(Icons.sort),
                                  iconSize: 28,
                                  style: TextStyle(fontSize: 16),
                                  value: clientRequestsSortType,
                                  items: SortType.values.map((sortType) {
                                    return DropdownMenuItem(
                                      value: sortType,
                                      child: Text(sortType.translate()),
                                    );
                                  }).toList(),
                                  onChanged: (SortType? newValue) {
                                    if (newValue != null) {
                                      setState(() {
                                        clientRequestsSortType = newValue;
                                      });
                                      context.requestsBloc.add(RequestsSortEvent(sortType: newValue));
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          (() {
                            if (currentUserState.userModel!.role == RoleType.admin.translate() ||
                                currentUserState.userModel!.role == RoleType.orderEmployer.translate())
                              return BlocBuilder<RequestsBloc, RequestsState>(
                                builder: (context, requestsState) {
                                  if (requestsState.status == RequestsStateStatus.loading) {
                                    return Loader(
                                      width: 100,
                                      height: 100,
                                      color: active,
                                    );
                                  } else if (requestsState.clientRequestModel.isEmpty)
                                    return Container(
                                      width: 600,
                                      height: 300,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(color: active.withOpacity(.4), width: .5),
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(0, 6), color: lightGrey.withOpacity(.1), blurRadius: 12)
                                        ],
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
                                  else
                                    return CreateOrderWidget(
                                        requestState: requestsState,
                                        onCreate: () {
                                          context.orderBloc.add(OrderGetEvent());
                                          context.requestsBloc.add(RequestsLoadEvent());
                                        });
                                },
                              );
                            else
                              return _NoAccessWidget();
                          }()),
                          SizedBox(
                            height: 20,
                          ),
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
                          (() {
                            if (currentUserState.userModel!.role != RoleType.announcementVerifyEmployer.translate())
                              return BlocListener<OrderBloc, OrderState>(
                                listener: (context, state) {
                                  if (state.status == OrderStateStatus.deleteSuccessful)
                                    context.orderBloc.add(OrderGetEvent());
                                  else if (state.status == OrderStateStatus.error)
                                    showInfoMessage(state.message ?? 'Error happen', context);
                                },
                                child: BlocListener<AnnouncementBloc, AnnouncementState>(
                                  listener: (context, state) {
                                    if (state.status == AnnouncementStateStatus.error)
                                      showInfoMessage(state.message ?? 'Error happen', context);
                                    else if (state.status == AnnouncementStateStatus.created) {
                                      showInfoMessage(state.message ?? 'Created', context);
                                      context.announcementBloc.add(AnnouncementGetEvent());
                                    }
                                  },
                                  child: BlocBuilder<OrderBloc, OrderState>(
                                    builder: (context, orderState) {
                                      if (orderState.status == OrderStateStatus.loading)
                                        return Loader(
                                          width: 100,
                                          height: 100,
                                          color: active,
                                        );
                                      return Builder(builder: (parentContext) {
                                        return OrderDataTableWidget(
                                          firstColumnName: 'Receiver name',
                                          secondColumnName: 'Created date time',
                                          thirdColumnName: 'Sent date time',
                                          fourthColumnName: 'Status',
                                          fifthColumnName: 'Employer',
                                          sixthColumnName: '',
                                          isEmpty: orderState.orderModels.isEmpty ? true : false,
                                          isSent: orderState.orderModels.map((item) => item.orderStatusType).toList(),
                                          sendBtnOnTap: (index) => showDialog(
                                            context: parentContext,
                                            builder: (context) => SendOrderDialog(
                                              orderModel: orderState.orderModels[index],
                                              orderSent: () {
                                                parentContext.orderBloc.add(OrderGetEvent());
                                              },
                                            ),
                                          ),
                                          createBtnOnTap: (index) => showDialog(
                                            context: parentContext,
                                            builder: (context) => CreateAnnouncementDialog(
                                              orderModel: orderState.orderModels[index],
                                              createOnTap: () => parentContext.announcementBloc.add(
                                                AnnouncementCreateEvent(
                                                  orderModel: orderState.orderModels[index],
                                                  employerName: context.currentUserBloc.state.userModel!.displayName,
                                                ),
                                              ),
                                            ),
                                          ),
                                          viewBtnOnTap: (index) => showDialog(
                                            context: context,
                                            builder: (context) => ViewOrderDialog(
                                              orderModel: orderState.orderModels[index],
                                            ),
                                          ),
                                          editBtnOnTap: (index) => showDialog(
                                            context: context,
                                            builder: (dialogContext) => EditOrderDialog(
                                              orderModel: orderState.orderModels[index],
                                              orderEdited: () => context.orderBloc.add(
                                                OrderGetEvent(),
                                              ),
                                            ),
                                          ),
                                          deleteBtnOnTap: (index) => context.orderBloc
                                              .add(OrderDeleteEvent(orderId: orderState.orderModels[index].id)),
                                          firstColumnValue: orderState.orderModels
                                              .map((orderModel) => orderModel.receiverName ?? 'Not selected yet')
                                              .toList(),
                                          secondColumnValue: orderState.orderModels
                                              .map((orderModel) => orderModel.createdDateTime.formatDDMMYY().toString())
                                              .toList(),
                                          thirdColumnValue: orderState.orderModels
                                              .map((orderModel) => orderModel.sentDateTime != null
                                                  ? orderModel.sentDateTime!.formatDDMMYY().toString()
                                                  : 'Not defined')
                                              .toList(),
                                          fourthColumnValue: orderState.orderModels
                                              .map((orderModel) => orderModel.orderStatusType.translate())
                                              .toList(),
                                          fifthColumnValue: orderState.orderModels
                                              .map((orderModel) => orderModel.employerName)
                                              .toList(),
                                        );
                                      });
                                    },
                                  ),
                                ),
                              );
                            else
                              return _NoAccessWidget();
                          }()),
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
                          (() {
                            if (currentUserState.userModel!.role == RoleType.announcementEmployer.translate() ||
                                currentUserState.userModel!.role == RoleType.announcementVerifyEmployer.translate())
                              return BlocListener<AnnouncementBloc, AnnouncementState>(
                                listener: (context, state) {
                                  if (state.status == AnnouncementStateStatus.error)
                                    showInfoMessage(state.message ?? 'Error happen', context);
                                  else if (state.status == AnnouncementStateStatus.deleted) {
                                    showInfoMessage(state.message ?? 'Deleted', context);
                                    context.announcementBloc.add(AnnouncementGetEvent());
                                  } else if (state.status == AnnouncementStateStatus.sent) {
                                    showInfoMessage(state.message ?? 'Sent', context);
                                    context.announcementBloc.add(AnnouncementGetEvent());
                                  } else if (state.status == AnnouncementStateStatus.edited)
                                    context.announcementBloc.add(AnnouncementGetEvent());
                                },
                                child: BlocBuilder<AnnouncementBloc, AnnouncementState>(
                                  builder: (context, state) {
                                    if (state.status == AnnouncementStateStatus.loading)
                                      return Center(
                                        child: Loader(
                                          width: 100,
                                          height: 100,
                                          color: active,
                                        ),
                                      );
                                    return AnnouncementDataTableWidget(
                                      isEmpty: state.announcementsModels.isEmpty,
                                      viewBtnOnTap: (index) => showDialog(
                                        context: context,
                                        builder: (context) => ViewAnnouncementDialog(
                                          announcementModel: state.announcementsModels[index],
                                        ),
                                      ),
                                      sendBtnOnTap: (index) => context.announcementBloc.add(
                                        AnnouncementSendEvent(
                                          announcementId: state.announcementsModels[index].id,
                                          receiverId: state.announcementsModels[index].receiverId ?? null,
                                        ),
                                      ),
                                      deleteBtnOnTap: (index) => context.announcementBloc.add(
                                          AnnouncementDeleteEvent(announcementId: state.announcementsModels[index].id)),
                                      inspectOnTap: (index) => Get.to(
                                        () => AnnouncementDonePage(
                                          announcementModel: state.announcementsModels[index],
                                          announcementDeclineOnTap: (String declineComment) =>
                                              context.announcementBloc.add(
                                            AnnouncementDeclineEvent(
                                                announcementId: state.announcementsModels[index].id,
                                                announcementStatusType: AnnouncementStatusType.declined,
                                                declineMessage: declineComment),
                                          ),
                                          announcementApprovedOnTap: () => context.announcementBloc.add(
                                            AnnouncementDeclineEvent(
                                              announcementId: state.announcementsModels[index].id,
                                              announcementStatusType: AnnouncementStatusType.approved,
                                            ),
                                          ),
                                        ),
                                      ),
                                      announcementsModels: state.announcementsModels,
                                    );
                                  },
                                ),
                              );
                            else
                              return _NoAccessWidget();
                          }()),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NoAccessWidget extends StatelessWidget {
  const _NoAccessWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          text: 'You do not have access to this section',
          size: context.textSizeXL,
          color: Colors.black,
          textAlign: TextAlign.center,
          weight: FontWeight.bold,
        ),
      ),
    );
  }
}
