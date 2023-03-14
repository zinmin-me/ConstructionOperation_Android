import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class User {
  final int userId;
  final String userRole;
  final String loginName;
  final String password;
  final String email;
  final String personName;
  final bool isActive;
  final int personId;

  const User({
    required this.userId,
    required this.userRole,
    required this.loginName,
    required this.password,
    required this.email,
    required this.personName,
    required this.isActive,
    required this.personId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['ID'],
      userRole: json['UserRole'],
      loginName: json['LoginName'],
      password: json['Password'],
      email: json['Email'],
      personName: json['PersonName'],
      isActive: json['IsActive'],
      personId: json['PersonID'],
    );
  }

  factory User.fromMap(Map<String, dynamic> json) {
    return User(
      userId: json['ID'],
      userRole: json['UserRole'],
      loginName: json['LoginName'],
      password: json['Password'],
      email: json['Email'],
      personName: json['PersonName'],
      isActive: json['IsActive'],
      personId: json['PersonID'],
    );
  }
}
