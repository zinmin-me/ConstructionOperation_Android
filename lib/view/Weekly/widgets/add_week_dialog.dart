// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:calendar_date_picker2/calendar_date_picker2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../models/Monthly/monthly_plan_list_model.dart';
import '../../../models/Project/projects_list_model.dart';

import '../../../models/Weekly/weekly_plan_list_model.dart';
import '../../../responsive.dart';
import '../../../utils/global.dart';
import '../../Login/widgets/text.form.global.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';
import 'package:flutter/cupertino.dart';

var today = DateUtils.dateOnly(DateTime.now());

Future<T?> ShowAddWeekDialog<T>(
  BuildContext context, {
  required Project value,
}) =>
    showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AddWeekDialog(
        value: value,
      ),
    );

class AddWeekDialog extends StatefulWidget {
  final Project value;
  DateRangePickerController datePickerController = DateRangePickerController();

  List<DateTime?> plannedDateList = <DateTime>[];
  List<DateTime?> actualDateList = <DateTime>[];

  AddWeekDialog({
    super.key,
    required this.value,
  });

  @override
  State<AddWeekDialog> createState() => _AddWeekDialogState();
}

class _AddWeekDialogState extends State<AddWeekDialog> {
  late TextEditingController siteNameController;
  late TextEditingController siteCodeController;

  DateRangePickerController datePickerController = DateRangePickerController();

  String todayDate = DateFormat("d-MMM-yyyy").format(DateTime.now());
  String next7Days =
      DateFormat("d-MMM-yyyy").format(DateTime.now().add(Duration(days: 7)));

  late String selectedDate = DateFormat("d-MMM-yyyy").format(DateTime.now());

  @override
  void initState() {
    super.initState();
    siteNameController = TextEditingController(text: widget.value.projectName);
    siteCodeController = TextEditingController(text: widget.value.siteCode);
    selectedDate = todayDate + " to " + next7Days;
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
                        Navigator.of(context).pop(WeeklyPlan(
                            projectName: siteNameController.text,
                            siteCode: siteCodeController.text,
                            startDate: "cancel",
                            endDate: "cancel"));
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
                        var config = CalendarDatePicker2WithActionButtonsConfig(
                          calendarType: CalendarDatePicker2Type.range,
                          selectedDayHighlightColor: Colors.black,
                          closeDialogOnCancelTapped: true,
                        );
                        var values = await showCalendarDatePicker2Dialog(
                          context: context,
                          config: config,
                          dialogSize: const Size(325, 400),
                          borderRadius: BorderRadius.circular(15),
                          initialValue: widget.plannedDateList,
                          dialogBackgroundColor: Colors.white,
                        );
                        if (values != null) {
                          // ignore: avoid_print
                          setState(() {
                            todayDate = _getStartDateText(
                              config.calendarType,
                              values,
                            );
                            next7Days = _getEndDateText(
                              config.calendarType,
                              values,
                            );
                            selectedDate = _getStartDateText(
                                  config.calendarType,
                                  values,
                                ) +
                                " to " +
                                _getEndDateText(
                                  config.calendarType,
                                  values,
                                );
                          });
                          // print(_getStartDateText(
                          //   config.calendarType,
                          //   values,
                          // ));
                          // print(_getEndDateText(
                          //   config.calendarType,
                          //   values,
                          // ));
                          // setState(() {
                          //   widget.plannedDateList = values;
                          // });
                        }
                      },
                      icon: SvgPicture.asset(
                        "assets/icons/weekly.svg",
                        height: 20,
                        width: 20,
                        color: Colors.white,
                      ),
                      label: Text(selectedDate),
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
                      Navigator.of(context).pop(WeeklyPlan(
                        projectName: siteNameController.text,
                        siteCode: siteCodeController.text,
                        startDate: todayDate.toString(),
                        endDate: next7Days.toString(),
                      ));
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
}

String _getStartDateText(
  CalendarDatePicker2Type datePickerType,
  List<DateTime?> values,
) {
  var valueText = (values.isNotEmpty ? values[0] : null)
      .toString()
      .replaceAll('00:00:00.000', '');

  if (datePickerType == CalendarDatePicker2Type.multi) {
    valueText =
        values.isNotEmpty ? values.map((v) => v.toString()).join(', ') : 'null';
  } else if (datePickerType == CalendarDatePicker2Type.range) {
    if (values.isNotEmpty) {
      var startDate = values[0].toString();
      var endDate = values.length > 1
          ? values[1].toString().replaceAll('00:00:00.000', '')
          : 'null';
      valueText = startDate;
    } else {
      return 'null';
    }
  }

  return DateFormat("d-MMM-yyyy").format(DateTime.parse(valueText));
}

String _getEndDateText(
  CalendarDatePicker2Type datePickerType,
  List<DateTime?> values,
) {
  var valueText = (values.isNotEmpty ? values[0] : null)
      .toString()
      .replaceAll('00:00:00.000', '');

  if (datePickerType == CalendarDatePicker2Type.multi) {
    valueText = values.isNotEmpty
        ? values
            .map((v) => v.toString().replaceAll('00:00:00.000', ''))
            .join(', ')
        : 'null';
  } else if (datePickerType == CalendarDatePicker2Type.range) {
    if (values.isNotEmpty) {
      var startDate = values[0].toString();
      var endDate = values.length > 1 ? values[1].toString() : 'null';
      valueText = endDate;
    } else {
      return 'null';
    }
  }

  return DateFormat("d-MMM-yyyy").format(DateTime.parse(valueText));
}
