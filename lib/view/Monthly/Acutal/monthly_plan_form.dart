// import 'dart:async';
// import 'dart:convert';

// import 'package:construction_flutter_application/models/Monthly/monthly_plan_list_model.dart';
// import 'package:construction_flutter_application/models/Project/projects_list_model.dart';
// import 'package:construction_flutter_application/view/Monthly/MonthlyLists/monthly_plan_list.dart';
// import 'package:construction_flutter_application/utils/animation.dart';
// import 'package:construction_flutter_application/view/Monthly/Plan/add_monthly_dialog.dart';
// import 'package:construction_flutter_application/view/Monthly/Plan/add_monthly_dialog.dart';
// import 'package:construction_flutter_application/view/Monthly/monthly_header.dart';
// import 'package:construction_flutter_application/utils/sample/planned_date.dart';
// import 'package:construction_flutter_application/utils/scrollable_widget.dart';
// import 'package:construction_flutter_application/view/Monthly/Plan/update_monthly_dialog.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// import '../../../models/Monthly/monthly_work_activities_data.dart';
// import '../../../models/Monthly/monthly_work_activities_model.dart';
// import '../../../utils/global.dart';
// import '../../../utils/utils.dart';
// import '../../Side Menu/side_menu.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:http/http.dart' as http;

// class MonthlyPlanForm extends StatefulWidget {
//   final Project project;
//   final MonthlyPlan monthlyPlan;
//   const MonthlyPlanForm(
//       {super.key, required this.project, required this.monthlyPlan});

//   @override
//   State<MonthlyPlanForm> createState() => _MonthlyPlanFormState();
// }

// class _MonthlyPlanFormState extends State<MonthlyPlanForm> {
//   late List<WorkActivity> activities;
//   late WorkActivity updateActivity;

//   List<WorkActivity> allActivities = [];

//   int? sortColumnIndex;
//   bool isAscending = false;
//   @override
//   void initState() {
//     super.initState();

