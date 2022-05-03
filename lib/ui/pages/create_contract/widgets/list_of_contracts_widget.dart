import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                              context.createContractBloc
                                  .add(CreateContractUpdateEvent(createContractModel: state.createContractModel[i]));
                            },
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          IconButton(
                            onPressed: () => showDialog(
                              context: context,
                              builder: (context) => Padding(
                                padding: EdgeInsets.symmetric(horizontal: 50),
                                child: CustomDialog(
                                  child: BlocProvider(
                                    create: (context) =>
                                        SendContractRequestBloc(contractsRepo: context.serviceProvider.contractsRepo),
                                    child: BlocProvider(
                                      create: (context) =>
                                          CompaniesBloc(companiesRepo: context.serviceProvider.companiesRepo)
                                            ..add(CompaniesGetCompaniesWithoutContract()),
                                      child: BlocBuilder<CompaniesBloc, CompaniesState>(
                                        builder: (context, companiesState) {
                                          return BlocListener<SendContractRequestBloc, SendContractRequestState>(
                                            listener: (context, state) async {
                                              if (state.status == SendContractRequestStateStatus.error)
                                                showInfoMessage(state.errorMessage ?? 'Error happen', context);
                                              else if (state.status ==
                                                  SendContractRequestStateStatus.successfullySubmitted) {
                                                showInfoMessage('Successfully sent', context);
                                                context.notificationsBloc.add(NotificationsSendEvent(
                                                    notificationModel: NotificationModel(
                                                  userId: state.contractRequestModel!.companyId,
                                                  message: 'You have new contract request',
                                                )));
                                                Get.back();
                                              }
                                            },
                                            child: Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.all(20.0),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: [
                                                    CustomText(
                                                      text: 'Pick company to which you want to send contract',
                                                      size: context.textSizeL,
                                                      weight: FontWeight.bold,
                                                      color: Colors.black,
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    ListView.builder(
                                                      shrinkWrap: true,
                                                      itemCount: companiesState.companies.length,
                                                      itemBuilder: (BuildContext context, int index) {
                                                        //It would be nice to make it as RadioListTile but for simplicity I used gesture detector
                                                        return GestureDetector(
                                                          onTap: () => context.sendContractRequestBloc.add(
                                                            SendContractRequestSubmitEvent(
                                                              contractRequestModel: ContractRequestModel(
                                                                contractId: state.createContractModel[i].contractName,
                                                                companyId: companiesState.companies[index].id,
                                                                message: 'We are sending you new contract',
                                                              ),
                                                            ),
                                                          ),
                                                          child: ListTile(
                                                            title: CustomText(
                                                              text: companiesState.companies[index].displayName,
                                                              size: context.textSizeM,
                                                              weight: FontWeight.bold,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            icon: Icon(Icons.send),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          IconButton(
                            onPressed: () => context.contractsTemplateListBloc.add(ContractsTemplateListDeleteEvent(
                                contractName: state.createContractModel[i].contractName)),
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
