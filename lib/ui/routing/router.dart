import 'package:contract_management/_all.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case overviewPageRoute:
      return _getPageRoute(OverviewPage());
    case createRequestPageRoute:
      return _getPageRoute(ClientRequestPage());
    case requestsPageRoute:
      return _getPageRoute(RequestsPage());
    case createContractPageRoute:
      return _getPageRoute(CreateContractPage());
    case contractsPageRoute:
      return _getPageRoute(ContractsPage());
    case companiesPageRoute:
      return _getPageRoute(CompaniesPage());
    case clientsPageRoute:
      return _getPageRoute(ClientsPage());
    case myProfilePageRoute:
      return _getPageRoute(MyProfilePage());
    case myContractPageRoute:
      return _getPageRoute(MyContractPage());

    default:
      return _getPageRoute(OverviewPage());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
