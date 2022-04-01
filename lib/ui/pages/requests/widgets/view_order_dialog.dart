import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

class ViewOrderDialog extends StatelessWidget {
  OrderModel orderModel;
  ViewOrderDialog({Key? key, required this.orderModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      buttonText: 'Close',
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: CustomText(
                  text: 'Order details',
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
                text: 'Create date time: ${orderModel.createdDateTime.formatDDMMYY().value}',
                weight: FontWeight.normal,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: 'Sent date time: ${orderModel.sentDateTime != null ? orderModel.sentDateTime!.formatDDMMYY().toString() : 'Not defined yet'}',
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
            ],
          ),
        ),
      ),
    );
  }
}
