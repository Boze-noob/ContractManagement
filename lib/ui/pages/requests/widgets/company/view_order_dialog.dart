import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CompanyViewOrderDialog extends StatelessWidget {
  OrderModel orderModel;
  CompanyViewOrderDialog({Key? key, required this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      buttonText: 'Close',
      title: 'Order details',
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Flex(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment:
                ResponsiveWidget.isSmallScreen(context) ? MainAxisAlignment.start : MainAxisAlignment.spaceAround,
            direction: ResponsiveWidget.isSmallScreen(context) ? Axis.vertical : Axis.horizontal,
            children: [
              Flexible(
                fit: FlexFit.loose,
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Client name: ${orderModel.senderName.value}',
                      weight: FontWeight.normal,
                      color: Colors.black,
                      size: 18,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: 'Order location: ${orderModel.orderLocation.value}',
                      weight: FontWeight.normal,
                      color: Colors.black,
                      size: 18,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: 'Payment type: ${orderModel.paymentType.translate().value}',
                      weight: FontWeight.normal,
                      color: Colors.black,
                      size: 18,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: 'Description: ${orderModel.description.value}',
                      weight: FontWeight.normal,
                      color: Colors.black,
                      size: 18,
                    ),
                  ],
                ),
              ),
              Flexible(
                fit: FlexFit.loose,
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Create date time: ${orderModel.createdDateTime.formatDDMMYY().value}',
                      weight: FontWeight.normal,
                      color: Colors.black,
                      size: 18,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text:
                          'Sent date time: ${orderModel.sentDateTime != null ? orderModel.sentDateTime!.formatDDMMYY().toString() : 'Not defined yet'}',
                      weight: FontWeight.normal,
                      color: Colors.black,
                      size: 18,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: 'Employer name: ${orderModel.employerName.value}',
                      weight: FontWeight.normal,
                      color: Colors.black,
                      size: 18,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: 'Contract items:',
                      size: 18,
                    ),
                    SizedBox(
                      height: 5,
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
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: 'Price: ${orderModel.price.value} KM',
                      weight: FontWeight.normal,
                      color: Colors.black,
                      size: 18,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: 'Order status type: ${orderModel.orderStatusType.translate().value}',
                      weight: FontWeight.normal,
                      color: Colors.black,
                      size: 18,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: 'Request type: ${orderModel.adminRequestType.translate().value}',
                      weight: FontWeight.normal,
                      color: Colors.black,
                      size: 18,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
