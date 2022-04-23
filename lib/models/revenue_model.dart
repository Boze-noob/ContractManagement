class RevenueModel {
  final int dailyRevenue;
  final int totalWeeklyRevenue;
  final List<int> weeklyRevenue;
  final int monthlyRevenue;
  final int yearlyRevenue;

  final List<int> weeklyRevenueDateTime;
  final int revenueYear;
  final int weekNumber;
  final int monthNumber;
  final int dayNumber;

  RevenueModel({
    required this.dailyRevenue,
    required this.totalWeeklyRevenue,
    required this.weeklyRevenue,
    required this.monthlyRevenue,
    required this.yearlyRevenue,
    required this.weeklyRevenueDateTime,
    required this.revenueYear,
    required this.weekNumber,
    required this.monthNumber,
    required this.dayNumber,
  });

  RevenueModel copyWith({
    int? dailyRevenue,
    int? totalWeeklyRevenue,
    List<int>? weeklyRevenue,
    List<int>? weeklyRevenueDateTime,
    int? monthlyRevenue,
    int? yearlyRevenue,
    int? revenueYear,
    int? weekNumber,
    int? monthNumber,
    int? dayNumber,
  }) =>
      RevenueModel(
        dailyRevenue: dailyRevenue ?? this.dailyRevenue,
        totalWeeklyRevenue: totalWeeklyRevenue ?? this.totalWeeklyRevenue,
        weeklyRevenue: weeklyRevenue ?? this.weeklyRevenue,
        weeklyRevenueDateTime: weeklyRevenueDateTime ?? this.weeklyRevenueDateTime,
        monthlyRevenue: monthlyRevenue ?? this.monthlyRevenue,
        yearlyRevenue: yearlyRevenue ?? this.yearlyRevenue,
        revenueYear: revenueYear ?? this.revenueYear,
        weekNumber: weekNumber ?? this.weekNumber,
        monthNumber: monthNumber ?? this.monthNumber,
        dayNumber: dayNumber ?? this.dayNumber,
      );

  Map<String, dynamic> toMap() {
    print("we are into to map");
    return {
      'dailyRevenue': dailyRevenue,
      'totalWeeklyRevenue': totalWeeklyRevenue,
      'weeklyRevenue': weeklyRevenue,
      'weeklyRevenueDateTime': weeklyRevenueDateTime,
      'monthlyRevenue': monthlyRevenue,
      'yearlyRevenue': yearlyRevenue,
      'revenueYear': revenueYear,
      'weekNumber': weekNumber,
      'monthNumber': monthNumber,
      'dayNumber': dayNumber,
    };
  }

  factory RevenueModel.fromMap(dynamic map) {
    print("we are into from map");
    return RevenueModel(
      dailyRevenue: map['dailyRevenue'],
      totalWeeklyRevenue: map['totalWeeklyRevenue'],
      weeklyRevenue: List<int>.from(map['weeklyRevenue']),
      weeklyRevenueDateTime: List<int>.from(map['weeklyRevenueDateTime']),
      monthlyRevenue: map['monthlyRevenue'],
      yearlyRevenue: map['yearlyRevenue'],
      revenueYear: map['revenueYear'],
      weekNumber: map['weekNumber'],
      monthNumber: map['monthNumber'],
      dayNumber: map['dayNumber'],
    );
  }
}
