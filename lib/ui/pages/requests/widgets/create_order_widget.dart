import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

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
      fourthColumnValue: widget.requestState.clientRequestModel.map((clientModel) => clientModel.createdDateTime.toLocal().toString()).toList(),
      createOnTap: (index) => showDialog(
        context: context,
        builder: (context) => BlocProvider(
          create: (context) => OrderBloc(orderRepo: context.serviceProvider.orderRepo),
          child: Builder(builder: (context) {
            return BlocListener<OrderBloc, OrderState>(
              listener: (context, state) {
                if (state.status == OrderStateStatus.submitSuccessful) widget.onCreate();
              },
              child: CustomDialog(
                buttonText: 'Create',
                onButtonPressed: () => context.orderBloc.add(OrderCreateEvent(clientName: widget.requestState.clientRequestModel[index].displayName)),
                child: StatefulBuilder(builder: (context, setState) {
                  return Container(
                    child: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: BlocBuilder<OrderBloc, OrderState>(
                          builder: (context, state) {
                            context.orderBloc.add(OrderUpdateEvent(orderModel: state.orderModel.copyWith(employerName: context.currentUserBloc.state.userModel!.displayName)));
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      text: 'Fill order fields',
                                      weight: FontWeight.bold,
                                      color: Colors.black,
                                      paddingAllValue: 20,
                                      size: context.textSizeXL,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                TextField(
                                  onChanged: (text) => context.orderBloc.add(OrderUpdateEvent(orderModel: state.orderModel.copyWith(senderName: text))),
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Enter sender name',
                                  ),
                                  maxLines: 1,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                TextField(
                                  onChanged: (text) => context.orderBloc.add(OrderUpdateEvent(orderModel: state.orderModel.copyWith(orderLocation: text))),
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
                                          context.orderBloc.add(OrderUpdateEvent(orderModel: state.orderModel.copyWith(paymentType: newValue)));
                                          selectedPaymentTypeValue = newValue!;
                                        });
                                      },
                                    ),
                                  ],
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
                                      onDateSelected: (dateTime) => context.orderBloc.add(OrderUpdateEvent(orderModel: state.orderModel.copyWith(createdDateTime: dateTime))),
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
                                              selectedContractItemsIndex = List.from(selectedContractItemsIndex)..remove(index);
                                            } else {
                                              selectedContractItemsIndex = List.from(selectedContractItemsIndex)..add(index);
                                            }
                                            context.orderBloc.add(OrderUpdateEvent(orderModel: state.orderModel.copyWith(contractItems: selectedContractItemsIndex.map((index) => ContractItemsType.getValue(index)).toList())));
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
                                    labelText: 'Enter employer name',
                                  ),
                                  initialValue: context.currentUserBloc.state.userModel!.displayName,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                  ),
                                  maxLines: 1,
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  );
                }),
              ),
            );
          }),
        ),
      ),
      viewOnTap: (index) => showDialog(
        context: context,
        builder: (context) => CustomDialog(
          buttonText: 'Close',
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: 'Request details',
                  size: context.textSizeXL,
                  color: Colors.black,
                  textAlign: TextAlign.center,
                  weight: FontWeight.bold,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                  text: 'Client email : ' + widget.requestState.clientRequestModel[index].email,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                  text: 'Display name : ' + widget.requestState.clientRequestModel[index].displayName,
                ),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                  text: 'Request type : ' + widget.requestState.clientRequestModel[index].requestType.translate(),
                ),
                SizedBox(
                  height: 10,
                ),
                CustomText(
                  text: 'Description : ' + widget.requestState.clientRequestModel[index].description.value,
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
                  text: 'Created date time : ' + widget.requestState.clientRequestModel[index].createdDateTime.toString(),
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
  _DatePickerWidget({
    required this.onDateSelected,
  }) : super();

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
                        lastDate: DateTime.now(),
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
