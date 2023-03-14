import 'dart:convert';
import 'package:construction_flutter_application/models/Monthly/Monthly_Plan/add_month_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../models/Monthly/monthly_plan_list_model.dart';
import '../../../models/PersonAndSite/person_and_site_model.dart';
import '../../../models/Project/projects_list_model.dart';
import '../../../utils/global.dart';
import '../../Side Menu/side_menu.dart';
import '../Plan/monthly_plan_form.dart';
import 'add_month_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class MonthlyPlanList extends StatefulWidget {
  final Project project;

  const MonthlyPlanList({super.key, required this.project});

  @override
  State<MonthlyPlanList> createState() => _MonthlyPlanListState();
}

class _MonthlyPlanListState extends State<MonthlyPlanList> {
  bool isDelete = false;
  bool floatingAddBtn = false;

  int? userID;
  String? userRole;
  int? personID;
  late String loginName = "";
  late String password = "";
  late String email = "";
  late String personName = "";

  List<MonthlyPlan> monthlyPlanList = [];
  List<PersonAndSite> personAndSiteList = [];
  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: floatingAddBtn,
        child: FloatingActionButton(
          backgroundColor: Colors.blueGrey,
          onPressed: () {
            ShowAddMonthPlanDialog(widget.project);
          },
          child: const Icon(Icons.add),
        ),
      ),
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text("Monthly Plan List"),
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
      body: ListView.builder(
        itemCount: monthlyPlanList.length,
        itemBuilder: (context, index) {
          MonthlyPlan monthlyPlan = monthlyPlanList[index];

          return Card(
            child: ListTile(
              leading: leadingIcon(index),
              title: Text(monthlyPlan.month),
              subtitle: Text(widget.project.projectName),
              trailing: Icon(Icons.arrow_forward_rounded),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MonthlyPlanForm(
                      project: widget.project,
                      monthlyPlan: monthlyPlan,
                    ),
                  ),
                );
              },
              onLongPress: () {
                ShowConfirmationBox(context, monthlyPlan);
              },
            ),
          );
        },
      ),
    );
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

    getAllPersonAndSiteBySiteIDAndPersonID(widget.project.siteID, personID);
  }

  Future<void> getAllPersonAndSiteBySiteIDAndPersonID(siteID, personID) async {
    var response = await http.get(
      Uri.parse(getAllPersonAndSiteBySiteIDAndPersonID_url +
          "siteID=" +
          siteID.toString() +
          "&personID=" +
          personID.toString()),
    );
    if (response.body != "") {
      setState(() {
        personAndSiteList = parsePersonAndSiteList(response.body);
        for (var personAndSite in personAndSiteList) {
          if (personAndSite.responsibilityType == "Prepared By") {
            floatingAddBtn = true;
          }
        }
        getAllMonthlyPlanBySiteIDAndPersonRole(
            widget.project.siteID, personAndSiteList[0].responsibilityType);
      });
    }
  }

  static List<PersonAndSite> parsePersonAndSiteList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<PersonAndSite>((json) => PersonAndSite.fromJson(json))
        .toList();
  }

  Future<void> getAllMonthlyPlanBySiteIDAndPersonRole(
      siteID, personRole) async {
    var response = await http.get(
      Uri.parse(getAllMonthlyPlanBySiteIDAndPersonRole_url +
          "siteID=" +
          siteID.toString() +
          "&personRole=" +
          personRole.toString()),
    );
    if (response.body != "") {
      setState(() {
        monthlyPlanList = parseMonthlyPlanList(response.body);
      });
    }
  }

  static List<MonthlyPlan> parseMonthlyPlanList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<MonthlyPlan>((json) => MonthlyPlan.fromJson(json))
        .toList();
  }

  Future<void> deleteMonthlyPlan(
    siteID,
    month,
  ) async {
    var response = await http.get(
      Uri.parse(
        deleteMonthlyPlanBySiteIDAndForTheMonth_url +
            "siteID=" +
            siteID.toString() +
            "&forMonth=" +
            month,
      ),
    );
    if (response.body != "") {
      setState(() {
        monthlyPlanList = parseMonthlyPlanList(response.body);
      });
    }
  }

  leadingIcon(int index) {
    if (monthlyPlanList[index].completePrepareStatus == "null" &&
        monthlyPlanList[index].completeCheckedStatus == "null" &&
        monthlyPlanList[index].completeApprovedStatus == "null") {
      return Icon(
        Icons.assignment_outlined,
      );
    } else if (monthlyPlanList[index].completeCheckedStatus == "false" ||
        monthlyPlanList[index].completeApprovedStatus == "false") {
      return Icon(
        Icons.dangerous_outlined,
        color: Colors.redAccent,
      );
    } else if ((monthlyPlanList[index].completePrepareStatus == "true" &&
            monthlyPlanList[index].completeCheckedStatus == "null" &&
            monthlyPlanList[index].completeApprovedStatus == "null") ||
        (monthlyPlanList[index].completePrepareStatus == "true" &&
            monthlyPlanList[index].completeCheckedStatus == "true" &&
            monthlyPlanList[index].completeApprovedStatus == "null")) {
      return Icon(
        Icons.pending_outlined,
        color: Colors.orange,
      );
    } else if (monthlyPlanList[index].completePrepareStatus == "true" &&
        monthlyPlanList[index].completeCheckedStatus == "true" &&
        monthlyPlanList[index].completeApprovedStatus == "true") {
      return Icon(
        Icons.check_circle_outlined,
        color: Colors.green,
      );
    }
    // else if (monthlyPlanList[index].status == "reject") {
    //   return Icon(
    //     Icons.dangerous_outlined,
    //     color: Colors.redAccent,
    //   );
    // }
  }

  Future ShowAddMonthPlanDialog(Project project) async {
    var addMonth = await ShowAddMonthDialog(
      context,
      project: project,
    );
    // if (addMonth.month == "cancel" || addMonth == null) {
    // } else {
    //   setState(() {
    //     monthlyPlanList.add(addMonth);
    //   });
    // }

    // if (addMonth.e == "" && addMonth.f == "") {
    // } else if (updateActivity.e != "" && updateActivity.f != "") {
    //   setState(() {
    //     activities.add(updateActivity);
    //   });
    // }
  }

  void ShowConfirmationBox(BuildContext context, MonthlyPlan monthlyPlan) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure want to delete this plan?'),
            actions: [
              // The "Yes" button
              CupertinoDialogAction(
                onPressed: () {
                  setState(() {
                    monthlyPlanList.remove(monthlyPlan);
                    deleteMonthlyPlan(
                        widget.project.siteID, monthlyPlan.tempMonth);
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
}
