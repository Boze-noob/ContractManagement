import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case overviewPageRoute:
      return _getPageRoute(OverviewPage());
    case requestsPageRoute:
      return _getPageRoute(RequestsPage());
    case contractsPageRoute:
      return _getPageRoute(ContractsPage());
    case companiesPageRoute:
      return _getPageRoute(CompaniesPage());
    case clientsPageRoute:
      return _getPageRoute(ClientsPage());
    default:
      return _getPageRoute(OverviewPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
