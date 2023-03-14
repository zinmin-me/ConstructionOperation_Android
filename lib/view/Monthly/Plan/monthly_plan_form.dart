import 'dart:async';
import 'dart:convert';

import 'package:construction_flutter_application/models/Monthly/Monthly_Details_Plan/plan_details_list_model.dart';
import 'package:construction_flutter_application/models/Monthly/Monthly_Details_Plan/plan_details_model.dart';

import 'package:construction_flutter_application/models/Monthly/Monthly_Plan/monthly_plan_detail_model.dart';

import 'package:construction_flutter_application/models/Monthly/monthly_plan_list_model.dart';
import 'package:construction_flutter_application/models/Project/projects_list_model.dart';

import 'package:construction_flutter_application/utils/animation.dart';
import 'package:construction_flutter_application/view/Monthly/Plan/add_monthly_dialog.dart';

import 'package:construction_flutter_application/view/Monthly/monthly_header.dart';

import 'package:construction_flutter_application/utils/scrollable_widget.dart';
import 'package:construction_flutter_application/view/Monthly/Plan/update_monthly_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/Monthly/Monthly_Plan/monthly_plan_model.dart';
import '../../../models/Monthly/monthly_work_activities_model.dart';
import '../../../models/PersonAndSite/person_and_site_model.dart';
import '../../../utils/global.dart';
import '../../../utils/utils.dart';

import 'package:http/http.dart' as http;

import '../Acutal/update_monthly_dialog.dart';

class MonthlyPlanForm extends StatefulWidget {
  final Project project;
  final MonthlyPlan monthlyPlan;
  const MonthlyPlanForm(
      {super.key, required this.project, required this.monthlyPlan});

  @override
  State<MonthlyPlanForm> createState() => _MonthlyPlanFormState();
}

class _MonthlyPlanFormState extends State<MonthlyPlanForm> {
  List<WorkActivity> activities = [];

  var mopID = 0;
  var montlyPlanDetailID = 0;

  bool? prepareStatus;
  bool? checkedStatus;
  bool? approveStatus;
  bool floatingSubmitBtn = false;
  bool floatingAddBtn = false;

  bool floatingAcceptBtn = false;
  bool floatingRejectBtn = false;
  bool isPrepareBy = false;

  int? userID;
  String? userRole;
  int? personID;
  late String loginName = "";
  late String password = "";
  late String email = "";
  late String personName = "";

  int? opTypeID;
  String? operationPlan;

  PlanDetailsListModel detailsListModel = PlanDetailsListModel(data: []);
  List<PersonAndSite> personAndSiteList = [];

  // List<WorkActivity> allActivities = [];

