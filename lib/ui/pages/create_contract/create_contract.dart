import 'dart:ui';
import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';
import 'package:contract_management/blocs/navigator/navigator_state.dart' as navigatorState;

class CreateContractPage extends StatefulWidget {
  const CreateContractPage({
    Key? key,
  }) : super(key: key);

  @override
  _CreateContractPageState createState() => _CreateContractPageState();
}

class _CreateContractPageState extends State<CreateContractPage> {
  @override
  Widget build(BuildContext context) {
    //Mainly we used getX for navigation but in this case I wanted to try with bloc
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NavigatorBloc(),
        ),
        BlocProvider(
          create: (context) => CreateContractBloc(contractsRepo: context.serviceProvider.contractsRepo),
        ),
        BlocProvider(
          create: (context) => ContractsTemplateListBloc(contractsRepo: context.serviceProvider.contractsRepo)
            ..add(
              ContractsTemplateListInitEvent(),
            ),
        ),
      ],
      child: BlocListener<CreateContractBloc, CreateContractState>(
        listener: (context, state) {
          if (state.status == CreateContractStateStatus.error)
            showInfoMessage(state.errorMessage ?? 'Error happen', context);
          else if (state.status == CreateContractStateStatus.successfullySubmitted) {
            showInfoMessage('Successfully create new contract', context);
            context.contractsTemplateListBloc.add(ContractsTemplateListInitEvent());
          }
        },
        child: BlocListener<ContractsTemplateListBloc, ContractsTemplateListState>(
          listener: (context, state) {
            if (state.status == ContractsTemplateStateStatus.error)
              showInfoMessage(state.errorMessage ?? 'Error happen', context);
          },
          child: Container(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(
                dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                },
              ),
              child: ListView(
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
                  BlocBuilder<NavigatorBloc, navigatorState.NavigatorState>(
                    builder: (context, state) {
                      return Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                context.navigatorBloc.add(NavigatorUpdateEvent(0));
                                context.createContractBloc.add(CreateContractInitEvent());
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                // ignore: unrelated_type_equality_checks
                                color: state.index == 0 ? Colors.purple.withOpacity(0.7) : Colors.white,
                                child: Text(
                                  'All contracts',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: state.index == 0 ? Colors.white : Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                context.navigatorBloc.add(NavigatorUpdateEvent(1));
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                // ignore: unrelated_type_equality_checks
                                color: state.index == 1 ? Colors.purple.withOpacity(0.7) : Colors.white,
                                child: Text(
                                  'Create contract',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: state.index == 1 ? Colors.white : Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  BlocBuilder<NavigatorBloc, navigatorState.NavigatorState>(
                    builder: (context, state) {
                      if (state.index == 0)
                        return ListOfContracts();
                      else
                        return CreateContractWidget();
                    },
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
