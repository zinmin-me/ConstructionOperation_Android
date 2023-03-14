import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class AddMonth {
  int siteID;
  String month;
  String date;
  int prepareBy;
  bool? completePrepareStatus;
  int checkedBy;
  bool? completeCheckedStatus;
  int approveBy;
  bool? completeApprovedStatus;
  bool? deleteStatus;
  int modifiedBy;
  String modifiedDate;

  AddMonth({
    required this.siteID,
    required this.month,
    required this.date,
    required this.prepareBy,
    required this.completePrepareStatus,
    required this.checkedBy,
    required this.completeCheckedStatus,
    required this.approveBy,
    required this.completeApprovedStatus,
    required this.deleteStatus,
    required this.modifiedBy,
    required this.modifiedDate,
  });

  factory AddMonth.fromJson(Map<String, dynamic> json) {
    return AddMonth(
      siteID: json['SiteID'],
      month: json['FortheMonth'],
      date: json['Date'],
      prepareBy: json['PreparedBy'],
      completePrepareStatus: json['CompletePrepare'],
      checkedBy: json['CheckedBy'],
      completeCheckedStatus: json['CompleteChecked'],
      approveBy: json['ApproveBy'],
      completeApprovedStatus: json['CompleteApproved'],
      deleteStatus: json['DeleteStatus'],
      modifiedBy: json['ModifiedBy'],
      modifiedDate: json['ModifiedDate'],
    );
  }
  factory AddMonth.fromMap(Map<String, dynamic> json) {
    return AddMonth(
      siteID: json['SiteID'],
      month: json['FortheMonth'],
      date: json['Date'],
      prepareBy: json['PreparedBy'],
      completePrepareStatus: json['CompletePrepare'],
      checkedBy: json['CheckedBy'],
      completeCheckedStatus: json['CompleteChecked'],
      approveBy: json['ApproveBy'],
      completeApprovedStatus: json['CompleteApproved'],
      deleteStatus: json['DeleteStatus'],
      modifiedBy: json['ModifiedBy'],
      modifiedDate: json['ModifiedDate'],
    );
  }
}
