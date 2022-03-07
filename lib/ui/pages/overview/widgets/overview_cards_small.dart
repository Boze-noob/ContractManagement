import 'package:flutter/material.dart';
import 'info_card_small.dart';
import 'package:contract_management/_all.dart';


class OverviewCardsSmallScreen extends StatelessWidget {


  void onTap(){
    menuController.changeActiveItemTo('Contracts');
    navigationController.navigateTo('/contracts');
  }

  @override
  Widget build(BuildContext context) {
   double _width = MediaQuery.of(context).size.width;

    return  Container(
      height: 400,
      child: Column(
        children: [
          InfoCardSmall(
                        title: "Active contracts",
                        value: "7",
                        onTap: () => onTap(),
                        isActive: true,
                      ),
                      SizedBox(
                        height: _width / 64,
                      ),
                      InfoCardSmall(
                        title: "Completed contracts",
                        value: "17",
                        onTap: () => onTap(),
                      ),
                     SizedBox(
                        height: _width / 64,
                      ),
                          InfoCardSmall(
                        title: "Terminated contracts",
                        value: "3",
                            onTap: () => onTap(),
                      ),
                      SizedBox(
                        height: _width / 64,
                      ),
                      InfoCardSmall(
                        title: "Requests",
                        value: "12",
                        onTap: () {
                          menuController.changeActiveItemTo('Request');
                          navigationController.navigateTo('/request');
                        },
                      ),
        ],
      ),
    );
  }
}