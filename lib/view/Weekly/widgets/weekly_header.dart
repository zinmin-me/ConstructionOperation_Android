// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:construction_flutter_application/models/Weekly/weekly_plan_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../models/Project/projects_list_model.dart';
import '../../../responsive.dart';
import '../../../utils/global.dart';

class WeeklyHeader extends StatefulWidget {
  final Project project;
  final WeeklyPlan weeklyPlan;

  const WeeklyHeader(
      {super.key, required this.project, required this.weeklyPlan});

  @override
  State<WeeklyHeader> createState() => _WeeklyHeaderState();
}

class _WeeklyHeaderState extends State<WeeklyHeader> {
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
            ElevatedButton.icon(
              style: TextButton.styleFrom(backgroundColor: Colors.blueGrey),
              onPressed: () async {
                DateTime? newDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: bgColor, // <-- SEE HERE
                          onPrimary: Colors.white, // <-- SEE HERE
                          // onSurface: Colors.blueAccent, // <-- SEE HERE
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                              // primary: Colors.red, // button text color
                              ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                //if 'Cancel' => null
                if (newDate == null) return;

                //if 'Ok' =>DateTime
                setState(() {
                  todayDate = DateFormat("MMMM/ dd/ yyyy").format(newDate);
                });
              },
              icon: SvgPicture.asset(
                "assets/icons/weekly.svg",
                height: 20,
                width: 20,
                color: Colors.white,
              ),
              label: Text(todayDate),
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
              "Weekly Plan Date: ",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Flexible(
              child: Text(
                widget.weeklyPlan.startDate +
                    " to " +
                    widget.weeklyPlan.endDate,
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
