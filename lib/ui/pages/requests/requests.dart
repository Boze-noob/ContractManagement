import 'dart:ui';
import 'package:contract_management/_all.dart';

class RequestsPage extends StatefulWidget {
  const RequestsPage({Key? key}) : super(key: key);

  @override
  _RequestsPageState createState() => _RequestsPageState();
}

class _RequestsPageState extends State<RequestsPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RequestsBloc(request: context.serviceProvider.requestRepo)..add(RequestsLoadEvent()),
      child: BlocListener<RequestsBloc, RequestsState>(
        listener: (context, state) {
          if (state.status == RequestsStateStatus.error) showInfoMessage(state.errorMessage ?? 'Error happen', context);
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
                      BlocBuilder<RequestsBloc, RequestsState>(
                        builder: (context, state) {
                          return RequestsDataTableWidget(
                            firstColumnName: 'Display name',
                            secondColumnName: 'Email',
                            thirdColumnName: 'Location',
                            fourthColumnName: 'Date time',
                            action: 'View request',
                            fifthColumnName: '',
                            clientRequestsList: state.clientRequestModel,
                          );
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
