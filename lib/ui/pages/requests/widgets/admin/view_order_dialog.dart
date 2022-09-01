import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ViewOrderDialog extends StatelessWidget {
  OrderModel orderModel;

  ViewOrderDialog({Key? key, required this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      buttonText: 'Close',
      title: 'Order details',
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CustomText(
                          text: 'Client name: ${orderModel.senderName.value}',
                          weight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: 'Receiver name: ${orderModel.receiverName.value}',
                          weight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: 'Order location: ${orderModel.orderLocation.value}',
                          weight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: 'Payment type: ${orderModel.paymentType.translate().value}',
                          weight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: 'Price: ${orderModel.price} KM',
                          weight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: 'Created date time: ${orderModel.createdDateTime.formatDDMMYY().value}',
                          weight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: 'Completion date time: ${orderModel.completionDateTime.formatDDMMYY().value}',
                          weight: FontWeight.normal,
                          color: Colors.black,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text:
                              'Sent date time: ${orderModel.sentDateTime != null ? orderModel.sentDateTime!.formatDDMMYY().toString() : 'Not defined yet'}',
                          weight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          text: 'Employer name: ${orderModel.employerName.value}',
                          weight: FontWeight.bold,
                          color: Colors.black,
                          size: 18,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: 'Order status type: ${orderModel.orderStatusType.translate().value}',
                          weight: FontWeight.bold,
                          color: Colors.black,
                          size: 18,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: 'Admin request type: ${orderModel.adminRequestType.translate().value}',
                          weight: FontWeight.bold,
                          color: Colors.black,
                          size: 18,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: 'Contract items:',
                          weight: FontWeight.bold,
                          color: Colors.black,
                          size: 18,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: orderModel.contractItems.length,
                          itemBuilder: (context, i) {
                            return ListTile(
                              title: CustomText(
                                text: ' - ' + orderModel.contractItems[i].translate(),
                                size: 18,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
