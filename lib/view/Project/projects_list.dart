import 'dart:convert';

import 'package:construction_flutter_application/view/Project/project_details.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/Project/projects_list_model.dart';
import '../../utils/global.dart';
import '../Side Menu/side_menu.dart';
import 'package:http/http.dart' as http;

class ProjectsList extends StatefulWidget {
  const ProjectsList({super.key});

  @override
  State<ProjectsList> createState() => _ProjectsListState();
}

class _ProjectsListState extends State<ProjectsList> {
  int? userID;
  String? userRole;
  int? personID;
  late String loginName = "";
  late String password = "";
  late String email = "";
  late String personName = "";

  List<Project> projectList = [];

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: SideMenu(),
        appBar: AppBar(
          title: Text("Projects List"),
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
            itemCount: projectList.length,
            itemBuilder: (context, index) {
              Project project = projectList[index];
              return Card(
                child: ListTile(
                  title: Text(project.projectName),
                  subtitle: Text(project.siteCode),
                  trailing: Icon(Icons.arrow_forward_rounded),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProjectDetails(
                                  project: project,
                                )));
                  },
                ),
              );
            }));
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
    getProjectListByUserID(userID);
  }

  Future<void> getProjectListByUserID(userID) async {
    var response = await http.get(
      Uri.parse(getAllProjectByUserID_url + "id=" + userID.toString()),
    );
    if (response.body != "") {
      setState(() {
        projectList = parseProjectList(response.body);
      });
    }
  }

  static List<Project> parseProjectList(String responseBody) {
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Project>((json) => Project.fromJson(json)).toList();
  }
}
