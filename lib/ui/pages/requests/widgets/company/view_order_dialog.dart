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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Sender name: ${orderModel.senderName.value}',
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
                text: 'Description: ${orderModel.description.value}',
                weight: FontWeight.normal,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: 'Create date time: ${orderModel.createdDateTime.formatDDMMYY().value}',
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
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Colors.black12.withOpacity(0.6),
              ),
              CustomText(text: 'Contract items:'),
              SizedBox(
                height: 5,
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: orderModel.contractItems.length,
                itemBuilder: (context, i) {
                  return ListTile(
                    title: Text(' - ' + orderModel.contractItems[i].translate()),
                  );
                },
              ),
              Divider(
                color: Colors.black12.withOpacity(0.6),
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: 'Employer name: ${orderModel.employerName.value}',
                weight: FontWeight.normal,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: 'Order status type: ${orderModel.orderStatusType.translate().value}',
                weight: FontWeight.normal,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: 'Admin request type: ${orderModel.adminRequestType.translate().value}',
                weight: FontWeight.normal,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: 'Client name: ${orderModel.clientName.value}',
                weight: FontWeight.normal,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: 'Price: ${orderModel.price.value} \$',
                weight: FontWeight.normal,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
