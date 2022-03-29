import 'dart:convert';
import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

class ActiveContractWidget extends StatefulWidget {
  const ActiveContractWidget({Key? key}) : super(key: key);

  @override
  State<ActiveContractWidget> createState() => _ActiveContractWidgetState();
}

class _ActiveContractWidgetState extends State<ActiveContractWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyContractBloc, MyContractState>(
      builder: (context, myContractState) {
        if (myContractState.status == MyContractStateStatus.loading)
          return Column(
            children: [
              SizedBox(
                height: context.screenHeight / 2.8,
              ),
              Loader(
                width: 100,
                height: 100,
                color: active,
              ),
            ],
          );
        else if (myContractState.model == null)
          return Column(
            children: [
              SizedBox(
                height: context.screenHeight / 2.8,
              ),
              CustomText(
                text: 'You do not have any active contracts yet',
                color: Colors.black,
                weight: FontWeight.bold,
                size: context.textSizeXL,
              )
            ],
          );
        else
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Material(
                  clipBehavior: Clip.antiAlias,
                  shape: BeveledRectangleBorder(
                    side: BorderSide(
                      color: active.withOpacity(0.7),
                    ),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          myContractState.model!.contractName.toUpperCase(),
                          style: GoogleFonts.oleoScript(
                            height: 1.8,
                            fontWeight: FontWeight.normal,
                            fontSize: context.textSizeL,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            myContractState.model!.contractDescription,
                            style: GoogleFonts.oleoScript(
                              height: 1.8,
                              fontWeight: FontWeight.normal,
                              fontSize: context.textSizeL,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: myContractState.model!.contractItems.length,
                          padding: EdgeInsets.only(left: 30),
                          itemBuilder: (context, i) {
                            return ListTile(
                              title: Text(
                                ContractItemsType.getValue(myContractState.model!.contractItems[i]).translate(),
                                style: GoogleFonts.oleoScript(
                                  height: 0.7,
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Container(
                          width: context.screenWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(1.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  right: 35,
                                ),
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 25),
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(color: Colors.black38, width: 2.0),
                                        ),
                                      ),
                                      child: BlocBuilder<CurrentUserBloc, CurrentUserState>(
                                        builder: (context, currentUserState) {
                                          if (currentUserState.userModel!.contractSignature != null)
                                            return _imageBase64Decoded(currentUserState.userModel!.contractSignature!);
                                          else
                                            return Text(
                                              currentUserState.userModel!.contractSignature ?? ' ',
                                              style: GoogleFonts.oleoScript(
                                                fontSize: context.textSizeM,
                                              ),
                                            );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    CustomText(
                                      text: 'Your signature',
                                      size: context.textSizeS,
                                      color: Colors.black,
                                      weight: FontWeight.normal,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
            ],
          );
      },
    );
  }

  @override
  void initState() {
    print('getting new contract with id ${context.currentUserBloc.state.userModel!.contractId}');
    context.myContractBloc.add(MyContractGetCurrentEvent(contractId: context.currentUserBloc.state.userModel!.contractId));
    super.initState();
  }
}

dynamic _imageBase64Decoded(String base64String) {
  return Image.memory(base64Decode(base64String));
}
