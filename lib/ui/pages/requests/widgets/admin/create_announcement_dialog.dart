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
      title: 'Create announcement',
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          child: Flex(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            direction: ResponsiveWidget.isSmallScreen(context) ? Axis.vertical : Axis.horizontal,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Receiver name: ${orderModel.receiverName.value}',
                      weight: FontWeight.normal,
                      color: Colors.black,
                      size: 18,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: 'Payment type: ${orderModel.paymentType.translate()}',
                      weight: FontWeight.normal,
                      color: Colors.black,
                      size: 18,
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
                      text: 'Employer created order: ${orderModel.employerName}',
                      weight: FontWeight.normal,
                      color: Colors.black,
                      size: 18,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      text: 'Created date time: ${orderModel.createdDateTime.formatDDMMYY().value}',
                      weight: FontWeight.normal,
                      color: Colors.black,
                      size: 18,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: 'Completion date time: ${orderModel.completionDateTime.formatDDMMYY().value}',
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
                      physics: NeverScrollableScrollPhysics(),
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
        ),
      ),
    );
  }
}
