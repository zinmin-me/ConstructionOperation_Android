// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:construction_flutter_application/models/Monthly/Monthly_Plan/add_month_model.dart';
import 'package:construction_flutter_application/models/PersonAndSite/person_and_site_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/Monthly/monthly_plan_list_model.dart';
import '../../../models/Project/projects_list_model.dart';

import '../../../models/ResponsibilityType/responsibility_type_model.dart';
import '../../../models/User/user_model.dart';
import '../../../responsive.dart';
import '../../../utils/global.dart';
import '../../Login/widgets/text.form.global.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import 'monthly_plan_list.dart';

var today = DateUtils.dateOnly(DateTime.now());

Future<T?> ShowAddMonthDialog<T>(
  BuildContext context, {
  required Project project,
}) =>
    showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AddMonthDialog(
        project: project,
      ),
    );

class AddMonthDialog extends StatefulWidget {
  final Project project;
  DateRangePickerController datePickerController = DateRangePickerController();

  List<DateTime?> plannedDateList = <DateTime>[];
  List<DateTime?> actualDateList = <DateTime>[];

  AddMonthDialog({
    super.key,
    required this.project,
  });

  @override
  State<AddMonthDialog> createState() => _AddMonthDialogState();
}

class _AddMonthDialogState extends State<AddMonthDialog> {
  late TextEditingController siteNameController;
  late TextEditingController siteCodeController;

  late AddMonth addMonthModel = [] as AddMonth;

  int? userID;
  String? userRole;
  int? personID;

  int? responsibilityTypeID;
  int? checkedPersonID;
  int? approvePersonID;

  String prepare = "Prepared By";
  String receive = "Received By";
  String checked = "Checked By";
  String approve = "Approved By";

  DateRangePickerController datePickerController = DateRangePickerController();

