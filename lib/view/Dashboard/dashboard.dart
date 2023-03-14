import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/Monthly/monthly_plan_list_model.dart';
import '../../models/PersonAndSite/person_and_site_model.dart';
import '../../models/Project/projects_list_model.dart';
import '../../utils/global.dart';
import '../Monthly/Plan/monthly_plan_form.dart';
import '../Side Menu/side_menu.dart';
import 'package:http/http.dart' as http;

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  int? userID;
  String? userRole;
  int? personID;
  late String loginName = "";
  late String password = "";
  late String email = "";
  late String personName = "";

  List<MonthlyPlan> monthlyPlanList = [];
  List<PersonAndSite> personAndSiteList = [];
  late Project project;
  @override
  void initState() {
    super.initState();
    project = new Project(siteID: 0, projectName: "", siteCode: "", date: 0);
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text("Dashboard"),
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
              subtitle: Text(monthlyPlan.projectName),
              trailing: Icon(Icons.arrow_forward_rounded),
              onTap: () {
                setState(() {
                  project = new Project(
                      siteID: monthlyPlan.siteID,
                      projectName: monthlyPlan.projectName,
                      siteCode: monthlyPlan.siteCode,
                      date: 0);
                });

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MonthlyPlanForm(
                      project: project,
                      monthlyPlan: monthlyPlan,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
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
    getAllPersonAndSiteByPersonID(personID);
  }

  Future<void> getAllPersonAndSiteByPersonID(personID) async {
    var response = await http.get(
      Uri.parse(getAllPersonAndSiteByPersonID_url +
          "personID=" +
          personID.toString()),
    );
    if (response.body != "") {
      setState(() {
        personAndSiteList = parsePersonAndSiteList(response.body);
        getAllMonthlyPlanByPersonRole(
            personID, personAndSiteList[0].responsibilityType);
      });
    }
  }

  static List<PersonAndSite> parsePersonAndSiteList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed
        .map<PersonAndSite>((json) => PersonAndSite.fromJson(json))
        .toList();
  }

  Future<void> getAllMonthlyPlanByPersonRole(personID, personRole) async {
    var response = await http.get(
      Uri.parse(getAllMonthlyPlanByPersonIDAndPersonRole_url +
          "personID=" +
          personID.toString() +
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
}