  int? sortColumnIndex;
  bool isAscending = false;
  @override
  void initState() {
    super.initState();

    getAllMonthlyPlanDetailsBySiteId(
        widget.project.siteID, widget.monthlyPlan.tempMonth);

    getMonthlyPlanBySiteIdAndForTheMonth(
        widget.project.siteID, widget.monthlyPlan.tempMonth);

    // this.activities = List.of(allActivities);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Visibility(
              visible: floatingSubmitBtn,
              child: FloatingActionButton.extended(
                onPressed: () {
                  if (activities.isNotEmpty) {
                    ShowSubmitConfirmationBox();
                  } else {
                    showErrorMessagePopUp();
                  }
                },
                label: const Text('Submit'),
                icon: const Icon(Icons.upload_file),
                backgroundColor: Colors.blueGrey,
              ),
            ),
            Visibility(
              visible: floatingAcceptBtn,
              child: FloatingActionButton.extended(
                onPressed: () {
                  ShowAcceptConfirmationBox();
                },
                label: const Text('Accept'),
                icon: const Icon(Icons.check_circle_outline),
                backgroundColor: Colors.green,
              ),
            ),
            Expanded(child: Container()),
            Visibility(
              visible: floatingAddBtn,
              child: FloatingActionButton(
                heroTag: "btnAdd",
                backgroundColor: Colors.blueGrey,
                onPressed: () {
                  ShowAddMonthlyPlanDialog();
                },
                child: const Icon(Icons.add),
              ),
            ),
            Visibility(
              visible: floatingRejectBtn,
              child: FloatingActionButton.extended(
                onPressed: () {
                  ShowRejectConfirmationBox();
                },
                label: const Text('Reject'),
                icon: const Icon(Icons.dangerous_outlined),
                backgroundColor: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Monthly Plan"),
        backgroundColor: bgColor,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 18),
            child: TextButton.icon(
              onPressed: () {},
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text(
                loginName,
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const SizedBox(height: 20),
                MonthlyHeader(
                  project: widget.project,
                  monthlyPlan: widget.monthlyPlan,
                ),
                const SizedBox(height: 50),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: ScrollableWidget(child: buildDataTable()),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getAllMonthlyPlanDetailsBySiteId(siteID, forTheMonth) async {
    var response = await http.get(
      Uri.parse(getAllMonthlyPlanDetailsBySiteIDAndForthemonth_url +
          "siteID=" +
          siteID.toString() +
          "&month=" +
          forTheMonth),
    );
    if (response.body != "") {
      setState(() {
        activities = parseWorkActivityList(response.body);
      });
    }
  }

  Future<void> getMonthlyPlanBySiteIdAndForTheMonth(siteID, forTheMonth) async {
    var response = await http.get(
      Uri.parse(getMonthlyPlanBySiteIDAndForTheMonth_url +
          "siteID=" +
          siteID.toString() +
          "&forMonth=" +
          forTheMonth),
    );
    if (response.statusCode == 200 && response.contentLength != 0) {
      setState(() {
        mopID = MonthlyPlanModel.fromJson(jsonDecode(response.body)).mopID;
        prepareStatus = MonthlyPlanModel.fromJson(jsonDecode(response.body))
            .completePrepareStatus;
        checkedStatus = MonthlyPlanModel.fromJson(jsonDecode(response.body))
            .completeCheckedStatus;
        approveStatus = MonthlyPlanModel.fromJson(jsonDecode(response.body))
            .completeApprovedStatus;

        if (prepareStatus == true &&
            checkedStatus == true &&
            approveStatus == true) {
          floatingSubmitBtn = false;
          floatingAddBtn = false;

          floatingAcceptBtn = false;
          floatingRejectBtn = false;
        } else if ((prepareStatus == true &&
                checkedStatus == null &&
                approveStatus == null) ||
            (prepareStatus == true &&
                checkedStatus == true &&
                approveStatus == null)) {
          floatingSubmitBtn = false;
          floatingAddBtn = false;
        } else {
          floatingSubmitBtn = true;
          floatingAddBtn = true;
        }
      });
      getUser();
    }
  }

  Future<void> getMonthlyPlanDetailsIDByMOPIDAndNameOfWorkID(
      mopID, nameOfWorkID) async {
    var response = await http.get(
      Uri.parse(getMonthlyPlanDetailsIDByMOPIDAndNameOfWorkID_url +
          "mopID=" +
          mopID.toString() +
          "&nameOfWorkID=" +
          nameOfWorkID.toString()),
    );
    if (response.statusCode == 200 && response.contentLength != 0) {
      montlyPlanDetailID =
          MonthlyPlanDetailModel.fromJson(jsonDecode(response.body)).mpdId
              as int;
    }
  }

  static List<WorkActivity> parseWorkActivityList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<WorkActivity>((json) => WorkActivity.fromJson(json))
        .toList();
  }

  Future<void> getAllPersonAndSiteBySiteIDAndPersonID(
      siteID, personID, status) async {
    var response = await http.get(
      Uri.parse(
          "${getAllPersonAndSiteBySiteIDAndPersonID_url}siteID=$siteID&personID=$personID"),
    );
    if (response.body != "") {
      setState(() {
        personAndSiteList = parsePersonAndSiteList(response.body);
        for (var personAndSite in personAndSiteList) {
          if (personAndSite.responsibilityType == "Prepared By") {
            floatingAcceptBtn = false;
            floatingRejectBtn = false;
            isPrepareBy = true;
            break;
          } else {
            if (prepareStatus == true &&
                checkedStatus == true &&
                approveStatus == true) {
              floatingAcceptBtn = false;
              floatingRejectBtn = false;
            } else {
              floatingAcceptBtn = true;
              floatingRejectBtn = true;
            }
          }
        }
        for (var personAndSite in personAndSiteList) {
          updateMonthlyPlanStatusSend(
              mopID, personAndSite.responsibilityType, status);
        }
      });
    }
  }

  static List<PersonAndSite> parsePersonAndSiteList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<PersonAndSite>((json) => PersonAndSite.fromJson(json))
        .toList();
  }

  Future ShowAddMonthlyPlanDialog() async {
    WorkActivity updateActivity = await ShowAddMonthlyDialog(
      context,
      mopID,
    );
    if (updateActivity.e == "") {
    } else if (updateActivity.e != "") {
      var matchStatus = "false";
      for (var element in activities) {
        if (element.activityName == updateActivity.activityName) {
          matchStatus = "true";
          showCupertinoDialog<String>(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
              title: const Text('Work Activity Duplicate!'),
              content: const Text('Please check your activity.'),
              actions: <Widget>[
                TextButton(
                    onPressed: () async {
                      Navigator.pop(context, 'Cancel');
                    },
                    child: const Text('OK'))
              ],
            ),
          );
        } else {}
      }
      setState(() {
        if (matchStatus == "false") {
          activities.add(updateActivity);
        }
      });
    }
  }

