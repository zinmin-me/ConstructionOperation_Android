import 'package:flutter/material.dart';

class NameOfWork {
  final int id;
  final int opTypeID;
  final String nameOfWork;
  final bool isActive;

  const NameOfWork({
    required this.id,
    required this.opTypeID,
    required this.nameOfWork,
    required this.isActive,
  });

  factory NameOfWork.fromJson(Map<String, dynamic> json) {
    return NameOfWork(
      id: json['ID'],
      opTypeID: json['OPTypeID'],
      nameOfWork: json['NameofWork'],
      isActive: json['Active'],
    );
  }

  factory NameOfWork.fromMap(Map<String, dynamic> json) {
    return NameOfWork(
      id: json['ID'],
      opTypeID: json['OPTypeID'],
      nameOfWork: json['NameofWork'],
      isActive: json['Active'],
    );
  }
}
