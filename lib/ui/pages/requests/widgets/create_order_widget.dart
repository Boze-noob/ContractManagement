import 'dart:ui';

import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

class CreateOrderWidget extends StatefulWidget {
  final RequestsState requestState;
  const CreateOrderWidget({
    required this.requestState,
  }) : super();

  @override
  _CreateOrderWidgetState createState() => _CreateOrderWidgetState();
}

class _CreateOrderWidgetState extends State<CreateOrderWidget> {
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
      onTap: () => showDialog(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
          return CustomDialog(
            buttonText: 'Create',
            child: StatefulBuilder(builder: (context, setState) {
              PaymentType paymentTypeValue = PaymentType.cash;
              List<PaymentType> paymentTypesItems = PaymentType.values;
              List<int> selectedContractItems = List.empty();
              return Container(
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
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
                              value: paymentTypeValue,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: paymentTypesItems.map((PaymentType items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items.translate()),
                                );
                              }).toList(),
                              onChanged: (PaymentType? newValue) {
                                setState(() {
                                  print('We change payment option');
                                  print('We selected $newValue');
                                  paymentTypeValue = newValue!;
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
                            _DatePickerWidget(),
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
                                    if (selectedContractItems.contains(index))
                                      List.from(selectedContractItems)..remove(index);
                                    else
                                      List.from(selectedContractItems)..add(index);
                                  });
                                },
                                child: ListTile(
                                  title: Text(ContractItemsType.getValue(index).translate()),
                                  selectedTileColor: Colors.green.withOpacity(0.4),
                                  selected: selectedContractItems.contains(index) ? true : false,
                                ),
                              );
                            }),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Enter employer name',
                          ),
                          initialValue: context.currentUserBloc.state.userModel!.displayName,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ),
    );
  }
}

class _DatePickerWidget extends StatefulWidget {
  _DatePickerWidget({Key? key}) : super(key: key);

  @override
  State<_DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<_DatePickerWidget> {
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
                child: CalendarDatePicker(
                  firstDate: DateTime(1960),
                  lastDate: DateTime.now(),
                  initialDate: DateTime.now(),
                  onDateChanged: (DateTime dateTime) {},
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
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
                DateTime.now().formatDDMMYY().toString(),
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
}
