import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CreateAnnouncementDialog extends StatelessWidget {
  final OrderModel orderModel;
  final void Function() createOnTap;
  CreateAnnouncementDialog({
    Key? key,
    required this.orderModel,
    required this.createOnTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      buttonText: 'Create',
      onButtonPressed: () => createOnTap(),
      title: 'Announcement details',
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Order id: ${orderModel.id}',
                weight: FontWeight.normal,
                color: Colors.black,
              ),
              SizedBox(
                height: 10,
              ),
              CustomText(
                text: 'Receiver id: ${orderModel.receiverId.value}',
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
                text: 'Price: ${orderModel.price.value}',
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
            ],
          ),
        ),
      ),
    );
  }
}
