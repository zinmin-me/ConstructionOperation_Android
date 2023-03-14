import 'package:flutter/material.dart';

class WeeklyPlan {
  String projectName;
  String siteCode;
  String startDate;
  String endDate;

  WeeklyPlan(
      {required this.projectName,
      required this.siteCode,
      required this.startDate,
      required this.endDate});
}

List<WeeklyPlan> weeklyPlanList = [
  WeeklyPlan(
    projectName: "DMTL (Basement+11 Storeyed RCC)",
    siteCode: "ASC-20-015",
    startDate: "1-Jan-2022",
    endDate: "7-Jan-2022",
  ),
  WeeklyPlan(
    projectName: "DMTL (Basement+11 Storeyed RCC)",
    siteCode: "ASC-20-015",
    startDate: "7-Jan-2022",
    endDate: "14-Jan-2022",
  ),
  WeeklyPlan(
    projectName: "DMTL (Basement+11 Storeyed RCC)",
    siteCode: "ASC-20-015",
    startDate: "14-Jan-2022",
    endDate: "21-Jan-2022",
  ),
];
