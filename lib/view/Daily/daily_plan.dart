import 'package:construction_flutter_application/models/Project/projects_list_model.dart';
import 'package:construction_flutter_application/view/Project/widgets/project_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../utils/global.dart';
import '../Side Menu/side_menu.dart';

class DailyPlan extends StatelessWidget {
  final Project project;
  const DailyPlan({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Plan"),
        backgroundColor: bgColor,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [],
            ),
          ),
        ),
      ),
    );
  }
}