  String todayDate = DateFormat("MMMM - yyyy").format(DateTime.now());
  String pickDate = DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now());

  @override
  void initState() {
    super.initState();
    siteNameController =
        TextEditingController(text: widget.project.projectName);
    siteCodeController = TextEditingController(text: widget.project.siteCode);
    getUser();
    getAllResponsibilityTypeByType(checked);
    getAllResponsibilityTypeByType(approve);
  }

  void getUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    userID = pref.getInt('userID');
    userRole = pref.getString('userRole');
    personID = pref.getInt('personID');
  }

  Future<void> getAllResponsibilityTypeByType(type) async {
    var response = await http.get(
      Uri.parse("${getAllResponsibilityTypeByType_url}type=$type"),
    );
    if (response.statusCode == 200 && response.contentLength != 0) {
      responsibilityTypeID =
          ResponsibilityType.fromJson(jsonDecode(response.body))
              .responsibilityTypeID;
      getAllPersonAndSiteBySiteIDAndResponsibilityTypeID(
          widget.project.siteID, responsibilityTypeID);
    }
  }

  Future<void> getAllPersonAndSiteBySiteIDAndResponsibilityTypeID(
      siteID, responsibilityTypeID) async {
    var response = await http.get(
      Uri.parse(
          "${getAllPersonAndSiteBySiteIDAndResponsibilityTypeID_url}siteID=$siteID&responsibilityTypeID=$responsibilityTypeID"),
    );
    if (response.statusCode == 200 && response.contentLength != 0) {
      if (PersonAndSite.fromJson(jsonDecode(response.body))
              .responsibilityType ==
          "Checked By") {
        checkedPersonID =
            PersonAndSite.fromJson(jsonDecode(response.body)).personID;
      } else if (PersonAndSite.fromJson(jsonDecode(response.body))
              .responsibilityType ==
          "Approved By") {
        approvePersonID =
            PersonAndSite.fromJson(jsonDecode(response.body)).personID;
      }
    }
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        contentPadding: EdgeInsets.only(left: 20, right: 20),
        // title: Center(child: Text("Information")),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: Container(
          // height: (MediaQuery.of(context).size.height / 2),
          width: (MediaQuery.of(context).size.width),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                            labelText: 'Project Name',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(15),
                            )),
                        controller: siteNameController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                            labelText: 'Site Code',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(15),
                            )),
                        controller: siteCodeController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton.icon(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blueGrey),
                      onPressed: () async {
                        showMonthPicker(
                          headerColor: bgColor,
                          headerTextColor: Colors.white,
                          selectedMonthBackgroundColor: bgColor,
                          selectedMonthTextColor: Colors.white,
                          unselectedMonthTextColor: bgColor,
                          customHeight:
                              (MediaQuery.of(context).size.height / 2),

                          context: context,
                          firstDate: DateTime(DateTime.now().year - 1, 5),
                          lastDate: DateTime(DateTime.now().year + 1, 9),
                          initialDate: DateTime.now(),
                          // locale: Locale("es"),
                        ).then((date) {
                          if (date != null) {
                            setState(() {
                              todayDate =
                                  DateFormat("MMMM - yyyy").format(date);
                              pickDate = DateFormat("yyyy-MM-dd HH:mm:ss")
                                  .format(date);
                            });
                          }
                        });
                      },
                      icon: SvgPicture.asset(
                        "assets/icons/weekly.svg",
                        height: 20,
                        width: 20,
                        color: Colors.white,
                      ),
                      label: Text(todayDate),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: ElevatedButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      minimumSize: Size(150, 60),
                    ),
                    onPressed: () {
                      getAllMonthlyPlanBySiteIdAndForMonth(
                          widget.project.siteID, pickDate);
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/add.svg",
                      height: 18,
                      width: 18,
                      color: Colors.white,
                    ),
                    label: Text("Add"),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );

  // Future<void> addMonthDataSend() async {
  //   var response = await http.post(
  //     Uri.parse(addMonthlyPlan_url),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: jsonEncode(addMonthModel),
  //   );
  //   if (response.statusCode == 200) {
  //     Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => MonthlyPlanList(
  //                   project: widget.project,
  //                 )));
  //   } else {
  //     throw Exception('Failed to Add Monthly Plan.');
  //   }
  // }

  Future<AddMonth> addMonth(
    siteID,
    month,
    date,
    prepareBy,
    completePrepareStatus,
    checkedBy,
    completeCheckedStatus,
    approveBy,
    completeApprovedStatus,
    deleteStatus,
    modifiedBy,
    modifiedDate,
  ) async {
    final response = await http.post(
      Uri.parse(addMonthlyPlan_url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'SiteID': siteID as int,
        'FortheMonth': month as String,
        'Date': date as String,
        'PreparedBy': prepareBy as int,
        'CompletePrepare': completePrepareStatus,
        'CheckedBy': checkedBy as int,
        'CompleteChecked': completeCheckedStatus,
        'ApproveBy': approveBy as int,
        'CompleteApproved': completeApprovedStatus,
        'DeleteStatus': deleteStatus as bool,
        'ModifiedBy': modifiedBy as int,
        'ModifiedDate': modifiedDate as String,
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return AddMonth(
          siteID: siteID,
          month: month,
          date: date,
          prepareBy: prepareBy,
          completePrepareStatus: completePrepareStatus,
          checkedBy: checkedBy,
          completeCheckedStatus: completeCheckedStatus,
          approveBy: approveBy,
          completeApprovedStatus: completeApprovedStatus,
          deleteStatus: deleteStatus,
          modifiedBy: modifiedBy,
          modifiedDate: modifiedDate);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to Add Monthly Plan.');
    }
  }

  Future<void> getAllMonthlyPlanBySiteIdAndForMonth(siteID, month) async {
    var response = await http.get(
      Uri.parse(
        getMonthlyPlanBySiteIDAndForTheMonth_url +
            "siteID=" +
            siteID.toString() +
            "&forMonth=" +
            month,
      ),
    );

    if (response.body != "") {
      showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('Monthly Duplicate!'),
          content: const Text('Please check your month.'),
          actions: <Widget>[
            TextButton(
                onPressed: () async {
                  Navigator.pop(context, 'Cancel');
                },
                child: const Text('OK'))
          ],
        ),
      );
    } else {
      addMonth(
        widget.project.siteID,
        pickDate,
        DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
        personID,
        null,
        checkedPersonID,
        null,
        approvePersonID,
        null,
        false,
        userID,
        DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()),
      );
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MonthlyPlanList(
                    project: widget.project,
                  )));
    }
  }
}
