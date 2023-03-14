import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MonthlyPlan {
  int siteID;
  String projectName;
  String siteCode;
  String month;
  String completePrepareStatus;
  String completeCheckedStatus;
  String completeApprovedStatus;
  String tempMonth;

  MonthlyPlan({
    required this.siteID,
    required this.projectName,
    required this.siteCode,
    required this.month,
    required this.completePrepareStatus,
    required this.completeCheckedStatus,
    required this.completeApprovedStatus,
    required this.tempMonth,
  });

  factory MonthlyPlan.fromJson(Map<String, dynamic> json) {
    var raw = json['FortheMonth'];
    var numeric = raw.split('(')[1].split(')')[0];
    var negative = numeric.contains('-');
    var parts = numeric.split(negative ? '-' : '+');
    var millis = int.parse(parts[0]);
    var local = DateTime.fromMillisecondsSinceEpoch(millis);

    return MonthlyPlan(
      siteID: json['SiteID'],
      projectName: json['SiteName'],
      siteCode: json['SiteCode'],
      month: DateFormat("MMMM - yyyy").format(local),
      tempMonth: DateFormat("M/d/y").format(local),
      completePrepareStatus: json['CompletePrepare'].toString(),
      completeCheckedStatus: json['CompleteChecked'].toString(),
      completeApprovedStatus: json['CompleteApproved'].toString(),
    );
  }
}

// class AddMonthlyPlan {
//   String siteID;
//   String month;
//   String date;
//   String prepareBy;
//   bool completePrepareStatus;
//   String checkedBy;
//   bool completeCheckedStatus;
//   String approveBy;
//   bool completeApprovedStatus;
//   bool deleteStatus;
//   String modifiedBy;
//   String modifiedDate;

//   AddMonthlyPlan({
//     required this.siteID,
//     required this.month,
//     required this.date,
//     required this.prepareBy,
//     required this.completePrepareStatus,
//     required this.checkedBy,
//     required this.completeCheckedStatus,
//     required this.approveBy,
//     required this.completeApprovedStatus,
//     required this.deleteStatus,
//     required this.modifiedBy,
//     required this.modifiedDate,
//   });

//   factory AddMonthlyPlan.toJson(Map<String, dynamic> json) {
//     var raw = json['FortheMonth'];
//     var numeric = raw.split('(')[1].split(')')[0];
//     var negative = numeric.contains('-');
//     var parts = numeric.split(negative ? '-' : '+');
//     var millis = int.parse(parts[0]);
//     var local = DateTime.fromMillisecondsSinceEpoch(millis);

//     return AddMonthlyPlan(
//       siteID: json['SiteID'].toString(),
//       month: DateFormat("yyyy-mm-dd").format(local),
//       date: DateFormat("yyyy-mm-dd").format(local),
//       prepareBy: json['PreparedBy'].toString(),
//       completePrepareStatus: json['CompletePrepare'],
//       checkedBy: json['CheckedBy'].toString(),
//       completeCheckedStatus: json['CompleteChecked'],
//       approveBy: json['ApproveBy'].toString(),
//       completeApprovedStatus: json['CompleteApproved'],
//       deleteStatus: json['DeleteStatus'],
//       modifiedBy: json['ModifiedBy'].toString(),
//       modifiedDate: DateFormat("yyyy-mm-dd").format(local),
//     );
//   }
// }
// List<MonthlyPlan> monthlyPlanList = [
//   MonthlyPlan(
//     projectName: "DMTL (Basement+11 Storeyed RCC)",
//     siteCode: "ASC-20-015",
//     month: "January - 2022",
//     status: "pending",
//   ),
//   MonthlyPlan(
//     projectName: "Commercial Project",
//     siteCode: "ASC-21-012",
//     month: "February - 2022",
//     status: "pending",
//   ),
//   MonthlyPlan(
//     projectName: "Resedential Project",
//     siteCode: "ASC-22-013",
//     month: "March - 2022",
//     status: "finished",
//   ),
//   MonthlyPlan(
//     projectName: "Goverment Project",
//     siteCode: "ASC-23-014",
//     month: "April - 2022",
//     status: "finished",
//   ),
//   MonthlyPlan(
//     projectName: "City Mall",
//     siteCode: "ASC-24-015",
//     month: "May - 2022",
//     status: "new",
//   ),
//   MonthlyPlan(
//     projectName: "Goverment Project",
//     siteCode: "ASC-24-015",
//     month: "May - 2022",
//     status: "reject",
//   ),
// ];
