import 'package:contract_management/_all.dart';
import 'dart:ui';

class OverviewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            child: ListView(
              children: [
                if (ResponsiveWidget.isLargeScreen(context) || ResponsiveWidget.isMediumScreen(context))
                  //TODO add new bloc who will count number of contracts and inject it into this classes
                  if (ResponsiveWidget.isCustomSize(context)) OverviewCardsMediumScreen() else OverviewCardsLargeScreen()
                else
                  OverviewCardsSmallScreen(),
                if (!ResponsiveWidget.isSmallScreen(context)) RevenueSectionLarge() else RevenueSectionSmall(),
                AvailableDriversTable(),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
