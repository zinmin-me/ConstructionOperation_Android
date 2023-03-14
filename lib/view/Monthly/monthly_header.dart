// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:construction_flutter_application/models/Monthly/monthly_plan_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../models/Project/projects_list_model.dart';
import '../../responsive.dart';
import '../../utils/global.dart';

class MonthlyHeader extends StatefulWidget {
  final Project project;
  final MonthlyPlan monthlyPlan;

  const MonthlyHeader(
      {super.key, required this.project, required this.monthlyPlan});

  @override
  State<MonthlyHeader> createState() => _MonthlyHeaderState();
}

class _MonthlyHeaderState extends State<MonthlyHeader> {
  String todayDate = DateFormat("MMMM/ dd/ yyyy").format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Date: ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Flexible(
              child: Text(
                widget.monthlyPlan.month,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blueGrey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Project Name: ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Flexible(
              child: Text(
                widget.project.projectName,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Site Code: ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Flexible(
              child: Text(
                widget.project.siteCode,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "KPI Target: ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Flexible(
              child: Text(
                "100%",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
