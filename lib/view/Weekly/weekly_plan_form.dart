import 'dart:async';

import 'package:construction_flutter_application/models/Project/projects_list_model.dart';
import 'package:construction_flutter_application/models/Weekly/weekly_plan_list_model.dart';
import 'package:construction_flutter_application/view/Monthly/MonthlyLists/monthly_plan_list.dart';
import 'package:construction_flutter_application/utils/animation.dart';
import 'package:construction_flutter_application/view/Monthly/Plan/add_monthly_dialog.dart';
import 'package:construction_flutter_application/view/Monthly/Plan/add_monthly_dialog.dart';
import 'package:construction_flutter_application/view/Monthly/monthly_header.dart';
import 'package:construction_flutter_application/utils/sample/planned_date.dart';
import 'package:construction_flutter_application/utils/scrollable_widget.dart';
import 'package:construction_flutter_application/view/Monthly/Plan/update_monthly_dialog.dart';
import 'package:construction_flutter_application/view/Weekly/widgets/add_weekly_activity_dialog.dart';

import 'package:construction_flutter_application/view/Weekly/widgets/weekly_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/Monthly/monthly_work_activities_data.dart';
import '../../models/Monthly/monthly_work_activities_model.dart';
import '../../models/Weekly/weekly_work_activities_data.dart';
import '../../models/Weekly/weekly_work_activities_model.dart';
import '../../utils/global.dart';
import '../../utils/utils.dart';
import '../Side Menu/side_menu.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'widgets/update_weekly_activity.dart';

class WeeklyPlanForm extends StatefulWidget {
  final Project project;
  final WeeklyPlan weeklyPlan;
  const WeeklyPlanForm(
      {super.key, required this.project, required this.weeklyPlan});

  @override
  State<WeeklyPlanForm> createState() => _WeeklyPlanFormState();
}

