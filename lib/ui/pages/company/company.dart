import 'package:contract_management/_all.dart';
import 'package:contract_management/ui/pages/company/widgets/companies_table.dart';
import 'package:flutter/gestures.dart';

class DriversPage extends StatelessWidget {
  const DriversPage({Key? key}) : super(key: key);

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
                physics: const AlwaysScrollableScrollPhysics(),
                children: [CompaniesTable()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
