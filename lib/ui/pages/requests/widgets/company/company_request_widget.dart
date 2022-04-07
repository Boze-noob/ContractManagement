import 'dart:ui';
import 'package:contract_management/_all.dart';
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
        ..add(CompanyGetOrderRequestsEvent(receiverId: context.currentUserBloc.state.userModel!.id)),
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
                    BlocListener<CompanyRequestsBloc, CompanyRequestsState>(
                      listener: (context, state) {
                        if (state.status == CompanyRequestsStateStatus.editSuccessful) {
                          showInfoMessage(state.message ?? 'Edit successful', context);
                          context.companyRequestsBloc.add(
                              CompanyGetOrderRequestsEvent(receiverId: context.currentUserBloc.state.userModel!.id));
                        }
                      },
                      child: BlocBuilder<CompanyRequestsBloc, CompanyRequestsState>(
                        builder: (parentContext, companyRequestsState) {
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
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
