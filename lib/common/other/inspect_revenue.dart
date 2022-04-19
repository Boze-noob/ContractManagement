import 'package:contract_management/_all.dart';

//This should be done on server side
class InspectRevenue {
  final BuildContext context;

  InspectRevenue({
    required this.context,
  });

  static checkRevenueDates(RevenueModel revenueModel) {
    int currentDay = DateTime.now().day;
    int currentMonth = DateTime.now().month;
    int currentYear = DateTime.now().year;
    int currentModelMonth = revenueModel.monthNumber;
    if (currentDay > revenueModel.dayNumber) {
      List<int> newWeeklyRevenue = revenueModel.weeklyRevenue..removeAt(0);
      newWeeklyRevenue.insert(newWeeklyRevenue.length, 0);
      List<int> newWeeklyDateTime = revenueModel.revenueListDateTime..removeAt(0);
      newWeeklyDateTime.insert(newWeeklyDateTime.length, currentDay);
      revenueModel.copyWith(dayNumber: currentDay, dailyRevenue: 0);
    }
    if (currentMonth != revenueModel.monthNumber) {
      revenueModel.copyWith(monthNumber: currentMonth, monthlyRevenue: 0);
    }
    if (currentYear > revenueModel.revenueYear) {
      revenueModel.copyWith(revenueYear: currentYear, yearlyRevenue: 0);
    }
    if (currentModelMonth != currentMonth || currentModelMonth != DateTime.now().subtract(Duration(days: 30)).month) {
      revenueModel.copyWith(revenueListDateTime: generateLastSevenDaysList(), weeklyRevenue: List.filled(7, 0));
    } else {
      List<int> lastSevenDaysList = generateLastSevenDaysList();
      List<int> newWeeklyRevenue = List.filled(7, 0);
      for (int item in lastSevenDaysList) {
        if (revenueModel.revenueListDateTime.contains(item)) {
          newWeeklyRevenue.insert(lastSevenDaysList.indexOf(item),
              revenueModel.weeklyRevenue[revenueModel.revenueListDateTime.indexOf(item)]);
        }
      }
      revenueModel.copyWith(revenueListDateTime: lastSevenDaysList, weeklyRevenue: newWeeklyRevenue);
    }
  }

  static List<int> generateLastSevenDaysList() {
    List<int> weekDaysList = [];

    for (int i = 0; i < 6; i++) {
      weekDaysList[i] = DateTime.now().subtract(Duration(days: i)).day;
    }
    return weekDaysList;
  }
}