//     this.activities = List.of(allActivities);
//     getAllMonthlyPlanBySiteId(widget.project.siteID, "");
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.only(left: 30),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             FloatingActionButton.extended(
//               onPressed: () {
//                 ShowSubmitConfirmationBox();
//               },
//               label: const Text('Submit'),
//               icon: const Icon(Icons.upload_file),
//               backgroundColor: Colors.blueGrey,
//             ),
//             Expanded(child: Container()),
//             FloatingActionButton(
//               heroTag: "btnAdd",
//               backgroundColor: Colors.blueGrey,
//               onPressed: () {
//                 ShowAddMonthlyPlanDialog();
//               },
//               child: const Icon(Icons.add),
//             ),
//           ],
//         ),
//       ),
//       appBar: AppBar(
//         title: const Text("Monthly Plan"),
//         backgroundColor: bgColor,
//       ),
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(15.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // const SizedBox(height: 20),
//                 MonthlyHeader(
//                   project: widget.project,
//                   monthlyPlan: widget.monthlyPlan,
//                 ),
//                 const SizedBox(height: 50),
//                 FractionallySizedBox(
//                   widthFactor: 1,
//                   child: ScrollableWidget(child: buildDataTable()),
//                 ),
//                 const SizedBox(height: 50),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> getAllMonthlyPlanBySiteId(siteID, forTheMonth) async {
//     var response = await http.get(
//       Uri.parse(getAllMonthlyPlanDetailsBySiteIDAndForthemonth_url +
//           "siteID=" +
//           siteID.toString() +
//           "&month=9/1/2022"),
//     );
//     setState(() {
//       allActivities = parseMonthlyPlanList(response.body);
//     });
//   }

//   static List<WorkActivity> parseMonthlyPlanList(String responseBody) {
//     final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
//     return parsed
//         .map<WorkActivity>((json) => WorkActivity.fromJson(json))
//         .toList();
//   }

//   Future ShowAddMonthlyPlanDialog() async {
//     WorkActivity updateActivity = await ShowAddMonthlyDialog(
//       context,
//       1,
//     );
//     if (updateActivity.e == "") {
//     } else if (updateActivity.e != "") {
//       setState(() {
//         activities.add(updateActivity);
//       });
//     }
//   }

//   Future ShowUpdateMonthlyPlanDialog(WorkActivity workActivity) async {
//     WorkActivity updateActivity = await ShowUpdateMonthlyDialog(
//       context,
//       title: '',
//       value: workActivity,
//     );
//     if (updateActivity.status == "false") {
//       setState(() => activities = activities.map((WorkActivity) {
//             final isUpdate = WorkActivity == workActivity;

//             return isUpdate
//                 ? WorkActivity.update(
//                     activityName: updateActivity.activityName,
//                     a: updateActivity.a,
//                     b: updateActivity.b,
//                     c: updateActivity.c,
//                     d: updateActivity.d,
//                     e: updateActivity.e,
//                     f: updateActivity.f,
//                     plannedDateList: updateActivity.plannedDateList,
//                     actualDateList: updateActivity.actualDateList,
//                     status: updateActivity.status)
//                 : WorkActivity;
//           }).toList());
//     } else if (updateActivity.status == "true") {
//       setState(() {
//         activities.remove(workActivity);
//       });
//     }
//   }

//   Widget buildDataTable() {
//     final columns = [
//       'Activity Name',
//       'a %',
//       'b %',
//       'c %',
//       'd %',
//       'e %',
//       'f %',
//       'Planned Date',
//       'Actual Date'
//     ];

//     return DataTable(
//       headingRowColor: MaterialStateProperty.all(Colors.blueGrey),
//       headingTextStyle: TextStyle(
//         color: Colors.white,
//       ),
//       columnSpacing: (MediaQuery.of(context).size.width / 10) * 0.4,
//       dataRowHeight: 65,
//       sortAscending: isAscending,
//       sortColumnIndex: sortColumnIndex,
//       columns: getColumns(columns),
//       rows: getRows(activities),
//       decoration: BoxDecoration(
//         border: Border(
//             top: BorderSide(
//               color: Colors.grey,
//               width: 2,
//             ),
//             bottom: BorderSide(
//               color: Colors.grey,
//               width: 2,
//             )),
//       ),
//     );
//   }

//   List<DataColumn> getColumns(List<String> columns) => columns
//       .map((String column) => DataColumn(
//             label: Text(column),
//             onSort: onSort,
//           ))
//       .toList();

//   List<DataRow> getRows(List<WorkActivity> activities) =>
//       activities.map((WorkActivity workActivity) {
//         final cells = [
//           workActivity.activityName,
//           workActivity.a,
//           workActivity.b,
//           workActivity.c,
//           workActivity.d,
//           workActivity.e,
//           workActivity.f,
//           _getDateText(workActivity.plannedDateList),
//           _getDateText(workActivity.actualDateList),
//         ];

//         // return DataRow(cells: getCells(cells));
//         return DataRow(
//           cells: Utils.modelBuilder(cells, (index, cell) {
//             return DataCell(
//               ConstrainedBox(
//                 constraints: BoxConstraints(
//                     maxWidth: (MediaQuery.of(context).size.width / 2.4)),
//                 // width: (MediaQuery.of(context).size.width / 10) * 1,
//                 child: Text('$cell'),
//               ),
//               onTap: () {
//                 switch (index) {
//                   case 0:
//                     ShowUpdateMonthlyPlanDialog(workActivity);

//                     break;
//                   case 1:
//                     ShowUpdateMonthlyPlanDialog(workActivity);
//                     break;
//                   case 2:
//                     ShowUpdateMonthlyPlanDialog(workActivity);
//                     break;
//                   case 3:
//                     ShowUpdateMonthlyPlanDialog(workActivity);
//                     break;
//                   case 4:
//                     ShowUpdateMonthlyPlanDialog(workActivity);
//                     break;
//                   case 5:
//                     ShowUpdateMonthlyPlanDialog(workActivity);
//                     break;
//                   case 6:
//                     ShowUpdateMonthlyPlanDialog(workActivity);
//                     break;
//                   case 7:
//                     ShowUpdateMonthlyPlanDialog(workActivity);
//                     break;
//                   case 8:
//                     ShowUpdateMonthlyPlanDialog(workActivity);
//                     break;
//                 }
//               },
//               onLongPress: () {
//                 ShowConfirmationBox(context, workActivity);
//               },
//             );
//           }),
//         );
//       }).toList();

//   List<DataCell> getCells(List<dynamic> cells) => cells
//       .map(
//         (data) => DataCell(
//           ConstrainedBox(
//             constraints: BoxConstraints(maxWidth: 150),
//             // width: (MediaQuery.of(context).size.width / 10) * 1,
//             child: Text('$data'),
//           ),
//           onDoubleTap: () {},
//         ),
//       )
//       .toList();

//   void onSort(int columnIndex, bool ascending) {
//     if (columnIndex == 0) {
//       activities.sort((workActivity1, workActivity2) => compareString(
//           ascending, workActivity1.activityName, workActivity2.activityName));
//     } else if (columnIndex == 1) {
//       activities.sort((workActivity1, workActivity2) =>
//           compareString(ascending, workActivity1.a, workActivity2.a));
//     } else if (columnIndex == 2) {
//       activities.sort((workActivity1, workActivity2) =>
//           compareString(ascending, '${workActivity1.b}', '${workActivity2.b}'));
//     } else if (columnIndex == 3) {
//       activities.sort((workActivity1, workActivity2) =>
//           compareString(ascending, '${workActivity1.c}', '${workActivity2.c}'));
//     } else if (columnIndex == 4) {
//       activities.sort((workActivity1, workActivity2) =>
//           compareString(ascending, '${workActivity1.d}', '${workActivity2.d}'));
//     } else if (columnIndex == 5) {
//       activities.sort((workActivity1, workActivity2) =>
//           compareString(ascending, '${workActivity1.e}', '${workActivity2.e}'));
//     } else if (columnIndex == 6) {
//       activities.sort((workActivity1, workActivity2) =>
//           compareString(ascending, '${workActivity1.f}', '${workActivity2.f}'));
//     }

//     setState(() {
//       this.sortColumnIndex = columnIndex;
//       this.isAscending = ascending;
//     });
//   }

//   void ShowConfirmationBox(BuildContext context, WorkActivity workActivity) {
//     showCupertinoDialog(
//         context: context,
//         builder: (BuildContext ctx) {
//           return CupertinoAlertDialog(
//             title: const Text('Please Confirm'),
//             content:
//                 const Text('Are you sure want to delete this work activity?'),
//             actions: [
//               // The "Yes" button
//               CupertinoDialogAction(
//                 onPressed: () {
//                   setState(() {
//                     activities.remove(workActivity);
//                     Navigator.of(context).pop();
//                   });
//                 },
//                 child: const Text('Yes'),
//                 isDefaultAction: true,
//                 isDestructiveAction: true,
//               ),
//               // The "No" button
//               CupertinoDialogAction(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('No'),
//                 isDefaultAction: false,
//                 isDestructiveAction: false,
//               )
//             ],
//           );
//         });
//   }

//   void ShowSubmitConfirmationBox() {
//     showCupertinoDialog(
//         context: context,
//         builder: (BuildContext ctx) {
//           return CupertinoAlertDialog(
//             title: const Text('Please Confirm'),
//             content: const Text('Are you sure want to submit?'),
//             actions: [
//               // The "Yes" button
//               CupertinoDialogAction(
//                 onPressed: () {
//                   setState(() {
//                     // Navigator.of(context).pop();
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Loading(project: widget.project),
//                       ),
//                     );
//                     // Timer(const Duration(seconds: 1), () {
//                     //   Navigator.push(
//                     //     context,
//                     //     MaterialPageRoute(
//                     //       builder: (context) => MonthlyPlanList(
//                     //         project: widget.project,
//                     //       ),
//                     //     ),
//                     //   );
//                     // });
//                   });
//                 },
//                 child: const Text('Submit'),
//                 isDefaultAction: true,
//                 isDestructiveAction: true,
//                 textStyle: TextStyle(
//                   color: Colors.blueGrey,
//                 ),
//               ),
//               // The "No" button
//               CupertinoDialogAction(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('Cancel'),
//                 isDefaultAction: false,
//                 isDestructiveAction: false,
//               )
//             ],
//           );
//         });
//   }

//   int compareString(bool ascending, String value1, String value2) =>
//       ascending ? value1.compareTo(value2) : value2.compareTo(value1);

//   String _getDateText(
//     List<DateTime?> values,
//   ) {
//     var valueText = (values.isNotEmpty ? values[0] : null)
//         .toString()
//         .replaceAll('00:00:00.000', '');

//     valueText = values.isNotEmpty
//         ? values
//             .map((v) => v.toString().replaceAll('00:00:00.000', ''))
//             .join(', ')
//         : '';

//     return valueText;
//   }
// }
