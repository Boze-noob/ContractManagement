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
              title: '',
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 25),
                child: CustomText(
                  text: 'No companies to display',
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
            title: 'Select company to send order',
            child: Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DropdownButton(
                      value: companiesNames[0],
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: companiesNames.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) async {
                        //This should be in listener
                        Get.back();
                        int index = companiesNames.indexOf(newValue!);
                        context.orderBloc.add(OrderSendEvent(
                            orderId: orderModel.id,
                            receiverId: companiesIds[index],
                            receiverName: companiesNames[index]));

                        //Not good practice
                        await Future.delayed(Duration(milliseconds: 500));
                        //This should be in listener
                        orderSent();
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
