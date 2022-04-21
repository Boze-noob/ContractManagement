import 'package:flutter/material.dart';
import 'package:contract_management/constants/style.dart';
import 'package:contract_management/_all.dart';

class RevenueSectionSmall extends StatelessWidget {
  final RevenueModel revenueModel;

  RevenueSectionSmall(this.revenueModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      margin: EdgeInsets.symmetric(vertical: 30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(offset: Offset(0, 6), color: lightGrey.withOpacity(.1), blurRadius: 12)],
        border: Border.all(color: lightGrey, width: .5),
      ),
      child: Column(
        children: [
          Container(
            height: 260,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomText(
                  text: "Revenue Chart",
                  size: 20,
                  weight: FontWeight.bold,
                  color: lightGrey,
                ),
                Container(width: 600, height: 200, child: SimpleBarChart.withSampleData(revenueModel)),
              ],
            ),
          ),
          Container(
            width: 120,
            height: 1,
            color: lightGrey,
          ),
          Container(
            height: 260,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    RevenueInfo(
                      title: "Today\'s revenue",
                      amount: revenueModel.dailyRevenue.toString(),
                    ),
                    RevenueInfo(
                      title: "Last 7 days",
                      amount: revenueModel.totalWeeklyRevenue.toString(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    RevenueInfo(
                      title: "Last 30 days",
                      amount: revenueModel.monthlyRevenue.toString(),
                    ),
                    RevenueInfo(
                      title: "Last 12 months",
                      amount: revenueModel.yearlyRevenue.toString(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
