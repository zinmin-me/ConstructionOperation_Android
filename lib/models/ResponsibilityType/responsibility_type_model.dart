import 'package:flutter/material.dart';

class ResponsibilityType {
  final int responsibilityTypeID;
  final String type;

  const ResponsibilityType({
    required this.responsibilityTypeID,
    required this.type,
  });

  factory ResponsibilityType.fromJson(Map<String, dynamic> json) {
    return ResponsibilityType(
      responsibilityTypeID: json['ID'],
      type: json['Type'],
    );
  }

  factory ResponsibilityType.fromMap(Map<String, dynamic> json) {
    return ResponsibilityType(
      responsibilityTypeID: json['ID'],
      type: json['Type'],
    );
  }
}
