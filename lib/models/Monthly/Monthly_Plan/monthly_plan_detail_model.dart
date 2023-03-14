import 'package:flutter/material.dart';

class MonthlyPlanDetailModel {
  final String mpdId;
  final String mopId;
  final String nameofworkId;

  MonthlyPlanDetailModel({
    required this.mpdId,
    required this.mopId,
    required this.nameofworkId,
  });

  factory MonthlyPlanDetailModel.fromJson(Map<String, dynamic> json) {
    return MonthlyPlanDetailModel(
      mpdId: json['ID'],
      mopId: json['MOPID'],
      nameofworkId: json['NameOfWorkID'],
    );
  }

  factory MonthlyPlanDetailModel.fromMap(Map<String, dynamic> json) {
    return MonthlyPlanDetailModel(
      mpdId: json['ID'],
      mopId: json['MOPID'],
      nameofworkId: json['NameOfWorkID'],
    );
  }
}
