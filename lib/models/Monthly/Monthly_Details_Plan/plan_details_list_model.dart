import 'package:json_annotation/json_annotation.dart';

import 'plan_details_model.dart';

part 'plan_details_list_model.g.dart';

@JsonSerializable()
class PlanDetailsListModel {
  List<PlanDetailsModel?> data;
  PlanDetailsListModel({required this.data});
  factory PlanDetailsListModel.fromJson(Map<String, dynamic> json) =>
      _$ListModelFromJson(json);
  Map<String, dynamic> toJson() => _$ListModelToJson(this);
}
