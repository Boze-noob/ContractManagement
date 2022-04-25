import 'package:contract_management/_all.dart';

//This should be done on server side
class InspectRevenue {
  static checkRevenueDates(RevenueModel revenueModel, BuildContext context) {
    int currentDay = DateTime.now().day;
    int currentMonth = DateTime.now().month;
    int currentYear = DateTime.now().year;
    int currentModelMonth = revenueModel.monthNumber;
    if (currentDay > revenueModel.dayNumber) {
      List<int> newWeeklyRevenue = List.from(revenueModel.weeklyRevenue)..removeLast();
      newWeeklyRevenue..insert(0, 0);
      List<int> newWeeklyDateTime = List.from(revenueModel.weeklyRevenueDateTime)..removeLast();
      newWeeklyDateTime..insert(0, currentDay);
      revenueModel = revenueModel.copyWith(
          dayNumber: currentDay,
          dailyRevenue: 0,
          weeklyRevenue: newWeeklyRevenue,
          weeklyRevenueDateTime: newWeeklyDateTime);
    }
    if (currentMonth != revenueModel.monthNumber) {
      revenueModel = revenueModel.copyWith(monthNumber: currentMonth, monthlyRevenue: 0);
    }
    if (currentYear > revenueModel.revenueYear) {
      revenueModel = revenueModel.copyWith(revenueYear: currentYear, yearlyRevenue: 0);
    }
    if (currentModelMonth != currentMonth) {
      List<int> lastSevenDaysList = generateLastSevenDaysList();
      List<int> newWeeklyRevenue = List.filled(7, 0);
      for (int item in lastSevenDaysList) {
        if (revenueModel.weeklyRevenueDateTime.contains(item)) {
          newWeeklyRevenue
            ..insert(revenueModel.weeklyRevenueDateTime.indexOf(item),
                revenueModel.weeklyRevenue[revenueModel.weeklyRevenueDateTime.indexOf(item)]);
        }
      }
      revenueModel = revenueModel.copyWith(weeklyRevenueDateTime: lastSevenDaysList, weeklyRevenue: newWeeklyRevenue);
    }
    context.revenueBloc.add(RevenueUpdateModelEvent(revenueModel: revenueModel));
  }

  static List<int> generateLastSevenDaysList() {
    List<int> weekDaysList = [];

    for (int i = 0; i <= 6; i++) {
      weekDaysList..insert(i, DateTime.now().subtract(Duration(days: i)).day);
    }
    return weekDaysList;
  }
}