  void getUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userID = pref.getInt('userID');
      userRole = pref.getString('userRole');
      personID = pref.getInt('personID');
      loginName = pref.getString('loginName')!;
      password = pref.getString('password')!;
      email = pref.getString('email')!;
      personName = pref.getString('personName')!;
    });
    getAllPersonAndSiteBySiteIDAndPersonID(
        widget.project.siteID, personID, "Nothing");
  }

  Future ShowUpdateMonthlyPlanDialog(
      WorkActivity workActivity, int mopID) async {
    WorkActivity updateActivity = await ShowUpdateMonthlyDialog(
      context,
      title: '',
      value: workActivity,
      mopID: mopID,
    );
    if (updateActivity.status == "false") {
      setState(() => activities = activities.map((WorkActivity) {
            final isUpdate = WorkActivity == workActivity;

            return isUpdate
                ? WorkActivity.update(
                    activityName: updateActivity.activityName,
                    a: updateActivity.a,
                    b: updateActivity.b,
                    c: updateActivity.c,
                    d: updateActivity.d,
                    e: updateActivity.e,
                    f: updateActivity.f,
                    plannedDateList: updateActivity.plannedDateList,
                    actualDateList: updateActivity.actualDateList,
                    status: updateActivity.status)
                : WorkActivity;
          }).toList());
    } else if (updateActivity.status == "true") {
      setState(() {
        activities.remove(workActivity);
      });
    }
  }

  Future ShowUpdateMonthlyAcutalDialog(
      WorkActivity workActivity, int mopID) async {
    WorkActivity updateActivity = await ShowUpdateAcutalMonthlyDialog(
      context,
      title: '',
      value: workActivity,
      mopID: mopID,
    );
    if (updateActivity.status == "false") {
      setState(() => activities = activities.map((WorkActivity) {
            final isUpdate = WorkActivity == workActivity;

            return isUpdate
                ? WorkActivity.update(
                    activityName: updateActivity.activityName,
                    a: updateActivity.a,
                    b: updateActivity.b,
                    c: updateActivity.c,
                    d: updateActivity.d,
                    e: updateActivity.e,
                    f: updateActivity.f,
                    plannedDateList: updateActivity.plannedDateList,
                    actualDateList: updateActivity.actualDateList,
                    status: updateActivity.status)
                : WorkActivity;
          }).toList());
    } else if (updateActivity.status == "true") {
      setState(() {
        activities.remove(workActivity);
      });
    }
  }

  Widget buildDataTable() {
    final columns = [
      'Activity Name',
      'a %',
      'b %',
      'c %',
      'd %',
      'e %',
      'f %',
      'Planned Date',
      'Actual Date'
    ];

    return DataTable(
      headingRowColor: MaterialStateProperty.all(Colors.blueGrey),
      headingTextStyle: TextStyle(
        color: Colors.white,
      ),
      columnSpacing: (MediaQuery.of(context).size.width / 10) * 0.4,
      dataRowHeight: 65,
      sortAscending: isAscending,
      sortColumnIndex: sortColumnIndex,
      columns: getColumns(columns),
      rows: getRows(activities),
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 2,
            ),
            bottom: BorderSide(
              color: Colors.grey,
              width: 2,
            )),
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
            onSort: onSort,
          ))
      .toList();

  List<DataRow> getRows(List<WorkActivity> activities) =>
      activities.map((WorkActivity workActivity) {
        final cells = [
          workActivity.activityName,
          workActivity.a,
          workActivity.b,
          workActivity.c,
          workActivity.d,
          workActivity.e,
          workActivity.f,
          _getDateText(workActivity.plannedDateList),
          _getDateText(workActivity.actualDateList),
        ];

        // return DataRow(cells: getCells(cells));
        return DataRow(
          cells: Utils.modelBuilder(cells, (index, cell) {
            return DataCell(
              ConstrainedBox(
                constraints: BoxConstraints(
                    maxWidth: (MediaQuery.of(context).size.width / 2.4)),
                // width: (MediaQuery.of(context).size.width / 10) * 1,
                child: Text('$cell'),
              ),
              onTap: () {
                if (prepareStatus == true &&
                    checkedStatus == true &&
                    approveStatus == true &&
                    isPrepareBy == true) {
                  switch (index) {
                    case 0:
                      ShowUpdateMonthlyAcutalDialog(workActivity, mopID);

                      break;
                    case 1:
                      ShowUpdateMonthlyAcutalDialog(workActivity, mopID);
                      break;
                    case 2:
                      ShowUpdateMonthlyAcutalDialog(workActivity, mopID);
                      break;
                    case 3:
                      ShowUpdateMonthlyAcutalDialog(workActivity, mopID);
                      break;
                    case 4:
                      ShowUpdateMonthlyAcutalDialog(workActivity, mopID);
                      break;
                    case 5:
                      ShowUpdateMonthlyAcutalDialog(workActivity, mopID);
                      break;
                    case 6:
                      ShowUpdateMonthlyAcutalDialog(workActivity, mopID);
                      break;
                    case 7:
                      ShowUpdateMonthlyAcutalDialog(workActivity, mopID);
                      break;
                    case 8:
                      ShowUpdateMonthlyAcutalDialog(workActivity, mopID);
                      break;
                  }
                } else if (floatingSubmitBtn == true &&
                    floatingAddBtn == true) {
                  switch (index) {
                    case 0:
                      ShowUpdateMonthlyPlanDialog(workActivity, mopID);

                      break;
                    case 1:
                      ShowUpdateMonthlyPlanDialog(workActivity, mopID);
                      break;
                    case 2:
                      ShowUpdateMonthlyPlanDialog(workActivity, mopID);
                      break;
                    case 3:
                      ShowUpdateMonthlyPlanDialog(workActivity, mopID);
                      break;
                    case 4:
                      ShowUpdateMonthlyPlanDialog(workActivity, mopID);
                      break;
                    case 5:
                      ShowUpdateMonthlyPlanDialog(workActivity, mopID);
                      break;
                    case 6:
                      ShowUpdateMonthlyPlanDialog(workActivity, mopID);
                      break;
                    case 7:
                      ShowUpdateMonthlyPlanDialog(workActivity, mopID);
                      break;
                    case 8:
                      ShowUpdateMonthlyPlanDialog(workActivity, mopID);
                      break;
                  }
                }
              },
              onLongPress: () {
                if (floatingSubmitBtn == true && floatingAddBtn == true) {
                  ShowConfirmationBox(context, workActivity);
                }
              },
            );
          }),
        );
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) => cells
      .map(
        (data) => DataCell(
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 150),
            // width: (MediaQuery.of(context).size.width / 10) * 1,
            child: Text('$data'),
          ),
          onDoubleTap: () {},
        ),
      )
      .toList();

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      activities.sort((workActivity1, workActivity2) => compareString(
          ascending, workActivity1.activityName, workActivity2.activityName));
    } else if (columnIndex == 1) {
      activities.sort((workActivity1, workActivity2) =>
          compareString(ascending, workActivity1.a, workActivity2.a));
    } else if (columnIndex == 2) {
      activities.sort((workActivity1, workActivity2) =>
          compareString(ascending, '${workActivity1.b}', '${workActivity2.b}'));
    } else if (columnIndex == 3) {
      activities.sort((workActivity1, workActivity2) =>
          compareString(ascending, '${workActivity1.c}', '${workActivity2.c}'));
    } else if (columnIndex == 4) {
      activities.sort((workActivity1, workActivity2) =>
          compareString(ascending, '${workActivity1.d}', '${workActivity2.d}'));
    } else if (columnIndex == 5) {
      activities.sort((workActivity1, workActivity2) =>
          compareString(ascending, '${workActivity1.e}', '${workActivity2.e}'));
    } else if (columnIndex == 6) {
      activities.sort((workActivity1, workActivity2) =>
          compareString(ascending, '${workActivity1.f}', '${workActivity2.f}'));
    }

    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }

  void ShowConfirmationBox(BuildContext context, WorkActivity workActivity) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text('Please Confirm'),
            content:
                const Text('Are you sure want to delete this work activity?'),
            actions: [
              // The "Yes" button
              CupertinoDialogAction(
                onPressed: () {
                  setState(() {
                    activities.remove(workActivity);
                    Navigator.of(context).pop();
                  });
                },
                child: const Text('Yes'),
                isDefaultAction: true,
                isDestructiveAction: true,
              ),
              // The "No" button
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'),
                isDefaultAction: false,
                isDestructiveAction: false,
              )
            ],
          );
        });
  }

  void ShowSubmitConfirmationBox() {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure want to submit?'),
            actions: [
              // The "Yes" button
              CupertinoDialogAction(
                onPressed: () {
                  if (activities.isNotEmpty) {
                    setState(() {
                      for (var activity in activities) {
                        detailsListModel.data.add(
                          PlanDetailsModel(
                            mopId: mopID.toString(),
                            nameofworkId: activity.activityID,
                            a: activity.a,
                            b: activity.b,
                            c: activity.c,
                            d: activity.d,
                            e: activity.e,
                            f: activity.f,
                            previousOverallWorkdone: "0",
                            overallWorkdone: "0",
                            modifiedBy: userID.toString(),
                            modifiedDate: DateFormat("yyyy-MM-dd HH:mm:ss")
                                .format(DateTime.now()),
                            plandatebystringvalue:
                                ToStringList(activity.plannedDateList),
                            actualDatebystringvalue: [],
                            // plannedDateList: activity.plannedDateList,
                          ),
                        );
                      }
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MonthlyPlanForm(
                          project: widget.project,
                          monthlyPlan: widget.monthlyPlan,
                        ),
                      ),
                    );
                    planDetailsSend();
                  } else {
                    showErrorMessagePopUp();
                  }
                },
                child: const Text('Submit'),
                isDefaultAction: true,
                isDestructiveAction: true,
                textStyle: TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
              // The "No" button
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
                isDefaultAction: false,
                isDestructiveAction: false,
              )
            ],
          );
        });
  }

  void showErrorMessagePopUp() {
    showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Submit Caution!'),
        content: const Text('Please add at least one activity.'),
        actions: <Widget>[
          TextButton(
              onPressed: () async {
                Navigator.pop(context, 'Cancel');
              },
              child: const Text('OK'))
        ],
      ),
    );
  }

  Future<void> planDetailsSend() async {
    var response = await http.post(
      Uri.parse(addMonthlyPlanDetail_url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(detailsListModel.data),
    );
    if (response.statusCode == 200) {
      updateMonthlyPlanStatus(mopID);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Loading(project: widget.project),
        ),
      );
    }
  }

  void ShowAcceptConfirmationBox() {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure want to Accept?'),
            actions: [
              // The "Yes" button
              CupertinoDialogAction(
                onPressed: () {
                  getAllPersonAndSiteBySiteIDAndPersonID(
                      widget.project.siteID, personID, "Accept");
                },
                child: const Text('Accept'),
                isDefaultAction: true,
                isDestructiveAction: true,
                textStyle: TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
              // The "No" button
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
                isDefaultAction: false,
                isDestructiveAction: false,
              )
            ],
          );
        });
  }

  void ShowRejectConfirmationBox() {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure want to Reject?'),
            actions: [
              // The "Yes" button
              CupertinoDialogAction(
                onPressed: () {
                  getAllPersonAndSiteBySiteIDAndPersonID(
                      widget.project.siteID, personID, "Reject");
                },
                child: const Text('Reject'),
                isDefaultAction: true,
                isDestructiveAction: true,
                textStyle: TextStyle(
                  color: Colors.blueGrey,
                ),
              ),
              // The "No" button
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
                isDefaultAction: false,
                isDestructiveAction: false,
              )
            ],
          );
        });
  }

  Future<void> updateMonthlyPlanStatusSend(mopID, personRole, status) async {
    var response = await http.get(
      Uri.parse(updateMonthlyPlanStatusByMOPIDAndPersonRoleAndStatus_url +
          "mopID=" +
          mopID.toString() +
          "&personRole=" +
          personRole.toString() +
          "&status=" +
          status.toString()),
    );
    if (response.statusCode == 200) {
      if (status != "Nothing") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Loading(project: widget.project),
          ),
        );
      }
    }
  }

  Future<void> updateMonthlyPlanStatus(mopID) async {
    var response = await http.get(
      Uri.parse(
          updateMonthlyPlanStatusByMOPID_url + "mopID=" + mopID.toString()),
    );
  }

  void getOpTypeID() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    opTypeID = pref.getInt('opTypeID');
    operationPlan = pref.getString('operationPlan');
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);

  String _getDateText(
    List<DateTime?> values,
  ) {
    var valueText = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');

    valueText = values.isNotEmpty
        ? values
            .map((v) => v.toString().replaceAll('00:00:00.000', ''))
            .join(', ')
        : '';

    return valueText;
  }

  List<String> ToStringList(List<DateTime?> plannedDateList) {
    List<String> s = <String>[];

    for (var element in plannedDateList) {
      s.add(element.toString());
    }

    return s;
  }
}
