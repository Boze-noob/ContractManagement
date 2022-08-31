import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';

class Clientstable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClientsBloc, ClientsState>(
      listener: (context, state) {
        if (state.status == ClientsStateStatus.error) {
          showInfoMessage(state.errorMessage ?? 'Error happen', context);
        } else if (state.status == ClientsStateStatus.deletedSuccessfully) {
          showInfoMessage('Deleted successfully', context);
        }
      },
      builder: (context, state) {
        if (state.status == ClientsStateStatus.loading)
          return Loader();
        else if (state.clients.isNotEmpty)
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: active.withOpacity(.4), width: .5),
              boxShadow: [BoxShadow(offset: Offset(0, 6), color: lightGrey.withOpacity(.1), blurRadius: 12)],
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(16),
            margin: EdgeInsets.only(bottom: 30),
            child: DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 700,
              dataRowHeight: context.screenHeight / 13,
              columns: [
                DataColumn2(
                  label: Text("Name"),
                  size: ColumnSize.L,
                ),
                DataColumn(
                  label: Text('Location'),
                ),
                DataColumn(
                  label: Text('Rating'),
                ),
                DataColumn2(
                  label: Text(''),
                  size: ColumnSize.L,
                ),
              ],
              rows: List<DataRow>.generate(
                state.clients.length,
                (index) => DataRow(
                  cells: [
                    DataCell(
                      CustomText(text: state.clients[index].displayName),
                    ),
                    DataCell(
                      CustomText(text: state.clients[index].location),
                    ),
                    DataCell(
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.deepOrange,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          CustomText(
                            text: state.clients[index].rating ?? 'Default',
                          )
                        ],
                      ),
                    ),
                    DataCell(
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Row(
                          children: [
                            Button(
                              child: CustomText(
                                text: 'View',
                              ),
                              textColor: black,
                              shrinkWrap: true,
                              borderRadius: 40,
                              onTap: () => showDialog(
                                context: context,
                                builder: (context) => CustomDialog(
                                  buttonText: 'Close',
                                  title: 'Client details',
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 55),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomText(
                                          text: 'Display name: ' + state.clients[index].displayName,
                                          size: context.textSizeM,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        CustomText(
                                          text: 'Email: ' + state.clients[index].email,
                                          size: context.textSizeM,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        CustomText(
                                          text: 'Role: ' + state.clients[index].role,
                                          size: context.textSizeM,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        CustomText(
                                          text: 'Phone number: ',
                                          size: context.textSizeM,
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Button(
                              child: CustomText(
                                text: 'Delete',
                                color: delete,
                              ),
                              shrinkWrap: true,
                              borderRadius: 40,
                              onTap: () => context.clientsBloc.add(
                                ClientsDeleteEvent(clientId: state.clients[index].id),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        return Container(
          child: CustomText(
            text: 'No clients yet',
            size: context.textSizeXL,
            weight: FontWeight.bold,
          ),
        );
      },
    );
  }
}
