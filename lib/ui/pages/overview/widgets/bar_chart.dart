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
    //TODO add dynamic date time
    final data = [
      new OrdinalSales('Today', revenueModel.weeklyRevenue[0]),
      new OrdinalSales('Yesterday', revenueModel.weeklyRevenue[1]),
      new OrdinalSales('2 days', revenueModel.weeklyRevenue[2]),
      new OrdinalSales('24 Jun', revenueModel.weeklyRevenue[3]),
      new OrdinalSales('23 Jun', revenueModel.weeklyRevenue[4]),
      new OrdinalSales('22 Jun', revenueModel.weeklyRevenue[5]),
      new OrdinalSales('21 Jun', revenueModel.weeklyRevenue[6]),
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
