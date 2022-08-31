import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';

class OverviewRequestsDataTableWidget extends StatelessWidget {
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
                    height: 20,
                  ),
                  CustomText(
                    text: 'No data to display',
                    size: context.textSizeL,
                    color: Colors.black,
                    weight: FontWeight.normal,
                  )
                ],
              ),
            );
          else {
            List<String>? firstColumnValue =
                state.clientRequestModel.map((clientModel) => clientModel.displayName).toList();
            List<String>? secondColumnValue = state.clientRequestModel.map((clientModel) => clientModel.email).toList();
            List<String>? thirdColumnValue =
                state.clientRequestModel.map((clientModel) => clientModel.location).toList();
            List<String>? fourthColumnValue = state.clientRequestModel
                .map((clientModel) => clientModel.createdDateTime.formatDDMMYYHHMMSS())
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
                    dataRowHeight: context.screenHeight / 13,
                    showCheckboxColumn: false,
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
                    ],
                    rows: List<DataRow>.generate(
                      firstColumnValue.length,
                      (index) => DataRow(
                        onSelectChanged: (isSelected) =>
                            showRequestDetailsDialog(context, state.clientRequestModel[index]),
                        cells: [
                          DataCell(
                            CustomText(text: firstColumnValue[index]),
                          ),
                          DataCell(
                            CustomText(text: secondColumnValue[index]),
                          ),
                          DataCell(
                            CustomText(
                              text: thirdColumnValue[index],
                            ),
                          ),
                          DataCell(
                            CustomText(
                              text: fourthColumnValue[index],
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

  Future showRequestDetailsDialog(BuildContext context, ClientRequestModel clientRequestModel) {
    return showDialog(
      context: context,
      builder: (context) => CustomDialog(
        buttonText: 'Close',
        title: 'Request details',
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            child: Flex(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              direction: ResponsiveWidget.isSmallScreen(context) ? Axis.vertical : Axis.horizontal,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      text: 'Display name : ' + clientRequestModel.displayName,
                      size: 18,
                      weight: FontWeight.normal,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: 'Phone number : ' + clientRequestModel.phoneNumber.value,
                      size: 18,
                      weight: FontWeight.normal,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: 'Email : ' + clientRequestModel.email,
                      size: 18,
                      weight: FontWeight.normal,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: 'Location : ' + clientRequestModel.location,
                      size: 18,
                      weight: FontWeight.normal,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      text: 'Description : ' + clientRequestModel.description.value,
                      size: 18,
                      weight: FontWeight.normal,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: 'Request type : ' + clientRequestModel.requestType.translate(),
                      size: 18,
                      weight: FontWeight.normal,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: 'Created date time : ' + clientRequestModel.createdDateTime.formatDDMMYYHHMMSS(),
                      size: 18,
                      weight: FontWeight.normal,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
