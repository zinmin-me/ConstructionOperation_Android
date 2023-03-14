import 'dart:async';

import 'package:construction_flutter_application/utils/global.colors.dart';
import 'package:construction_flutter_application/utils/global.dart';
import 'package:construction_flutter_application/view/Login/login.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Get.to(LoginView());
    });
    return Scaffold(
      body: Center(
        child: Image.asset('assets/images/asc.png'),
      ),
    );
  }
}
