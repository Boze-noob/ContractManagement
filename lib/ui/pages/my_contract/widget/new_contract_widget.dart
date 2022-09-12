import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

class NewContractWidget extends StatefulWidget {
  const NewContractWidget({Key? key}) : super(key: key);

  @override
  _NewContractWidgetState createState() => _NewContractWidgetState();
}

class _NewContractWidgetState extends State<NewContractWidget> {
  @override
  Widget build(BuildContext context) {
    var signatureImage;
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DeleteContractRequestBloc(context.serviceProvider.contractsRepo),
        ),
      ],
      child: BlocListener<MyContractBloc, MyContractState>(
        listener: (context, state) {
          if (state.status == MyContractStateStatus.contractAccepted) {
            showInfoMessage('Contract has been accepted', context);
            context.currentUserBloc.add(CurrentUserGetEvent());
          }
        },
        child: BlocBuilder<MyContractBloc, MyContractState>(
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
                    text: 'No contract requests',
                    weight: FontWeight.bold,
                    color: Colors.black,
                    size: context.textSizeXL,
                  ),
                ],
              );
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
                                  child: SignaturePad(
                                    width: 200,
                                    height: 50,
                                    penStrokeWidth: 2,
                                    onChange: (image) {
                                      signatureImage = image;
                                    },
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
                Button(
                  text: 'Accept',
                  shrinkWrap: true,
                  color: active,
                  textColor: Colors.white,
                  borderRadius: 20,
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
                  onTap: () {
                    if (signatureImage == null)
                      showInfoMessage('Please sign the contract', context);
                    else {
                      //Better to do via streamSubscription maybe
                      context.myContractBloc.add(
                        MyContractAcceptRequestEvent(
                          companyId: context.currentUserBloc.state.userModel!.id,
                          contractId: myContractState.model!.contractName,
                          signatureImg: signatureImage,
                          companyName: context.currentUserBloc.state.userModel!.displayName,
                        ),
                      );
                      context.deleteContractRequestBloc.add(
                          DeleteContractRequestDeleteEvent(companyId: context.currentUserBloc.state.userModel!.id));
                      context.notificationsBloc
                          .add(NotificationsDeleteEvent(userId: context.currentUserBloc.state.userModel!.id));
                    }
                  },
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    context.myContractBloc.add(
      MyContractGetRequestEvent(companyId: context.currentUserBloc.state.userModel!.id),
    );
    super.initState();
  }
}
