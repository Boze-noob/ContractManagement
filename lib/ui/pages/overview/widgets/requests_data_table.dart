import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';

class OverviewRequestsDataTableWidget extends StatelessWidget {
  late final List<String>? firstColumnValue;
  late final List<String>? secondColumnValue;
  late final List<String>? thirdColumnValue;
  late final List<String>? fourthColumnValue;
  late final List<String>? fifthColumnValue;

  OverviewRequestsDataTableWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RequestsBloc(companyRequest: context.serviceProvider.companyRequestRepo)
        ..add(
          RequestsLoadEvent(),
        ),
      child: BlocBuilder<RequestsBloc, RequestsState>(
        builder: (context, state) {
          if (state.status == RequestsStateStatus.loading)
            return Loader(
              width: 50,
              height: 50,
              color: active,
            );
          else if (state.clientRequestModel.isEmpty)
            return CustomText(
              text: 'No data to display',
              size: context.textSizeXL,
              color: Colors.black,
              weight: FontWeight.bold,
            );
          else {
            firstColumnValue = state.clientRequestModel.map((clientModel) => clientModel.displayName).toList();
            secondColumnValue = state.clientRequestModel.map((clientModel) => clientModel.email).toList();
            thirdColumnValue = state.clientRequestModel.map((clientModel) => clientModel.location).toList();
            fourthColumnValue = state.clientRequestModel
                .map((clientModel) => clientModel.createdDateTime.toLocal().toString())
                .toList();
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: active.withOpacity(.4), width: .5),
                boxShadow: [BoxShadow(offset: Offset(0, 6), color: lightGrey.withOpacity(.1), blurRadius: 12)],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.all(16),
              margin: EdgeInsets.only(bottom: 30),
              child: Column(
                children: [
                  CustomText(
                    text: 'Client requests',
                    size: context.textSizeXL,
                    color: Colors.black,
                    weight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  DataTable2(
                    columnSpacing: 12,
                    horizontalMargin: 12,
                    minWidth: 600,
                    columns: [
                      DataColumn2(
                        label: Text('Display name'),
                        size: ColumnSize.L,
                      ),
                      DataColumn(
                        label: Text('Email'),
                      ),
                      DataColumn(
                        label: Text('Location'),
                      ),
                      DataColumn(
                        label: Text('Date time'),
                      ),
                      DataColumn(
                        label: Text(' '),
                      ),
                    ],
                    rows: List<DataRow>.generate(
                      firstColumnValue!.length,
                      (index) => DataRow(
                        cells: [
                          DataCell(
                            CustomText(text: firstColumnValue![index]),
                          ),
                          DataCell(
                            CustomText(text: secondColumnValue![index]),
                          ),
                          DataCell(
                            CustomText(
                              text: thirdColumnValue![index],
                            ),
                          ),
                          DataCell(
                            CustomText(
                              text: fourthColumnValue![index],
                            ),
                          ),
                          DataCell(
                            Button(
                              text: 'View',
                              textColor: active,
                              borderRadius: 20,
                              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                              borderColor: active,
                              //TOD add func
                              onTap: () => showDialog(
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
                                          text: 'Client email : ' + state.clientRequestModel[index].email,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomText(
                                          text: 'Display name : ' + state.clientRequestModel[index].displayName,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomText(
                                          text: 'Request type : ' +
                                              state.clientRequestModel[index].requestType.translate(),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomText(
                                          text: 'Description : ' + state.clientRequestModel[index].description.value,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomText(
                                          text: 'Location : ' + state.clientRequestModel[index].location,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        CustomText(
                                          text: 'Created date time : ' +
                                              state.clientRequestModel[index].createdDateTime.toString(),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
