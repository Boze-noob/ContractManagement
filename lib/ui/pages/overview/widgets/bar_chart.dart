/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:charts_flutter/flutter.dart';
import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';
import 'package:contract_management/constants/style.dart';

class SimpleBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool? animate;

  SimpleBarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData(RevenueModel revenueModel) {
    return new SimpleBarChart(
      _createSampleData(revenueModel),
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList as List<Series<dynamic, String>>,
      animate: animate,
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData(RevenueModel revenueModel) {
    final data = [
      new OrdinalSales('Today', revenueModel.weeklyRevenue[0]),
      new OrdinalSales('Yesterday', revenueModel.weeklyRevenue[1]),
      new OrdinalSales(revenueModel.weeklyRevenueDateTime[4].toString(), revenueModel.weeklyRevenue[2]),
      new OrdinalSales(revenueModel.weeklyRevenueDateTime[3].toString(), revenueModel.weeklyRevenue[3]),
      new OrdinalSales(revenueModel.weeklyRevenueDateTime[2].toString(), revenueModel.weeklyRevenue[4]),
      new OrdinalSales(revenueModel.weeklyRevenueDateTime[1].toString(), revenueModel.weeklyRevenue[5]),
      new OrdinalSales(revenueModel.weeklyRevenueDateTime[0].toString(), revenueModel.weeklyRevenue[6]),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(active),
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
