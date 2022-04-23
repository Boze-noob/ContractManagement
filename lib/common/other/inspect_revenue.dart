import 'package:contract_management/_all.dart';

//This should be done on server side
class InspectRevenue {
  static checkRevenueDates(RevenueModel revenueModel, BuildContext context) {
    print('We enter into check revenue dates');
    int currentDay = DateTime.now().day;
    int currentMonth = DateTime.now().month;
    int currentYear = DateTime.now().year;
    int currentModelMonth = revenueModel.monthNumber;
    if (currentDay > revenueModel.dayNumber) {
      print('We enter into current day check');
      print('elements in weekly revenue are');
      for (int item in revenueModel.weeklyRevenue) print(item);
      List<int> newWeeklyRevenue = List.from(revenueModel.weeklyRevenue).removeAt(0);
      newWeeklyRevenue.insert(newWeeklyRevenue.length, 0);
      List<int> newWeeklyDateTime = List.from(revenueModel.weeklyRevenueDateTime).removeAt(0);
      newWeeklyDateTime.insert(newWeeklyDateTime.length, currentDay);
      revenueModel.copyWith(
          dayNumber: currentDay,
          dailyRevenue: 0,
          weeklyRevenue: newWeeklyRevenue,
          weeklyRevenueDateTime: newWeeklyDateTime);
    }
    if (currentMonth != revenueModel.monthNumber) {
      print('We enter into check month dates');
      revenueModel.copyWith(monthNumber: currentMonth, monthlyRevenue: 0);
    }
    if (currentYear > revenueModel.revenueYear) {
      print('We enter into check year dates');
      revenueModel.copyWith(revenueYear: currentYear, yearlyRevenue: 0);
    }
    if (currentModelMonth != currentMonth || currentModelMonth != DateTime.now().subtract(Duration(days: 30)).month) {
      revenueModel.copyWith(weeklyRevenueDateTime: generateLastSevenDaysList(), weeklyRevenue: List.filled(7, 0));
    } else {
      List<int> lastSevenDaysList = generateLastSevenDaysList();
      List<int> newWeeklyRevenue = List.filled(7, 0);
      for (int item in lastSevenDaysList) {
        if (revenueModel.weeklyRevenueDateTime.contains(item)) {
          newWeeklyRevenue.insert(lastSevenDaysList.indexOf(item),
              revenueModel.weeklyRevenue[revenueModel.weeklyRevenueDateTime.indexOf(item)]);
        }
      }
      revenueModel.copyWith(weeklyRevenueDateTime: lastSevenDaysList, weeklyRevenue: newWeeklyRevenue);
    }
    context.revenueBloc.add(RevenueUpdateModelEvent(revenueModel: revenueModel));
  }

  static List<int> generateLastSevenDaysList() {
    List<int> weekDaysList = [];

    for (int i = 0; i < 6; i++) {
      weekDaysList.insert(i, DateTime.now().subtract(Duration(days: i)).day);
    }
    for (int item in weekDaysList) print(item);
    return weekDaysList;
  }
}
