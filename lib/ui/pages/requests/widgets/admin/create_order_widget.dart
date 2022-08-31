import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

//TODO add completionDateTime create and view on order and announcement
class CreateOrderWidget extends StatefulWidget {
  final RequestsState requestState;
  final void Function() onCreate;

  const CreateOrderWidget({
    required this.requestState,
    required this.onCreate,
  }) : super();

  @override
  _CreateOrderWidgetState createState() => _CreateOrderWidgetState();
}

class _CreateOrderWidgetState extends State<CreateOrderWidget> {
  late PaymentType selectedPaymentTypeValue;
  late List<PaymentType> paymentTypesItems;
  late List<int> selectedContractItemsIndex;

  @override
  Widget build(BuildContext context) {
    return RequestsDataTableWidget(
      firstColumnName: 'Display name',
      secondColumnName: 'Email',
      thirdColumnName: 'Location',
      fourthColumnName: 'Date time',
      fifthColumnName: '',
      isEmpty: false,
      actionBtnTxt: 'Create order',
      firstColumnValue: widget.requestState.clientRequestModel.map((clientModel) => clientModel.displayName).toList(),
      secondColumnValue: widget.requestState.clientRequestModel.map((clientModel) => clientModel.email).toList(),
      thirdColumnValue: widget.requestState.clientRequestModel.map((clientModel) => clientModel.location).toList(),
      fourthColumnValue: widget.requestState.clientRequestModel
          .map((clientModel) => clientModel.createdDateTime.formatDDMMYYHHMMSS())
          .toList(),
      createOnTap: (index) => showDialog(
        context: context,
        builder: (context) => BlocProvider(
          create: (context) => RequestsBloc(companyRequest: context.serviceProvider.companyRequestRepo),
          child: BlocProvider(
            create: (context) {
              UserModel currentUser = context.currentUserBloc.state.userModel!;
              ClientRequestModel clientRequestModel = widget.requestState.clientRequestModel[index];
              return OrderBloc(orderRepo: context.serviceProvider.orderRepo)
                ..add(
                  OrderInitClientDataEvent(
                    employerName: currentUser.displayName,
                    senderName: clientRequestModel.displayName,
                    orderLocation: clientRequestModel.location,
                  ),
                );
            },
            child: Builder(builder: (context) {
              return CustomDialog(
                buttonText: 'Create',
                onButtonPressed: () async {
                  context.requestsBloc.add(RequestsDeleteEvent(id: widget.requestState.clientRequestModel[index].id));
                  context.orderBloc.add(
                    OrderCreateEvent(
                      clientName: widget.requestState.clientRequestModel[index].displayName,
                      description: widget.requestState.clientRequestModel[index].description,
                    ),
                  );
                  await Future.delayed(Duration(milliseconds: 500));
                  widget.onCreate();
                  selectedContractItemsIndex = List.empty();
                },
                title: 'Create order',
                child: Expanded(
                  child: StatefulBuilder(builder: (context, setState) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: BlocBuilder<OrderBloc, OrderState>(
                        builder: (context, state) {
                          ClientRequestModel clientRequestModel = widget.requestState.clientRequestModel[index];
                          return Container(
                            height: context.screenHeight / 1.5,
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                TextFormField(
                                  initialValue: clientRequestModel.displayName,
                                  onChanged: (text) => context.orderBloc
                                      .add(OrderUpdateEvent(orderModel: state.orderModel.copyWith(senderName: text))),
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Enter client name',
                                  ),
                                  maxLines: 1,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  initialValue: clientRequestModel.location,
                                  onChanged: (text) => context.orderBloc.add(
                                      OrderUpdateEvent(orderModel: state.orderModel.copyWith(orderLocation: text))),
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Enter order location',
                                  ),
                                  maxLines: 1,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    CustomText(
                                      text: 'Pick payment option',
                                      color: Colors.black,
                                      size: context.textSizeM,
                                      weight: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    DropdownButton(
                                      value: selectedPaymentTypeValue,
                                      icon: const Icon(Icons.keyboard_arrow_down),
                                      items: paymentTypesItems.map((PaymentType items) {
                                        return DropdownMenuItem(
                                          value: items,
                                          child: Text(items.translate()),
                                        );
                                      }).toList(),
                                      onChanged: (PaymentType? newValue) {
                                        setState(() {
                                          context.orderBloc.add(OrderUpdateEvent(
                                              orderModel: state.orderModel.copyWith(paymentType: newValue)));
                                          selectedPaymentTypeValue = newValue!;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                TextField(
                                  onChanged: (text) => context.orderBloc
                                      .add(OrderUpdateEvent(orderModel: state.orderModel.copyWith(price: text))),
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Enter price',
                                  ),
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    CustomText(
                                      text: 'Created date',
                                      color: Colors.black,
                                      size: context.textSizeM,
                                      weight: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    _DatePickerWidget(
                                      lastDateTime: DateTime.now(),
                                      onDateSelected: (dateTime) => context.orderBloc.add(OrderUpdateEvent(
                                          orderModel: state.orderModel.copyWith(createdDateTime: dateTime))),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    CustomText(
                                      text: 'Completion date',
                                      color: Colors.black,
                                      size: context.textSizeM,
                                      weight: FontWeight.bold,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    _DatePickerWidget(
                                      lastDateTime: DateTime(2030),
                                      onDateSelected: (dateTime) => context.orderBloc.add(OrderUpdateEvent(
                                          orderModel: state.orderModel.copyWith(completionDateTime: dateTime))),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                CustomText(
                                  text: 'Add contract item',
                                  color: Colors.black,
                                  size: context.textSizeM,
                                  weight: FontWeight.bold,
                                ),
                                ListView.builder(
                                    itemCount: ContractItemsType.values.length,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            if (selectedContractItemsIndex.contains(index)) {
                                              selectedContractItemsIndex = List.from(selectedContractItemsIndex)
                                                ..remove(index);
                                            } else {
                                              selectedContractItemsIndex = List.from(selectedContractItemsIndex)
                                                ..add(index);
                                            }
                                            context.orderBloc.add(OrderUpdateEvent(
                                                orderModel: state.orderModel.copyWith(
                                                    contractItems: selectedContractItemsIndex
                                                        .map((index) => ContractItemsType.getValue(index))
                                                        .toList())));
                                          });
                                        },
                                        child: ListTile(
                                          title: Text(ContractItemsType.getValue(index).translate()),
                                          tileColor: Colors.green.withOpacity(0.4),
                                          selected: selectedContractItemsIndex.contains(index) ? true : false,
                                        ),
                                      );
                                    }),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  enabled: false,
                                  decoration: InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Employer name',
                                  ),
                                  initialValue: context.currentUserBloc.state.userModel!.displayName,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ),
              );
            }),
          ),
        ),
      ),
      viewOnTap: (index) => showDialog(
        context: context,
        builder: (context) => CustomDialog(
          buttonText: 'Close',
          title: 'Request details',
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: 'Display name : ' + widget.requestState.clientRequestModel[index].displayName,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                  text: 'Phone number : ' + widget.requestState.clientRequestModel[index].phoneNumber.value,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                  text: 'Email : ' + widget.requestState.clientRequestModel[index].email,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                  text: 'Request type : ' + widget.requestState.clientRequestModel[index].requestType.translate(),
                  size: 18,
                  weight: FontWeight.bold,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                  text: 'Description : ' + widget.requestState.clientRequestModel[index].description.value,
                  size: 18,
                  weight: FontWeight.bold,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                  text: 'Location : ' + widget.requestState.clientRequestModel[index].location,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                  text: 'Created date time : ' +
                      widget.requestState.clientRequestModel[index].createdDateTime.formatDDMMYYHHMMSS(),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    selectedPaymentTypeValue = PaymentType.cash;
    paymentTypesItems = PaymentType.values;
    selectedContractItemsIndex = List.empty();
    super.initState();
  }
}

class _DatePickerWidget extends StatefulWidget {
  final void Function(DateTime dateTime) onDateSelected;
  final DateTime lastDateTime;

  _DatePickerWidget({required this.onDateSelected, required this.lastDateTime}) : super();

  @override
  State<_DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<_DatePickerWidget> {
  late DateTime selectedDateTime;
  late DateTime dateTimeTxtValue;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            title: Text(
              'Choose date',
              style: TextStyle(
                fontFamily: AppFonts.quicksandBold,
              ),
            ),
            content: Container(
              width: 300,
              height: 300,
              child: Theme(
                data: ThemeData(
                  colorScheme: ColorScheme.light(),
                ),
                child: BlocProvider(
                  create: (context) => OrderBloc(orderRepo: context.serviceProvider.orderRepo),
                  child: BlocBuilder<OrderBloc, OrderState>(
                    builder: (context, state) {
                      return CalendarDatePicker(
                        firstDate: DateTime(1960),
                        lastDate: widget.lastDateTime,
                        initialDate: selectedDateTime,
                        onDateChanged: (DateTime dateTime) {
                          setState(() {
                            selectedDateTime = dateTime;
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  dateTimeTxtValue = selectedDateTime;
                  widget.onDateSelected(selectedDateTime);
                  Navigator.pop(context);
                },
                child: Text(
                  'Select',
                  style: TextStyle(
                    fontSize: 17,
                    fontFamily: AppFonts.quicksandBold,
                  ),
                ),
              )
            ],
          );
        },
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                dateTimeTxtValue.formatDDMMYY().toString(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontFamily: AppFonts.quicksandRegular,
                ),
              ),
              const Icon(
                Icons.arrow_drop_down_sharp,
                color: Color(0xFF707070),
              ),
              const SizedBox(height: 10),
              Line.horizontal(
                color: Colors.grey,
                thickness: 0.5,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    selectedDateTime = DateTime.now();
    dateTimeTxtValue = DateTime.now();
    super.initState();
  }
}
