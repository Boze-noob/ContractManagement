import 'package:flutter/material.dart';
import 'package:contract_management/_all.dart';
import 'package:contract_management/_all.dart';

class OverviewCardsLargeScreen extends StatelessWidget {
  final ContractsCounterModel model;
  OverviewCardsLargeScreen({
    required this.model,
  });

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
          value: model.active.toString(),
          onTap: () => onTap(),
          topColor: Colors.orange,
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "Completed contracts",
          value: model.completed.toString(),
          topColor: Colors.lightGreen,
          onTap: () => onTap(),
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "Terminated contracts",
          value: model.terminated.toString(),
          topColor: Colors.redAccent,
          onTap: () => onTap(),
        ),
        SizedBox(
          width: _width / 64,
        ),
        InfoCard(
          title: "Requests",
          value: model.requests.toString(),
          onTap: () {
            menuController.changeActiveItemTo('Request');
            navigationController.navigateTo('/request');
          },
        ),
      ],
    );
  }
}
