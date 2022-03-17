import 'package:contract_management/_all.dart';
import 'package:contract_management/controllers/create_contracts_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_getx_widget.dart';

class CreateContractPage extends StatefulWidget {
  const CreateContractPage({
    Key? key,
  }) : super(key: key);

  @override
  _CreateContractPageState createState() => _CreateContractPageState();
}

class _CreateContractPageState extends State<CreateContractPage> {
  final contractController = Get.put(CreateContractsMenuController());

  @override
  void initState() {
    super.initState();
    //function is called when page is build
    WidgetsBinding.instance?.addPostFrameCallback((_) => contractController.changeActiveItemTo(allContracts));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContractsTemplateListBloc(contractsRepo: context.serviceProvider.contractsRepo)..add(ContractsTemplateListInitEvent()),
      child: BlocProvider(
        create: (context) => CreateContractBloc(contractsRepo: context.serviceProvider.contractsRepo),
        child: BlocListener<CreateContractBloc, CreateContractState>(
          listener: (context, state) {
            if (state.status == CreateContractStateStatus.error)
              showInfoMessage(state.errorMessage ?? 'Error happen', context);
            else if (state.status == CreateContractStateStatus.submitSuccessfully) {
              showInfoMessage('Successfully create new contract', context);
              context.contractsTemplateListBloc.add(ContractsTemplateListInitEvent());
            }
          },
          child: BlocListener<ContractsTemplateListBloc, ContractsTemplateListState>(
            listener: (context, state) {
              if (state.status == ContractsTemplateStateStatus.error) showInfoMessage(state.errorMessage ?? 'Error happen', context);
            },
            child: Container(
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
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  GetX<CreateContractsMenuController>(builder: (controller) {
                    return Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              controller.changeActiveItemTo(allContracts);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              // ignore: unrelated_type_equality_checks
                              color: controller.activeItem == allContracts ? Colors.purple.withOpacity(0.7) : Colors.white,
                              child: Text(
                                'All contracts',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: controller.activeItem.value == allContracts ? Colors.white : Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              controller.changeActiveItemTo(createContract);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              // ignore: unrelated_type_equality_checks
                              color: controller.activeItem == createContract ? Colors.purple.withOpacity(0.7) : Colors.white,
                              child: Text(
                                'Create contract',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: controller.activeItem.value == createContract ? Colors.white : Colors.black,
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
                  GetX<CreateContractsMenuController>(
                    builder: ((controller) {
                      if (controller.activeItem.value == allContracts)
                        return ListOfContracts();
                      else
                        return CreateContractWidget();
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
