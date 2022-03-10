import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';

class Clientstable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: active.withOpacity(.4), width: .5),
        boxShadow: [BoxShadow(offset: Offset(0, 6), color: lightGrey.withOpacity(.1), blurRadius: 12)],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 30),
      child: BlocListener<ClientsBloc, ClientsState>(
        listener: (context, state) {
          if (state.status == ClientsStateStatus.error) {
            showInfoMessage('Error happen', context);
          } else if (state.status == ClientsStateStatus.deletedSuccessfully) {
            showInfoMessage('Deleted successfully', context);
          }
        },
        child: BlocBuilder<ClientsBloc, ClientsState>(
          builder: (context, state) {
            if (state.status == ClientsStateStatus.loading)
              return Loader();
            else
              return DataTable2(
                columnSpacing: 12,
                horizontalMargin: 12,
                minWidth: 700,
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
                  DataColumn(
                    label: Text(''),
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
                      DataCell(Row(
                        children: [
                          Button(
                            child: CustomText(
                              text: 'View',
                            ),
                            textColor: black,
                            shrinkWrap: true,
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
                      )),
                    ],
                  ),
                ),
              );
          },
        ),
      ),
    );
  }
}
