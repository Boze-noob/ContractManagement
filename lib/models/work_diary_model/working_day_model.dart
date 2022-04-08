class WorkingDayModel {
  final DateTime dateTime;
  final String weather;
  final String employers;
  final String machines;
  final String materials;

  WorkingDayModel({
    required this.dateTime,
    required this.weather,
    required this.employers,
    required this.machines,
    required this.materials,
  });

  WorkingDayModel copyWith({
    DateTime? dateTime,
    String? weather,
    String? employers,
    String? machines,
    String? materials,
  }) =>
      WorkingDayModel(
        dateTime: dateTime ?? this.dateTime,
        weather: weather ?? this.weather,
        employers: employers ?? this.employers,
        machines: machines ?? this.machines,
        materials: materials ?? this.materials,
      );

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime.toUtc(),
      'weather': weather,
      'employers': employers,
      'machines': machines,
      'materials': materials,
    };
  }

  factory WorkingDayModel.fromMap(dynamic map) {
    return WorkingDayModel(
      dateTime: map['dateTime'] != null ? map['dateTime'].toDate() : null,
      weather: map['weather'],
      employers: map['employers'],
      machines: map['machines'],
      materials: map['materials'],
    );
  }
}
