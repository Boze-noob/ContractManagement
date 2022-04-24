import 'package:contract_management/_all.dart';
import 'dart:ui';

class OverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContractsCounterBloc(
        contractsRepo: context.serviceProvider.contractsRepo,
      )..add(
          ContractsCounterLoadEvent(),
        ),
      child: BlocListener<RevenueBloc, RevenueState>(
        listener: (context, state) {
          if (state.status == RevenueStateStatus.error)
            showInfoMessage(state.errorMessage ?? 'Error happen', context);
          else if (state.status == RevenueStateStatus.loaded) {
            if (context.currentUserBloc.state.userModel!.role != RoleType.client.translate() &&
                context.currentUserBloc.state.userModel!.role != RoleType.company.translate())
              InspectRevenue.checkRevenueDates(context.revenueBloc.state.revenueModel, context);
          }
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
                        )),
                  ],
                ),
              ),
              Expanded(
                  child: ScrollConfiguration(
                behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
                  PointerDeviceKind.touch,
                  PointerDeviceKind.mouse,
                }),
                child: BlocBuilder<ContractsCounterBloc, ContractsCounterState>(
                  builder: (context, state) {
                    return BlocBuilder<RevenueBloc, RevenueState>(
                      builder: (context, revenueState) {
                        if (revenueState.status == RevenueStateStatus.loading ||
                            revenueState.status == RevenueStateStatus.error)
                          return Center(
                            child: Loader(
                              width: 100,
                              height: 100,
                              color: active,
                            ),
                          );
                        else
                          return ListView(
                            children: [
                              if (ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isMediumScreen(context))
                                if (ResponsiveWidget.isCustomSize(context))
                                  OverviewCardsMediumScreen(
                                    model: state.contractsCounterModel,
                                  )
                                else
                                  OverviewCardsLargeScreen(
                                    model: state.contractsCounterModel,
                                  )
                              else
                                OverviewCardsSmallScreen(
                                  model: state.contractsCounterModel,
                                ),
                              if (!ResponsiveWidget.isSmallScreen(context))
                                RevenueSectionLarge(revenueState.revenueModel)
                              else
                                RevenueSectionSmall(revenueState.revenueModel),
                              OverviewRequestsDataTableWidget(),
                            ],
                          );
                      },
                    );
                  },
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
