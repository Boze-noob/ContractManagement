import 'dart:ui';
import 'package:contract_management/_all.dart';

class CompanyRequestWidget extends StatefulWidget {
  const CompanyRequestWidget({Key? key}) : super(key: key);

  @override
  _CompanyRequestWidgetState createState() => _CompanyRequestWidgetState();
}

class _CompanyRequestWidgetState extends State<CompanyRequestWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CompanyRequestsBloc(requestRepo: context.serviceProvider.requestRepo)..add(CompanyRequestsGetEvent(companyId: context.currentUserBloc.state.userModel!.id)),
      child: BlocListener<CompanyRequestsBloc, CompanyRequestsState>(
        listener: (context, state) {
          if (state.status == CompanyRequestsStateStatus.error) showInfoMessage(state.errorMessage ?? 'Error happen', context);
        },
        child: BlocBuilder<CompanyRequestsBloc, CompanyRequestsState>(
          builder: (context, state) {
            if (state.model == null)
              return Center(
                child: CustomText(
                  text: 'You do not have requests',
                  size: context.textSizeXL,
                  color: active,
                  textAlign: TextAlign.center,
                  weight: FontWeight.bold,
                ),
              );
            return Container(
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
                          BlocBuilder<CompanyRequestsBloc, CompanyRequestsState>(
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
            );
          },
        ),
      ),
    );
  }
}
