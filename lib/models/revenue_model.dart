class RevenueModel {
  final String todayRevenue;
  final String weeklyRevenue;
  final String monthlyRevenue;
  final String yearlyRevenue;

  RevenueModel({
    required this.todayRevenue,
    required this.weeklyRevenue,
    required this.monthlyRevenue,
    required this.yearlyRevenue,
  });

  RevenueModel copyWith({
    String? todayRevenue,
    String? weeklyRevenue,
    String? monthlyRevenue,
    String? yearlyRevenue,
  }) =>
      RevenueModel(
        todayRevenue: todayRevenue ?? this.todayRevenue,
        weeklyRevenue: weeklyRevenue ?? this.weeklyRevenue,
        monthlyRevenue: monthlyRevenue ?? this.monthlyRevenue,
        yearlyRevenue: yearlyRevenue ?? this.yearlyRevenue,
      );

  factory RevenueModel.fromMap(dynamic map) {
    return RevenueModel(
        todayRevenue : map['todayRevenue'];
        weeklyRevenue : map['weeklyRevenue'];
        monthlyRevenue : map['monthlyRevenue'];
        yearlyRevenue : map['yearlyRevenue'];
    );
  }
}
