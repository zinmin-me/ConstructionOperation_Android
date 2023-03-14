part of 'plan_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanDetailsModel _$ModelFromJson(Map<String, dynamic> json) {
  return PlanDetailsModel(
    mopId: json['MOPID'] as String,
    nameofworkId: json['NameOfWorkID'] as String,
    a: json['a'] as String,
    b: json['b'] as String,
    c: json['c'] as String,
    d: json['d'] as String,
    e: json['e'] as String,
    f: json['f'] as String,
    previousOverallWorkdone: json['PreviousOverallWorkdone'] as String,
    overallWorkdone: json['OverallWorkdone'] as String,
    modifiedBy: json['ModifiedBy'] as String,
    modifiedDate: json['ModifiedDate'] as String,
    plandatebystringvalue:
        List<String>.from(json["PlanDateByStringValue"].map((x) => x)),
    actualDatebystringvalue:
        List<String>.from(json["ActualDateByStringValue"].map((x) => x)),
    //plannedDateList: <DateTime>[],
    // plannedDateList: <DateTime>[
    //   DateTime(2022, 10, 2),
    //   DateTime(2022, 10, 3),
    //   DateTime(2022, 10, 4)
    // ],
    // actualDateList: <DateTime>[],
  );
}

Map<String, dynamic> _$ModelToJson(PlanDetailsModel instance) =>
    <String, dynamic>{
      'MOPID': instance.mopId,
      'NameOfWorkID': instance.nameofworkId,
      'a': instance.a,
      'b': instance.b,
      'c': instance.c,
      'd': instance.d,
      'e': instance.e,
      'f': instance.f,
      'PreviousOverallWorkdone': instance.previousOverallWorkdone,
      'OverallWorkdone': instance.overallWorkdone,
      'ModifiedBy': instance.modifiedBy,
      'ModifiedDate': instance.modifiedDate,
      'PlanDateByStringValue': instance.plandatebystringvalue,
      'ActualDateByStringValue': instance.actualDatebystringvalue,
      //'PlanDateList': instance.plannedDateList,
    };
