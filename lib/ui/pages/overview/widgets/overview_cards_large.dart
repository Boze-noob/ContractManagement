import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';
import 'package:contract_management/_all.dart';

class OverviewCardsLargeScreen extends StatelessWidget {
  void onTap() {
    menuController.changeActiveItemTo('Contracts');
    navigationController.navigateTo('/contracts');
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Row(
      children: [
        InfoCard(
          title: "Active contracts",
          value: "7",
          onTap: () => onTap(),
          topColor: Colors.orange,
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "Completed contracts",
          value: "17",
          topColor: Colors.lightGreen,
          onTap: () => onTap(),
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "Terminated contracts",
          value: "3",
          topColor: Colors.redAccent,
          onTap: () => onTap(),
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "Requests",
          value: "12",
          onTap: () {
            menuController.changeActiveItemTo('Request');
            navigationController.navigateTo('/request');
          },
        ),
      ],
    );
  }
}
