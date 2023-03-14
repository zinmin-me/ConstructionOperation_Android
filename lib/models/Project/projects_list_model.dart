import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Project {
  int siteID;
  String projectName;
  String siteCode;
  int date;

  Project(
      {required this.siteID,
      required this.projectName,
      required this.siteCode,
      required this.date});

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      siteID: json['SiteID'],
      projectName: json['SiteName'],
      siteCode: json['SiteCode'],
      date: 0,
    );
  }
}

List<Project> projectList = [];

// List<Project> projectList = [
//   Project(
//       projectName: "DMTL (Basement+11 Storeyed RCC)",
//       siteCode: "ASC-20-015",
//       date: 2018),
//   Project(
//       projectName: "Commercial Project", siteCode: "ASC-21-012", date: 2018),
//   Project(
//       projectName: "Resedential Project", siteCode: "ASC-22-013", date: 2018),
//   Project(projectName: "Goverment Project", siteCode: "ASC-23-014", date: 2018),
//   Project(projectName: "City Mall", siteCode: "ASC-24-015", date: 2018),
// ];