class _WeeklyPlanFormState extends State<WeeklyPlanForm> {
  late List<WeeklyWorkActivity> activities;
  late WeeklyWorkActivity updateActivity;
  int? sortColumnIndex;
  bool isAscending = false;
  @override
  void initState() {
    super.initState();

    this.activities = List.of(allWeeklyActivities);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton.extended(
              onPressed: () {
                ShowSubmitConfirmationBox();
              },
              label: const Text('Submit'),
              icon: const Icon(Icons.upload_file),
              backgroundColor: Colors.blueGrey,
            ),
            Expanded(child: Container()),
            FloatingActionButton(
              heroTag: "btnAdd",
              backgroundColor: Colors.blueGrey,
              onPressed: () {
                ShowAddWeeklyActivityDialog();
              },
              child: const Icon(Icons.add),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Weekly Plan"),
        backgroundColor: bgColor,
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
                WeeklyHeader(
                    project: widget.project, weeklyPlan: widget.weeklyPlan),
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

  Future ShowAddWeeklyActivityDialog() async {
    WeeklyWorkActivity addWeeklyActivity = await AddWeeklyActivityDialog(
      context,
    );

    if (addWeeklyActivity != null) {
      if (!addWeeklyActivity.activityName.isEmpty ||
          addWeeklyActivity.activityName != "") {
        if (!addWeeklyActivity.remarks.isEmpty) {
          setState(() {
            activities.add(addWeeklyActivity);
          });
        } else if (addWeeklyActivity.remarks.isEmpty) {
          if (!addWeeklyActivity.pOne.isEmpty ||
              !addWeeklyActivity.pTwo.isEmpty ||
              !addWeeklyActivity.pThree.isEmpty ||
              !addWeeklyActivity.pFour.isEmpty ||
              !addWeeklyActivity.pFive.isEmpty ||
              !addWeeklyActivity.pSix.isEmpty ||
              !addWeeklyActivity.pSeven.isEmpty) {
            setState(() {
              activities.add(addWeeklyActivity);
            });
          }
        }
      } else {}
    }
  }

  Future ShowUpdateMonthlyPlanDialog(
      WeeklyWorkActivity weeklyWorkActivity) async {
    WeeklyWorkActivity updateweeklyActivity = await UpdateWeeklyActivityDialog(
      context,
      title: '',
      value: weeklyWorkActivity,
    );
    if (updateweeklyActivity.status == "false") {
      setState(() => activities = activities.map((WorkActivity) {
            final isUpdate = WorkActivity == weeklyWorkActivity;

            return isUpdate
                ? WorkActivity.update(
                    activityName: updateweeklyActivity.activityName,
                    pOne: updateweeklyActivity.pOne,
                    aOne: updateweeklyActivity.aOne,
                    pTwo: updateweeklyActivity.pTwo,
                    aTwo: updateweeklyActivity.aTwo,
                    pThree: updateweeklyActivity.pThree,
                    aThree: updateweeklyActivity.aThree,
                    pFour: updateweeklyActivity.pFour,
                    aFour: updateweeklyActivity.aFour,
                    pFive: updateweeklyActivity.pFive,
                    aFive: updateweeklyActivity.aFive,
                    pSix: updateweeklyActivity.pSix,
                    aSix: updateweeklyActivity.aSix,
                    pSeven: updateweeklyActivity.pSeven,
                    aSeven: updateweeklyActivity.aSeven,
                    remarks: updateweeklyActivity.remarks,
                    status: updateweeklyActivity.status)
                : WorkActivity;
          }).toList());
    } else if (updateweeklyActivity.status == "true") {
      setState(() {
        activities.remove(weeklyWorkActivity);
      });
    }
    //
  }

  Widget buildDataTable() {
    final columns = [
      'Name of Work/ Activity',
      'p-1',
      'a-1',
      'p-2',
      'a-2',
      'p-3',
      'a-3',
      'p-4',
      'a-4',
      'p-5',
      'a-5',
      'p-6',
      'a-6',
      'p-7',
      'a-7',
      'Remarks'
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

  List<DataRow> getRows(List<WeeklyWorkActivity> activities) =>
      activities.map((WeeklyWorkActivity weeklyWorkActivity) {
        final cells = [
          weeklyWorkActivity.activityName,
          weeklyWorkActivity.pOne,
          weeklyWorkActivity.aOne,
          weeklyWorkActivity.pTwo,
          weeklyWorkActivity.aTwo,
          weeklyWorkActivity.pThree,
          weeklyWorkActivity.aThree,
          weeklyWorkActivity.pFour,
          weeklyWorkActivity.aFour,
          weeklyWorkActivity.pFive,
          weeklyWorkActivity.aFive,
          weeklyWorkActivity.pSix,
          weeklyWorkActivity.aSix,
          weeklyWorkActivity.pSeven,
          weeklyWorkActivity.aSeven,
          weeklyWorkActivity.remarks,
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
                switch (index) {
                  case 0:
                    ShowUpdateMonthlyPlanDialog(weeklyWorkActivity);

                    break;
                  case 1:
                    ShowUpdateMonthlyPlanDialog(weeklyWorkActivity);
                    break;
                  case 2:
                    ShowUpdateMonthlyPlanDialog(weeklyWorkActivity);
                    break;
                  case 3:
                    ShowUpdateMonthlyPlanDialog(weeklyWorkActivity);
                    break;
                  case 4:
                    ShowUpdateMonthlyPlanDialog(weeklyWorkActivity);
                    break;
                  case 5:
                    ShowUpdateMonthlyPlanDialog(weeklyWorkActivity);
                    break;
                  case 6:
                    ShowUpdateMonthlyPlanDialog(weeklyWorkActivity);
                    break;
                }
              },
              onLongPress: () {
                ShowConfirmationBox(context, weeklyWorkActivity);
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
          compareString(ascending, workActivity1.pOne, workActivity2.pOne));
    } else if (columnIndex == 2) {
      activities.sort((workActivity1, workActivity2) => compareString(
          ascending, '${workActivity1.aOne}', '${workActivity2.aOne}'));
    } else if (columnIndex == 3) {
      activities.sort((workActivity1, workActivity2) => compareString(
          ascending, '${workActivity1.pTwo}', '${workActivity2.pTwo}'));
    } else if (columnIndex == 4) {
      activities.sort((workActivity1, workActivity2) => compareString(
          ascending, '${workActivity1.aTwo}', '${workActivity2.aTwo}'));
    } else if (columnIndex == 5) {
      activities.sort((workActivity1, workActivity2) => compareString(
          ascending, '${workActivity1.pThree}', '${workActivity2.pThree}'));
    } else if (columnIndex == 6) {
      activities.sort((workActivity1, workActivity2) => compareString(
          ascending, '${workActivity1.aThree}', '${workActivity2.aThree}'));
    } else if (columnIndex == 7) {
      activities.sort((workActivity1, workActivity2) => compareString(
          ascending, '${workActivity1.pFour}', '${workActivity2.pFour}'));
    } else if (columnIndex == 8) {
      activities.sort((workActivity1, workActivity2) => compareString(
          ascending, '${workActivity1.aFour}', '${workActivity2.aFour}'));
    } else if (columnIndex == 9) {
      activities.sort((workActivity1, workActivity2) => compareString(
          ascending, '${workActivity1.pFive}', '${workActivity2.pFive}'));
    } else if (columnIndex == 10) {
      activities.sort((workActivity1, workActivity2) => compareString(
          ascending, '${workActivity1.aFive}', '${workActivity2.aFive}'));
    } else if (columnIndex == 11) {
      activities.sort((workActivity1, workActivity2) => compareString(
          ascending, '${workActivity1.pSix}', '${workActivity2.pSix}'));
    } else if (columnIndex == 12) {
      activities.sort((workActivity1, workActivity2) => compareString(
          ascending, '${workActivity1.aSix}', '${workActivity2.aSix}'));
    } else if (columnIndex == 13) {
      activities.sort((workActivity1, workActivity2) => compareString(
          ascending, '${workActivity1.pSeven}', '${workActivity2.pSeven}'));
    } else if (columnIndex == 14) {
      activities.sort((workActivity1, workActivity2) => compareString(
          ascending, '${workActivity1.aSeven}', '${workActivity2.aSeven}'));
    } else if (columnIndex == 15) {
      activities.sort((workActivity1, workActivity2) => compareString(
          ascending, '${workActivity1.remarks}', '${workActivity2.remarks}'));
    }

    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }

  void ShowConfirmationBox(
      BuildContext context, WeeklyWorkActivity weeklyWorkActivity) {
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
                    activities.remove(weeklyWorkActivity);
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
                  setState(() {
                    // Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Loading(project: widget.project),
                      ),
                    );
                    // Timer(const Duration(seconds: 1), () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => MonthlyPlanList(
                    //         project: widget.project,
                    //       ),
                    //     ),
                    //   );
                    // });
                  });
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

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}
