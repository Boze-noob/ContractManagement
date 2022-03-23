import 'dart:ui';
import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';

class ContractsPage extends StatefulWidget {
  const ContractsPage({
    Key? key,
  }) : super(key: key);

  @override
  _ContractsPageState createState() => _ContractsPageState();
}

class _ContractsPageState extends State<ContractsPage> {
  final contractController = Get.put(ContractsMenuController());

  @override
  void initState() {
    super.initState();
    //function is called when page is build
    WidgetsBinding.instance?.addPostFrameCallback((_) => contractController.changeActiveItemTo(activeContracts));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContractsBloc(contractsRepo: context.serviceProvider.contractsRepo)
        ..add(
          ContractsLoadEvent(contractType: ContractType.active),
        ),
      child: BlocConsumer<ContractsBloc, ContractsState>(
        listener: (context, state) {
          if (state.status == ContractsStateStatus.error) showInfoMessage(state.errorMessage ?? 'Error happen', context);
        },
        builder: (context, state) {
          return Container(
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
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                GetX<ContractsMenuController>(builder: (controller) {
                  return Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            controller.changeActiveItemTo(activeContracts);
                            context.contractsBloc.add(ContractsLoadEvent(contractType: ContractType.getValue(0)));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            // ignore: unrelated_type_equality_checks
                            color: controller.activeItem == activeContracts ? Colors.purple.withOpacity(0.7) : Colors.white,
                            child: Text(
                              'Active contracts',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: controller.activeItem.toString() == activeContracts ? Colors.white : Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            controller.changeActiveItemTo(completedContracts);
                            context.contractsBloc.add(ContractsLoadEvent(contractType: ContractType.getValue(1)));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            // ignore: unrelated_type_equality_checks
                            color: controller.activeItem == completedContracts ? Colors.purple.withOpacity(0.7) : Colors.white,
                            child: Text(
                              'Completed contracts',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: controller.activeItem.toString() == completedContracts ? Colors.white : Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            controller.changeActiveItemTo(terminatedContracts);
                            context.contractsBloc.add(ContractsLoadEvent(contractType: ContractType.getValue(2)));
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            // ignore: unrelated_type_equality_checks
                            color: controller.activeItem == terminatedContracts ? Colors.purple.withOpacity(0.7) : Colors.white,
                            child: Text(
                              'Terminated contracts',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: controller.activeItem.toString() == terminatedContracts ? Colors.white : Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                    }),
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        DataTableWidget(
                          firstColumnName: 'Name',
                          secondColumnName: 'Client',
                          thirdColumnName: 'Location',
                          fourthColumnName: 'Company',
                          fifthColumnName: 'Action',
                          action: 'View',
                          dataList: state.contracts,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
