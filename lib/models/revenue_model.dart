//TODO uncomment revenueListDateTime
class RevenueModel {
  final int dailyRevenue;
  final int totalWeeklyRevenue;
  final List<int> weeklyRevenue;
  // final List<DateTime> revenueListDateTime;
  final int monthlyRevenue;
  final int yearlyRevenue;

  RevenueModel({
    required this.dailyRevenue,
    required this.totalWeeklyRevenue,
    required this.weeklyRevenue,
    // required this.revenueListDateTime,
    required this.monthlyRevenue,
    required this.yearlyRevenue,
  });

  RevenueModel copyWith({
    int? dailyRevenue,
    int? totalWeeklyRevenue,
    List<int>? weeklyRevenue,
    List<DateTime>? revenueListDateTime,
    int? monthlyRevenue,
    int? yearlyRevenue,
  }) =>
      RevenueModel(
        dailyRevenue: dailyRevenue ?? this.dailyRevenue,
        totalWeeklyRevenue: totalWeeklyRevenue ?? this.totalWeeklyRevenue,
        weeklyRevenue: weeklyRevenue ?? this.weeklyRevenue,
        // revenueListDateTime: revenueListDateTime ?? this.revenueListDateTime,
        monthlyRevenue: monthlyRevenue ?? this.monthlyRevenue,
        yearlyRevenue: yearlyRevenue ?? this.yearlyRevenue,
      );

  Map<String, dynamic> toMap() {
    return {
      'dailyRevenue': dailyRevenue,
      'totalWeeklyRevenue': totalWeeklyRevenue,
      'weeklyRevenue': weeklyRevenue,
      //'revenueListDateTime': revenueListDateTime,
      'monthlyRevenue': monthlyRevenue,
      'yearlyRevenue': yearlyRevenue,
    };
  }

  factory RevenueModel.fromMap(dynamic map) {
    return RevenueModel(
      dailyRevenue: map['dailyRevenue'],
      totalWeeklyRevenue: map['totalWeeklyRevenue'],
      weeklyRevenue: List<int>.from(map['weeklyRevenue']),
      //revenueListDateTime: List<DateTime>.from(map['revenueListDateTime']),
      monthlyRevenue: map['monthlyRevenue'],
      yearlyRevenue: map['yearlyRevenue'],
    );
  }
}
