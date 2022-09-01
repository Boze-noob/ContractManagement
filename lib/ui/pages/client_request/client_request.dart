import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

class ClientRequestPage extends StatelessWidget {
  ClientRequestPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

//TODO add validation
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        UserModel currentUser = context.currentUserBloc.state.userModel!;
        return ClientRequestBloc(clientsRepo: context.serviceProvider.clientsRepo)
          ..add(ClientRequestInitUserDataEvent(phoneNumber: currentUser.phoneNumber, location: currentUser.location));
      },
      child: BlocListener<ClientRequestBloc, ClientRequestState>(
        listener: (context, state) {
          if (state.status == ClientRequestStateStatus.error)
            showInfoMessage(state.errorMessage ?? 'Error happen', context);
          else if (state.status == ClientRequestStateStatus.submittedSuccessfully)
            showInfoMessage('You have successfully created request', context, duration: 4);
        },
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
            ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Container(
                      padding: EdgeInsets.all(50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: BlocBuilder<ClientRequestBloc, ClientRequestState>(
                        builder: (context, state) {
                          if (state.status == ClientRequestStateStatus.loading)
                            return Center(
                              child: Loader(
                                width: 100,
                                height: 100,
                                color: active,
                              ),
                            );
                          else
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                CustomText(
                                  text: 'Fill all fields',
                                  size: context.textSizeL,
                                  color: Colors.black,
                                  weight: FontWeight.bold,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                _RequestTypeWidget(),
                                SizedBox(
                                  height: 15,
                                ),
                                _DescriptionWidget(),
                                SizedBox(
                                  height: 15,
                                ),
                                _LocationWidget(),
                                SizedBox(
                                  height: 15,
                                ),
                                _PhoneNumberWidget(),
                                SizedBox(
                                  height: 30,
                                ),
                                _ButtonRowWidget(),
                              ],
                            );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _RequestTypeWidget extends StatefulWidget {
  _RequestTypeWidget({Key? key}) : super(key: key);

  @override
  State<_RequestTypeWidget> createState() => _RequestTypeWidgetState();
}

class _RequestTypeWidgetState extends State<_RequestTypeWidget> {
  var dropdownValue = RequestType.activate;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      SizedBox(
        width: 10,
      ),
      Container(
        width: 100,
        child: CustomText(
          text: 'Request type:',
          size: context.textSizeM,
          color: Colors.black,
        ),
      ),
      SizedBox(
        width: 20,
      ),
      BlocBuilder<ClientRequestBloc, ClientRequestState>(
        builder: (context, state) {
          return DropdownButton<RequestType>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            elevation: 16,
            style: TextStyle(color: active),
            underline: Container(
              height: 2,
              color: active,
            ),
            onChanged: (RequestType? pickedValue) {
              setState(() {
                dropdownValue = pickedValue!;
                context.clientRequestBloc.add(ClientRequestUpdateEvent(
                    clientRequestModel: state.requestModel.copyWith(requestType: pickedValue)));
              });
            },
            items: RequestType.values.map<DropdownMenuItem<RequestType>>((RequestType value) {
              return DropdownMenuItem<RequestType>(
                value: value,
                child: Text(
                  value.translate().toUpperCase(),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              );
            }).toList(),
          );
        },
      ),
    ]);
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Container(
          width: 100,
          child: CustomText(
            text: 'Description:',
            size: context.textSizeM,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: BlocBuilder<ClientRequestBloc, ClientRequestState>(
            builder: (context, state) {
              return TextFormField(
                initialValue: state.requestModel.description,
                onChanged: (text) => context.clientRequestBloc
                    .add(ClientRequestUpdateEvent(clientRequestModel: state.requestModel.copyWith(description: text))),
                style: TextStyle(
                  fontFamily: AppFonts.quicksandBold,
                  fontSize: 14,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                    fontFamily: AppFonts.quicksandRegular,
                  ),
                  border: OutlineInputBorder(),
                ),
                maxLines: 7,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _LocationWidget extends StatelessWidget {
  const _LocationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Container(
          width: 100,
          child: CustomText(
            text: 'Location:',
            size: context.textSizeM,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: BlocBuilder<ClientRequestBloc, ClientRequestState>(
            builder: (context, state) {
              return TextFormField(
                initialValue: context.currentUserBloc.state.userModel!.location,
                maxLength: 30,
                onChanged: (text) => context.clientRequestBloc
                    .add(ClientRequestUpdateEvent(clientRequestModel: state.requestModel.copyWith(location: text))),
                style: TextStyle(
                  fontFamily: AppFonts.quicksandBold,
                  fontSize: 14,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  labelText: 'Location',
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                    fontFamily: AppFonts.quicksandRegular,
                  ),
                  border: OutlineInputBorder(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _PhoneNumberWidget extends StatelessWidget {
  const _PhoneNumberWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 10,
        ),
        Container(
          width: 100,
          child: CustomText(
            text: 'Phone number:',
            size: context.textSizeM,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: BlocBuilder<ClientRequestBloc, ClientRequestState>(
            builder: (context, state) {
              return TextFormField(
                initialValue: context.currentUserBloc.state.userModel!.phoneNumber,
                maxLength: 16,
                onChanged: (text) => context.clientRequestBloc
                    .add(ClientRequestUpdateEvent(clientRequestModel: state.requestModel.copyWith(phoneNumber: text))),
                style: TextStyle(
                  fontFamily: AppFonts.quicksandBold,
                  fontSize: 14,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  labelText: 'Phone number',
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                    fontFamily: AppFonts.quicksandRegular,
                  ),
                  border: OutlineInputBorder(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ButtonRowWidget extends StatelessWidget {
  const _ButtonRowWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Button(
          child: Text(
            'Cancel',
            style: const TextStyle(
              fontSize: 14,
              fontFamily: AppFonts.quicksandBold,
              color: Color(0xFF9A9A9A),
            ),
          ),
          onTap: () => context.clientRequestBloc.add(ClientRequestInitEvent()),
          color: Colors.transparent,
          borderRadius: 20,
        ),
        SizedBox(
          height: 20,
        ),
        BlocBuilder<ClientRequestBloc, ClientRequestState>(
          builder: (context, state) {
            return Button(
                child: Text(
                  'Send',
                  style: TextStyle(fontSize: 14, fontFamily: AppFonts.quicksandBold, color: Colors.white),
                ),
                isLoading: state.status == ClientRequestStateStatus.submitting,
                color: active,
                borderRadius: 20,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                onTap: () {
                  context.clientRequestBloc.add(ClientRequestUpdateEvent(
                      clientRequestModel: state.requestModel
                          .copyWith(displayName: context.currentUserBloc.state.userModel!.displayName)));
                  context.clientRequestBloc.add(ClientRequestSubmitEvent());
                });
          },
        ),
      ],
    );
  }
}
