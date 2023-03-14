import 'package:flutter/material.dart';

class MonthlyPlanModel {
  final int mopID;
  final int siteID;
  String month;
  bool? completePrepareStatus;
  bool? completeCheckedStatus;
  bool? completeApprovedStatus;

  MonthlyPlanModel({
    required this.mopID,
    required this.siteID,
    required this.month,
    required this.completePrepareStatus,
    required this.completeCheckedStatus,
    required this.completeApprovedStatus,
  });

  factory MonthlyPlanModel.fromJson(Map<String, dynamic> json) {
    return MonthlyPlanModel(
      mopID: json['MOPID'],
      siteID: json['SiteID'],
      month: json['FortheMonth'],
      completePrepareStatus: json['CompletePrepare'],
      completeCheckedStatus: json['CompleteChecked'],
      completeApprovedStatus: json['CompleteApproved'],
    );
  }

  factory MonthlyPlanModel.fromMap(Map<String, dynamic> json) {
    return MonthlyPlanModel(
      mopID: json['MOPID'],
      siteID: json['SiteID'],
      month: json['FortheMonth'],
      completePrepareStatus: json['CompletePrepare'],
      completeCheckedStatus: json['CompleteChecked'],
      completeApprovedStatus: json['CompleteApproved'],
    );
  }
}
