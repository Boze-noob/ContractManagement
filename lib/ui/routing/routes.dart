const rootRoute = "/rootRoute";

const overviewPageDisplayName = "Overview";
const overviewPageRoute = "/overview";

const requestsPageDisplayName = "Requests";
const requestsPageRoute = "/requests";

const contractsPageDisplayName = "Contracts";
const contractsPageRoute = "/contracts";

const companiesPageDisplayName = "Companies";
const companiesPageRoute = "/companies";

const clientsPageDisplayName = "Clients";
const clientsPageRoute = "/clients";

const authenticationPageDisplayName = "Log out";
const authenticationPageRoute = "/auth";

const navigationWrapperRoute = "/navigationWrapper";

const activeContracts = "Active contracts";
const terminatedContracts = "Terminated contracts";
const completedContracts = "Completed contracts";

class MenuItem {
  final String name;
  final String route;

  MenuItem(this.name, this.route);
}

List<MenuItem> sideMenuItemRoutes = [
  MenuItem(overviewPageDisplayName, overviewPageRoute),
  MenuItem(requestsPageDisplayName, requestsPageRoute),
  MenuItem(contractsPageDisplayName, contractsPageRoute),
  MenuItem(companiesPageDisplayName, companiesPageRoute),
  MenuItem(clientsPageDisplayName, clientsPageRoute),
  MenuItem(authenticationPageDisplayName, authenticationPageRoute),
];
