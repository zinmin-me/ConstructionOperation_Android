import 'package:flutter/material.dart';

class PersonAndSite {
  final int id;
  final int siteID;
  final int personID;
  final int responsibilityTypeID;
  final bool finished;
  final String responsibilityType;

  const PersonAndSite({
    required this.id,
    required this.siteID,
    required this.personID,
    required this.responsibilityTypeID,
    required this.finished,
    required this.responsibilityType,
  });

  factory PersonAndSite.fromJson(Map<String, dynamic> json) {
    return PersonAndSite(
      id: json['ID'],
      siteID: json['SiteID'],
      personID: json['PersonID'],
      responsibilityTypeID: json['ResponsibilityTypeID'],
      finished: json['Finished'],
      responsibilityType: json['ResponsibilityType'],
    );
  }

  factory PersonAndSite.fromMap(Map<String, dynamic> json) {
    return PersonAndSite(
      id: json['ID'],
      siteID: json['SiteID'],
      personID: json['PersonID'],
      responsibilityTypeID: json['ResponsibilityTypeID'],
      finished: json['Finished'],
      responsibilityType: json['ResponsibilityType'],
    );
  }
}
