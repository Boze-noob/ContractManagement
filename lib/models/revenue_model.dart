class RevenueModel {
  final int dailyRevenue;
  final int totalWeeklyRevenue;
  final List<int> weeklyRevenue;
  final int monthlyRevenue;
  final int yearlyRevenue;

  final List<int> revenueListDateTime;
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
    required this.revenueListDateTime,
    required this.revenueYear,
    required this.weekNumber,
    required this.monthNumber,
    required this.dayNumber,
  });

  RevenueModel copyWith({
    int? dailyRevenue,
    int? totalWeeklyRevenue,
    List<int>? weeklyRevenue,
    List<int>? revenueListDateTime,
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
        revenueListDateTime: revenueListDateTime ?? this.revenueListDateTime,
        monthlyRevenue: monthlyRevenue ?? this.monthlyRevenue,
        yearlyRevenue: yearlyRevenue ?? this.yearlyRevenue,
        revenueYear: revenueYear ?? this.revenueYear,
        weekNumber: weekNumber ?? this.weekNumber,
        monthNumber: monthNumber ?? this.monthNumber,
        dayNumber: dayNumber ?? this.dayNumber,
      );

  Map<String, dynamic> toMap() {
    return {
      'dailyRevenue': dailyRevenue,
      'totalWeeklyRevenue': totalWeeklyRevenue,
      'weeklyRevenue': weeklyRevenue,
      'revenueListDateTime': revenueListDateTime,
      'monthlyRevenue': monthlyRevenue,
      'yearlyRevenue': yearlyRevenue,
      'revenueYear': revenueYear,
      'weekNumber': weekNumber,
      'monthNumber': monthNumber,
      'dayNumber': dayNumber,
    };
  }

  factory RevenueModel.fromMap(dynamic map) {
    return RevenueModel(
      dailyRevenue: map['dailyRevenue'],
      totalWeeklyRevenue: map['totalWeeklyRevenue'],
      weeklyRevenue: List<int>.from(map['weeklyRevenue']),
      revenueListDateTime: List<int>.from(map['revenueListDateTime']),
      monthlyRevenue: map['monthlyRevenue'],
      yearlyRevenue: map['yearlyRevenue'],
      revenueYear: map['revenueYear'],
      weekNumber: map['weekNumber'],
      monthNumber: map['monthNumber'],
      dayNumber: map['dayNumber'],
    );
  }
}
