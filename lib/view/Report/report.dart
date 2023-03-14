import 'package:construction_flutter_application/models/Project/projects_list_model.dart';
import 'package:construction_flutter_application/view/Project/widgets/project_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/global.dart';
import '../Side Menu/side_menu.dart';

class Report extends StatefulWidget {
  final Project project;
  const Report({super.key, required this.project});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
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
      appBar: AppBar(
        title: const Text("Report"),
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
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
