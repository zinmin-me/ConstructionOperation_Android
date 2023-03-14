class WorkActivity {
  final String activityName;
  final String activityID;
  final String a;
  final String b;
  final String c;
  final String d;
  final String e;
  final String f;
  final List<DateTime?> plannedDateList;
  final List<DateTime?> actualDateList;
  final String status;

  const WorkActivity({
    required this.activityName,
    required this.activityID,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.e,
    required this.f,
    required this.plannedDateList,
    required this.actualDateList,
    required this.status,
  });

  factory WorkActivity.fromJson(Map<String, dynamic> json) {
    final List<DateTime?> planDayOfWeek = <DateTime?>[];
    planJsonToDateTime(json) {
      var raw = json;
      var numeric = raw.split('(')[1].split(')')[0];
      var negative = numeric.contains('-');
      var parts = numeric.split(negative ? '-' : '+');
      var millis = int.parse(parts[0]);
      var local = DateTime.fromMillisecondsSinceEpoch(millis);
      planDayOfWeek.add(local);
    }

    try {
      json["PlanDateList"].forEach((v) => planJsonToDateTime(v["Date"]));
    } catch (e) {}

    final List<DateTime?> acutalDayOfWeek = <DateTime?>[];
    actualJsonToDateTime(json) {
      var raw = json;
      var numeric = raw.split('(')[1].split(')')[0];
      var negative = numeric.contains('-');
      var parts = numeric.split(negative ? '-' : '+');
      var millis = int.parse(parts[0]);
      var local = DateTime.fromMillisecondsSinceEpoch(millis);
      acutalDayOfWeek.add(local);
    }

    try {
      json["ActualDateList"].forEach((v) => actualJsonToDateTime(v["Date"]));
    } catch (e) {}

    return WorkActivity(
      activityName: json['NameOfWork'].toString(),
      activityID: json['NameOfWorkID'].toString(),
      a: json['a'].toString(),
      b: json['b'].toString(),
      c: json['c'].toString(),
      d: json['d'].toString(),
      e: json['e'].toString(),
      f: json['f'].toString(),
      // plannedDateList: json['PlanDateList'],
      plannedDateList: planDayOfWeek,
      // plannedDateList: <DateTime>[
      //   DateTime(2022, 10, 2),
      //   DateTime(2022, 10, 3),
      //   DateTime(2022, 10, 4)
      // ],
      actualDateList: acutalDayOfWeek,
      status: "false",
    );
  }

  WorkActivity update({
    String? activityName,
    String? activityID,
    String? a,
    String? b,
    String? c,
    String? d,
    String? e,
    String? f,
    List<DateTime?>? plannedDateList,
    List<DateTime?>? actualDateList,
    String? status,
  }) =>
      WorkActivity(
        activityName: activityName ?? this.activityName,
        activityID: activityID ?? this.activityID,
        a: a ?? this.a,
        b: b ?? this.b,
        c: c ?? this.c,
        d: d ?? this.d,
        e: e ?? this.e,
        f: f ?? this.f,
        plannedDateList: plannedDateList ?? this.plannedDateList,
        actualDateList: actualDateList ?? this.actualDateList,
        status: status ?? this.status,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkActivity &&
          runtimeType == other.runtimeType &&
          activityName == other.activityName &&
          activityID == other.activityID &&
          a == other.a &&
          b == other.b &&
          c == other.c &&
          d == other.d &&
          e == other.e &&
          f == other.f &&
          plannedDateList == other.plannedDateList &&
          actualDateList == other.actualDateList &&
          status == other.status;

  @override
  int get hashCode =>
      activityName.hashCode ^
      activityID.hashCode ^
      a.hashCode ^
      b.hashCode ^
      c.hashCode ^
      d.hashCode ^
      e.hashCode ^
      f.hashCode ^
      plannedDateList.hashCode ^
      actualDateList.hashCode ^
      status.hashCode;
}
