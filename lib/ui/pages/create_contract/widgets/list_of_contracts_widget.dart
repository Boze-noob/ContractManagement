import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

class ListOfContracts extends StatelessWidget {
  ListOfContracts() : super();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateContractBloc, CreateContractState>(
      listener: (context, state) {
        if (state.status == CreateContractStateStatus.updated) context.navigatorBloc.add(NavigatorUpdateEvent(1));
      },
      child: BlocListener<ContractsTemplateListBloc, ContractsTemplateListState>(
        listener: (context, state) {
          if (state.status == ContractsTemplateStateStatus.successfullyDeleted) {
            showInfoMessage('Successfully deleted', context);
            context.contractsTemplateListBloc.add(ContractsTemplateListInitEvent());
          }
        },
        child: BlocBuilder<ContractsTemplateListBloc, ContractsTemplateListState>(
          builder: (context, state) {
            if (state.status == ContractsTemplateStateStatus.initializing)
              return Column(
                children: [
                  SizedBox(
                    height: context.screenHeight / 3,
                  ),
                  Loader(
                    width: 100,
                    height: 100,
                    color: active,
                  ),
                ],
              );
            else {
              if (state.createContractModel.isNotEmpty)
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.createContractModel.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text(state.createContractModel[i].contractName),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            onPressed: () {
                              context.createContractBloc.add(CreateContractUpdateEvent(createContractModel: state.createContractModel[i]));
                            },
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          IconButton(
                            onPressed: () => context.contractsTemplateListBloc.add(ContractsTemplateListDeleteEvent(contractName: state.createContractModel[i].contractName)),
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  },
                );
              else
                return Column(
                  children: [
                    SizedBox(
                      height: context.screenHeight / 3,
                    ),
                    CustomText(
                      text: 'No data',
                      size: context.textSizeL,
                      color: Colors.black,
                      weight: FontWeight.bold,
                    ),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}
