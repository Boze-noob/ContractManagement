import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class SendOrderDialog extends StatelessWidget {
  OrderModel orderModel;
  final void Function() orderSent;

  SendOrderDialog({Key? key, required this.orderModel, required this.orderSent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc(orderRepo: context.serviceProvider.orderRepo)
        ..add(OrderGetCompaniesForOrderEvent(contractItems: orderModel.contractItems)),
      child: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) async {
          if (state.status == OrderStateStatus.submitSuccessful) {
            orderSent();
            await Future.delayed(Duration(milliseconds: 200));
            Get.back();
          }
        },
        child: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, orderState) {
            if (orderState.status == OrderStateStatus.loading)
              return CustomDialog(
                buttonText: 'Close',
                title: '',
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                  child: Loader(
                    width: 50,
                    height: 50,
                    color: active,
                  ),
                ),
              );
            else if (orderState.companiesForOrder.isEmpty)
              return CustomDialog(
                buttonText: 'Close',
                title: 'Send order',
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                  child: CustomText(
                    text: 'No companies that match this order requirements',
                    size: context.textSizeXL,
                    color: Colors.black,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            List<String> companiesIds = orderState.companiesForOrder['companiesIds'];
            List<String> companiesNames = orderState.companiesForOrder['companiesName'];
            return CustomDialog(
              buttonText: 'Close',
              title: 'Send order',
              child: Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Order summary",
                              size: 20,
                              color: Colors.black38,
                              weight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            CustomText(
                              text: "Location: " + orderModel.orderLocation,
                              size: 18,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomText(
                              text: "Description: " + orderModel.description,
                              size: 18,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomText(
                              text: "Completion date time: " + orderModel.completionDateTime.formatDDMMYY(),
                              size: 18,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomText(
                              text: "Payment type: " + orderModel.paymentType.translate(),
                              size: 18,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomText(
                              text: "Price: " + orderModel.price,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "Choose company: ",
                              size: 20,
                              color: Colors.black38,
                              weight: FontWeight.bold,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            DropdownButton(
                              value: companiesNames[0],
                              icon: const Icon(Icons.keyboard_arrow_down),
                              style: TextStyle(fontSize: 18, color: active, fontWeight: FontWeight.bold),
                              items: companiesNames.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) async {
                                int index = companiesNames.indexOf(newValue!);
                                context.orderBloc.add(OrderSendEvent(
                                    orderId: orderModel.id,
                                    receiverId: companiesIds[index],
                                    receiverName: companiesNames[index]));
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
