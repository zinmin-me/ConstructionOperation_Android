import 'dart:async';

import 'package:construction_flutter_application/view/Monthly/MonthlyLists/monthly_plan_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../models/Project/projects_list_model.dart';
import 'package:get/get.dart';

import 'global.dart';
import '../view/Side Menu/side_menu.dart';

class Loading extends StatelessWidget {
  final Project project;

  const Loading({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Get.to(MonthlyPlanList(
        project: project,
      ));
    });
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text("Monthly Plan List"),
        backgroundColor: bgColor,
      ),
      // backgroundColor: Colors.blueGrey,
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.blueGrey,
          size: 100,
        ),
      ),
    );
  }
}
