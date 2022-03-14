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
                      if (!ResponsiveWidget.isSmallScreen(context)) RevenueSectionLarge() else RevenueSectionSmall(),
                      AvailableCompaniesTable(),
                    ],
                  );
                },
              ),
            ))
          ],
        ),
      ),
    );
  }
}
