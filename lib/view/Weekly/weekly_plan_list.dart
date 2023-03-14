import 'package:construction_flutter_application/view/Weekly/weekly_plan_form.dart';
import 'package:construction_flutter_application/view/Weekly/widgets/add_week_dialog.dart';
import 'package:flutter/material.dart';

import '../../models/Weekly/weekly_plan_list_model.dart';
import '../../models/Project/projects_list_model.dart';
import '../../utils/global.dart';
import '../Side Menu/side_menu.dart';

import 'package:flutter/cupertino.dart';

class WeeklyPlanList extends StatefulWidget {
  final Project project;
  const WeeklyPlanList({super.key, required this.project});

  @override
  State<WeeklyPlanList> createState() => _WeeklyPlanListState();
}

class _WeeklyPlanListState extends State<WeeklyPlanList> {
  bool isDelete = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () {
          ShowAddWeekPlanDialog(widget.project);
        },
        child: const Icon(Icons.add),
      ),
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text("Weekly Plan List"),
        backgroundColor: bgColor,
      ),
      body: ListView.builder(
        itemCount: weeklyPlanList.length,
        itemBuilder: (context, index) {
          WeeklyPlan weeklyPlan = weeklyPlanList[index];
          return Card(
            child: ListTile(
              title: Text(weeklyPlan.startDate + " to " + weeklyPlan.endDate),
              subtitle: Text(widget.project.projectName),
              trailing: Icon(Icons.arrow_forward_rounded),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeeklyPlanForm(
                      project: widget.project,
                      weeklyPlan: weeklyPlan,
                    ),
                  ),
                );
              },
              onLongPress: () {
                ShowConfirmationBox(context, weeklyPlan);
              },
            ),
          );
        },
      ),
    );
  }

  Future ShowAddWeekPlanDialog(Project project) async {
    WeeklyPlan addWeek = await ShowAddWeekDialog(
      context,
      value: project,
    );
    if (addWeek.startDate == "cancel") {
    } else {
      setState(() {
        weeklyPlanList.add(addWeek);
      });
    }
  }

  void ShowConfirmationBox(BuildContext context, WeeklyPlan weeklyPlan) {
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
                    weeklyPlanList.remove(weeklyPlan);
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
