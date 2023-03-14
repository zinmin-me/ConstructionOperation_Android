part of 'plan_details_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlanDetailsListModel _$ListModelFromJson(Map<String, dynamic> json) {
  return PlanDetailsListModel(
    data: (json['data'] as List)
        .map((e) => e == null
            ? null
            : PlanDetailsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ListModelToJson(PlanDetailsListModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
