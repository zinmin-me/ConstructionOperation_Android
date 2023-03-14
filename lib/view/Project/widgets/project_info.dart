import 'package:flutter/material.dart';
import '../../../models/Project/projects_list_model.dart';
import '../../../responsive.dart';
import '../../../utils/global.dart';

class ProjectInfo extends StatelessWidget {
  final Project project;

  const ProjectInfo({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
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
                project.projectName,
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
                project.siteCode,
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
