import 'package:construction_flutter_application/models/Project/projects_list_model.dart';
import 'package:construction_flutter_application/view/Daily/daily_plan.dart';
import 'package:construction_flutter_application/view/Monthly/Plan/monthly_plan_form.dart';
import 'package:construction_flutter_application/view/Project/widgets/project_info.dart';
import 'package:construction_flutter_application/view/Report/report.dart';
import 'package:construction_flutter_application/view/Weekly/weekly_plan_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/global.dart';
import '../Monthly/MonthlyLists/monthly_plan_list.dart';
import '../Side Menu/side_menu.dart';

class ProjectDetails extends StatefulWidget {
  final Project project;
  const ProjectDetails({super.key, required this.project});

  @override
  State<ProjectDetails> createState() => _ProjectDetailsState();
}

class _ProjectDetailsState extends State<ProjectDetails> {
  int? userID;
  String? userRole;
  int? personID;
  late String loginName = "";
  late String password = "";
  late String email = "";
  late String personName = "";

  @override
  void initState() {
    super.initState();
    getUser();
  }

  Future<void> setOPTypeID(opTypeID, operationPlan) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt('opTypeID', opTypeID);
    pref.setString('operationPlan', operationPlan);
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SideMenu(),
      appBar: AppBar(
        title: const Text("Projects Details"),
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
                const SizedBox(height: 20),
                ProjectInfo(project: widget.project),

                const SizedBox(height: 50),

                FractionallySizedBox(
                  widthFactor: 1,
                  child: ElevatedButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      minimumSize: Size(150, 80),
                    ),
                    onPressed: () {
                      setOPTypeID(1, "Montly Operation Plan");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MonthlyPlanList(
                                    project: widget.project,
                                  )));
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/monthly.svg",
                      height: 20,
                      width: 20,
                      color: Colors.white,
                    ),
                    label: const Text("Monthly Plan"),
                  ),
                ),

                const SizedBox(height: 30),

                // Login Button
                FractionallySizedBox(
                  widthFactor: 1,
                  child: ElevatedButton.icon(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        minimumSize: Size(150, 80)),
                    onPressed: () {
                      setOPTypeID(2, "Weekly Operation Plan");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WeeklyPlanList(
                                    project: widget.project,
                                  )));
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/weekly.svg",
                      height: 20,
                      width: 20,
                      color: Colors.white,
                    ),
                    label: Text("Weekly Plan"),
                  ),
                ),

                const SizedBox(height: 30),

                FractionallySizedBox(
                  widthFactor: 1,
                  child: ElevatedButton.icon(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        minimumSize: Size(150, 80)),
                    onPressed: () {
                      setOPTypeID(3, "Daily Job Assignment");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DailyPlan(
                                    project: widget.project,
                                  )));
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/daily.svg",
                      height: 20,
                      width: 20,
                      color: Colors.white,
                    ),
                    label: Text("Daily Plan"),
                  ),
                ),

                const SizedBox(height: 30),

                FractionallySizedBox(
                  widthFactor: 1,
                  child: ElevatedButton.icon(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                        minimumSize: Size(150, 80)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Report(
                                    project: widget.project,
                                  )));
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/report.svg",
                      height: 20,
                      width: 20,
                      color: Colors.white,
                    ),
                    label: Text("Reports"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
