import 'dart:ui';
import 'package:contract_management/_all.dart';

class AdminRequestWidget extends StatefulWidget {
  const AdminRequestWidget({Key? key}) : super(key: key);

  @override
  _AdminRequestWidgetState createState() => _AdminRequestWidgetState();
}

class _AdminRequestWidgetState extends State<AdminRequestWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminRequestsBloc(requestRepo: context.serviceProvider.requestRepo)..add(AdminRequestsGetEvent(companyId: context.currentUserBloc.state.userModel!.id)),
      child: BlocListener<AdminRequestsBloc, AdminRequestsState>(
        listener: (context, state) {
          if (state.status == AdminRequestsStateStatus.error) showInfoMessage(state.errorMessage ?? 'Error happen', context);
        },
        child: Container(
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
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                    PointerDeviceKind.touch,
                    PointerDeviceKind.mouse,
                  }),
                  child: ListView(
                    children: [
                      BlocBuilder<AdminRequestsBloc, AdminRequestsState>(
                        builder: (context, state) {
                          //TODO add table here
                          return Container(
                            child: Text('Hello world'),
                          );
                          /*
                          return RequestsDataTableWidget(
                            firstColumnName: 'Display name',
                            secondColumnName: 'Email',
                            thirdColumnName: 'Location',
                            fourthColumnName: 'Date time',
                            action: 'View request',
                            fifthColumnName: '',
                            clientRequestsList: state.clientRequestModel,
                          );

                           */
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
