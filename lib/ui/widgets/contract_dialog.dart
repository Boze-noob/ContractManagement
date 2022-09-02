import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ContractDialog extends StatelessWidget {
  CreateContractModel createContractModel;
  ContractModel contractModel;

  ContractDialog({
    Key? key,
    required this.contractModel,
    required this.createContractModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      buttonText: 'Close',
      title: 'Contract details',
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Flex(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            direction: ResponsiveWidget.isSmallScreen(context) ? Axis.vertical : Axis.horizontal,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        text: "Contract name: " + createContractModel.contractName,
                        size: 18,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        text: "Contract description: " + createContractModel.contractDescription,
                        size: 18,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        text: "Contract items: ",
                        size: 18,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: createContractModel.contractItems.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            title: CustomText(
                              text:
                                  ' - ' + ContractItemsType.getValue(createContractModel.contractItems[i]).translate(),
                              size: 18,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      text: "Company name: " + contractModel.companyName,
                      size: 18,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: "Completion date time: " + contractModel.completionDateTime.formatDDMMYYHHMMSS(),
                      size: 18,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: "Contract status: " + contractModel.contractStatus.translate(),
                      size: 18,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
