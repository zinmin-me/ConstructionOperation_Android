import 'package:json_annotation/json_annotation.dart';

part 'plan_details_model.g.dart';

@JsonSerializable()
class PlanDetailsModel {
  final String mopId;
  final String nameofworkId;
  final String a;
  final String b;
  final String c;
  final String d;
  final String e;
  final String f;
  final String previousOverallWorkdone;
  final String overallWorkdone;
  final String modifiedBy;
  final String modifiedDate;
  final List<String?>? plandatebystringvalue;
  final List<String?>? actualDatebystringvalue;
  // final List<DateTime?> plannedDateList;

  const PlanDetailsModel({
    required this.mopId,
    required this.nameofworkId,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.e,
    required this.f,
    required this.previousOverallWorkdone,
    required this.overallWorkdone,
    required this.modifiedBy,
    required this.modifiedDate,
    required this.plandatebystringvalue,
    required this.actualDatebystringvalue,
    //required this.plannedDateList,
  });
  factory PlanDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ModelFromJson(json);
  Map<String, dynamic> toJson() => _$ModelToJson(this);

  PlanDetailsModel update({
    String? mopId,
    String? nameofworkId,
    String? a,
    String? b,
    String? c,
    String? d,
    String? e,
    String? f,
    String? previousOverallWorkdone,
    String? overallWorkdone,
    String? modifiedBy,
    String? modifiedDate,
    List<String>? plandatebystringvalue,
    List<String>? actualDatebystringvalue,
    //List<DateTime?>? plannedDateList,
    // List<DateTime?>? plannedDateList,
    // List<DateTime?>? actualDateList,
    // String? status,
  }) =>
      PlanDetailsModel(
        mopId: mopId ?? this.mopId,
        nameofworkId: nameofworkId ?? this.nameofworkId,
        a: a ?? this.a,
        b: b ?? this.b,
        c: c ?? this.c,
        d: d ?? this.d,
        e: e ?? this.e,
        f: f ?? this.f,
        previousOverallWorkdone:
            previousOverallWorkdone ?? this.previousOverallWorkdone,
        overallWorkdone: overallWorkdone ?? this.overallWorkdone,
        modifiedBy: modifiedBy ?? this.modifiedBy,
        modifiedDate: modifiedDate ?? this.modifiedDate,
        plandatebystringvalue:
            plandatebystringvalue ?? this.plandatebystringvalue,
        actualDatebystringvalue:
            actualDatebystringvalue ?? this.actualDatebystringvalue,
        // plannedDateList: plannedDateList ?? this.plannedDateList,
        // actualDateList: actualDateList ?? this.actualDateList,
        // status: status ?? this.status,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlanDetailsModel &&
          runtimeType == other.runtimeType &&
          mopId == other.mopId &&
          nameofworkId == other.nameofworkId &&
          a == other.a &&
          b == other.b &&
          c == other.c &&
          d == other.d &&
          e == other.e &&
          f == other.f &&
          previousOverallWorkdone == other.previousOverallWorkdone &&
          overallWorkdone == other.overallWorkdone &&
          modifiedBy == other.modifiedBy &&
          modifiedDate == other.modifiedDate &&
          plandatebystringvalue == other.plandatebystringvalue &&
          actualDatebystringvalue == other.actualDatebystringvalue;
  //plannedDateList == other.plannedDateList;
  // actualDateList == other.actualDateList &&
  // status == other.status;

  @override
  int get hashCode =>
      mopId.hashCode ^
      nameofworkId.hashCode ^
      a.hashCode ^
      b.hashCode ^
      c.hashCode ^
      d.hashCode ^
      e.hashCode ^
      f.hashCode ^
      previousOverallWorkdone.hashCode ^
      overallWorkdone.hashCode ^
      modifiedBy.hashCode ^
      modifiedDate.hashCode ^
      plandatebystringvalue.hashCode ^
      actualDatebystringvalue.hashCode;
  //plannedDateList.hashCode;
  // actualDateList.hashCode ^
  // status.hashCode;
}
