// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:calendar_date_picker2/calendar_date_picker2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../models/Monthly/monthly_work_activities_model.dart';
import '../../../models/Project/projects_list_model.dart';

import '../../../responsive.dart';
import '../../../utils/global.dart';
import '../../Login/widgets/text.form.global.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

var today = DateUtils.dateOnly(DateTime.now());

Future<T?> ShowAddMonthlyDialog<T>(BuildContext context) => showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AddMonthlyDialog(),
    );

class AddMonthlyDialog extends StatefulWidget {
  DateRangePickerController datePickerController = DateRangePickerController();

  // List<DateTime?> plannedDateList = <DateTime>[];
  // List<DateTime?> actualDateList = <DateTime>[];

  AddMonthlyDialog({
    super.key,
  });

  @override
  State<AddMonthlyDialog> createState() => _AddMonthlyDialogState();
}

class _AddMonthlyDialogState extends State<AddMonthlyDialog> {
  // late TextEditingController activityNameController = TextEditingController();
  late SingleValueDropDownController activityNameController =
      SingleValueDropDownController();
  late TextEditingController aController = TextEditingController();
  late TextEditingController bController = TextEditingController();
  late TextEditingController cController = TextEditingController();
  late TextEditingController dController = TextEditingController();
  late TextEditingController eController = TextEditingController();
  late TextEditingController fController = TextEditingController();

  //late TextEditingController activityNameControllerCancel;
  late SingleValueDropDownController activityNameControllerCancel;
  late TextEditingController aControllerCancel;
  late TextEditingController bControllerCancel;
  late TextEditingController cControllerCancel;
  late TextEditingController dControllerCancel;
  late TextEditingController eControllerCancel;
  late TextEditingController fControllerCancel;

  FocusNode searchFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // activityNameControllerCancel = TextEditingController(text: "");
    activityNameControllerCancel = SingleValueDropDownController(
        data: DropDownValueModel(name: "", value: ""));

    aControllerCancel = TextEditingController(text: "");

    bControllerCancel = TextEditingController(text: "");

    cControllerCancel = TextEditingController(text: "");

    dControllerCancel = TextEditingController(text: "");

    eControllerCancel = TextEditingController(text: "");

    fControllerCancel = TextEditingController(text: "");
  }

  String todayDate = DateFormat("MMMM/ dd/ yyyy").format(DateTime.now());

  List<DateTime?> plannedDateList = <DateTime>[];

  List<DateTime?> actualDateList = <DateTime>[];

  @override
  Widget build(BuildContext context) => AlertDialog(
        contentPadding: EdgeInsets.only(left: 20, right: 20),
        // title: Center(child: Text("Information")),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: Container(
          // height: (MediaQuery.of(context).size.height / 2) * 1.35,
          width: (MediaQuery.of(context).size.width),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop(WorkActivity(
                            activityName: activityNameControllerCancel
                                .dropDownValue!.name
                                .toString(),
                            activityID: activityNameControllerCancel
                                .dropDownValue!.value
                                .toString(),
                            a: aControllerCancel.text,
                            b: bControllerCancel.text,
                            c: cControllerCancel.text,
                            d: dControllerCancel.text,
                            e: eControllerCancel.text,
                            f: fControllerCancel.text,
                            plannedDateList: [],
                            actualDateList: [],
                            status: "false"));
                      },
                      icon: Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Flexible(
                    //   child: TextField(
                    //     decoration: InputDecoration(
                    //         labelText: 'Name of Work Activity',
                    //         enabledBorder: OutlineInputBorder(
                    //           borderSide: const BorderSide(
                    //               width: 3, color: Colors.blueGrey),
                    //           borderRadius: BorderRadius.circular(15),
                    //         ),
                    //         focusedBorder: OutlineInputBorder(
                    //           borderSide: const BorderSide(
                    //               width: 3, color: Colors.blueAccent),
                    //           borderRadius: BorderRadius.circular(15),
                    //         )),
                    //     controller: activityNameController,
                    //   ),
                    // ),
                    Flexible(
                      child: DropDownTextField(
                        textFieldDecoration: InputDecoration(
                            labelText: 'Name of Work Activity',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 3,
                                color: Colors.blueGrey,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 3,
                                color: Colors.blueGrey,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            )),
                        clearOption: false,
                        textFieldFocusNode: textFieldFocusNode,
                        searchFocusNode: searchFocusNode,
                        searchAutofocus: true,
                        dropDownItemCount: 8,
                        searchShowCursor: true,
                        enableSearch: true,
                        searchKeyboardType: TextInputType.text,
                        controller: activityNameController,
                        dropDownList: const [
                          DropDownValueModel(
                              name: 'L1 Beam & Slab Concrete Casting Work',
                              value: "L1 Beam & Slab Concrete Casting Work"),
                          DropDownValueModel(
                              name: 'L1 to L2 Column Rebar Work',
                              value: "L1 to L2 Column Rebar Work"),
                          DropDownValueModel(
                              name: 'L1 to L2 Column Formwork',
                              value: "L1 to L2 Column Formwork"),
                          DropDownValueModel(
                              name: 'L1 to L2 Column Casting Work',
                              value: "L1 to L2 Column Casting Work"),
                          DropDownValueModel(
                              name: 'L1 Beam & Slab Formwork Dismatle',
                              value: "L1 Beam & Slab Formwork Dismatle"),
                          DropDownValueModel(
                              name: 'L2 Beam & Slab Formwork',
                              value: "L2 Beam & Slab Formwork"),
                          DropDownValueModel(
                              name: 'L2 Beam & Slab Rebar Work',
                              value: "L2 Beam & Slab Rebar Work"),
                          DropDownValueModel(
                              name: 'L2 Beam & Slab Concrete Casting Work',
                              value: "L2 Beam & Slab Concrete Casting Work"),
                          DropDownValueModel(
                              name: 'L2 to L3 Column Rebar Work',
                              value: "L2 to L3 Column Rebar Work"),
                        ],
                        onChanged: (val) {},
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'a %',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(15),
                            )),
                        controller: aController,
                        onChanged: (text) {
                          setState(() {
                            double a;
                            double b;
                            double e;
                            a = double.parse(aController.text);
                            b = double.parse(bController.text);
                            e = a / 100 * b;
                            eController.text = e.toString();

                            double c;
                            double d;
                            double f;

                            c = double.parse(cController.text);
                            d = double.parse(dController.text);
                            f = (a / 100 * c) + (a / 100 * d);
                            fController.text = f.toString();
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 15),
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'b %',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(15),
                            )),
                        controller: bController,
                        onChanged: (text) {
                          setState(() {
                            double a;
                            double b;
                            double e;
                            a = double.parse(aController.text);
                            b = double.parse(bController.text);
                            e = a / 100 * b;
                            eController.text = e.toString();
                          });
                        },
                      ),
                    ),
                    // const SizedBox(width: 15),
                    // Flexible(
                    //   child: TextField(
                    //     decoration: InputDecoration(
                    //         labelText: 'c %',
                    //         enabledBorder: OutlineInputBorder(
                    //           borderSide: const BorderSide(
                    //               width: 3, color: Colors.blueGrey),
                    //           borderRadius: BorderRadius.circular(15),
                    //         ),
                    //         focusedBorder: OutlineInputBorder(
                    //           borderSide: const BorderSide(
                    //               width: 3, color: Colors.blueAccent),
                    //           borderRadius: BorderRadius.circular(15),
                    //         )),
                    //     controller: cController,
                    //     onChanged: (text) {
                    //       setState(() {
                    //         double a;
                    //         double c;
                    //         double d;
                    //         double f;
                    //         a = double.parse(aController.text);
                    //         c = double.parse(cController.text);
                    //         d = double.parse(dController.text);
                    //         f = (a / 100 * c) + (a / 100 * d);
                    //         fController.text = f.toString();
                    //       });
                    //     },
                    //   ),
                    // ),
                    // const SizedBox(width: 15),
                    // Flexible(
                    //   child: TextField(
                    //     decoration: InputDecoration(
                    //         labelText: 'd %',
                    //         enabledBorder: OutlineInputBorder(
                    //           borderSide: const BorderSide(
                    //               width: 3, color: Colors.blueGrey),
                    //           borderRadius: BorderRadius.circular(15),
                    //         ),
                    //         focusedBorder: OutlineInputBorder(
                    //           borderSide: const BorderSide(
                    //               width: 3, color: Colors.blueAccent),
                    //           borderRadius: BorderRadius.circular(15),
                    //         )),
                    //     controller: dController,
                    //     onChanged: (text) {
                    //       setState(() {
                    //         double a;
                    //         double c;
                    //         double d;
                    //         double f;
                    //         a = double.parse(aController.text);
                    //         c = double.parse(cController.text);
                    //         d = double.parse(dController.text);
                    //         f = (a / 100 * c) + (a / 100 * d);
                    //         fController.text = f.toString();
                    //       });
                    //     },
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'e %',
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.blueGrey),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.blueAccent),
                              borderRadius: BorderRadius.circular(15),
                            )),
                        controller: eController,
                        readOnly: true,
                      ),
                    ),
                    // const SizedBox(width: 15),
                    // Flexible(
                    //   child: TextField(
                    //     decoration: InputDecoration(
                    //       labelText: 'f %',
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide: const BorderSide(
                    //             width: 3, color: Colors.blueGrey),
                    //         borderRadius: BorderRadius.circular(15),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: const BorderSide(
                    //             width: 3, color: Colors.blueAccent),
                    //         borderRadius: BorderRadius.circular(15),
                    //       ),
                    //     ),
                    //     controller: fController,
                    //     readOnly: true,
                    //   ),
                    // ),
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
                          calendarType: CalendarDatePicker2Type.multi,
                          selectedDayHighlightColor: Colors.black,
                          closeDialogOnCancelTapped: true,
                        );
                        var values = await showCalendarDatePicker2Dialog(
                          context: context,
                          config: config,
                          dialogSize: const Size(325, 400),
                          borderRadius: BorderRadius.circular(15),
                          initialValue: plannedDateList,
                          dialogBackgroundColor: Colors.white,
                        );
                        if (values != null) {
                          // ignore: avoid_print
                          print(_getValueText(
                            config.calendarType,
                            values,
                          ));
                          setState(() {
                            plannedDateList = values;
                          });
                        }
                      },
                      icon: SvgPicture.asset(
                        "assets/icons/weekly.svg",
                        height: 20,
                        width: 20,
                        color: Colors.white,
                      ),
                      label: Text("Planned Date"),
                    ),
                    // ElevatedButton.icon(
                    //   style: TextButton.styleFrom(
                    //       backgroundColor: Colors.blueGrey),
                    //   onPressed: () async {
                    //     var config = CalendarDatePicker2WithActionButtonsConfig(
                    //       calendarType: CalendarDatePicker2Type.multi,
                    //       selectedDayHighlightColor: Colors.black,
                    //       shouldCloseDialogAfterCancelTapped: true,
                    //     );
                    //     var values = await showCalendarDatePicker2Dialog(
                    //       context: context,
                    //       config: config,
                    //       dialogSize: const Size(325, 400),
                    //       borderRadius: 15,
                    //       initialValue: actualDateList,
                    //       dialogBackgroundColor: Colors.white,
                    //     );
                    //     if (values != null) {
                    //       // ignore: avoid_print
                    //       print(_getValueText(
                    //         config.calendarType,
                    //         values,
                    //       ));
                    //       setState(() {
                    //         actualDateList = values;
                    //       });
                    //     }
                    //   },
                    //   icon: SvgPicture.asset(
                    //     "assets/icons/weekly.svg",
                    //     height: 20,
                    //     width: 20,
                    //     color: Colors.white,
                    //   ),
                    //   label: Text("Acutal Date"),
                    // ),
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
                      if (activityNameController.dropDownValue?.value == null) {
                        Navigator.of(context).pop(WorkActivity(
                            activityName: "",
                            activityID: "",
                            a: aController.text,
                            b: bController.text,
                            c: cController.text,
                            d: dController.text,
                            e: eController.text,
                            f: fController.text,
                            plannedDateList: plannedDateList,
                            actualDateList: actualDateList,
                            status: "false"));
                      } else {
                        Navigator.of(context).pop(WorkActivity(
                            activityName: activityNameController
                                .dropDownValue!.name
                                .toString(),
                            activityID: activityNameController
                                .dropDownValue!.value
                                .toString(),
                            a: aController.text,
                            b: bController.text,
                            c: cController.text,
                            d: dController.text,
                            e: eController.text,
                            f: fController.text,
                            plannedDateList: plannedDateList,
                            actualDateList: actualDateList,
                            status: "false"));
                      }
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

String _getValueText(
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
      var startDate = values[0].toString().replaceAll('00:00:00.000', '');
      var endDate = values.length > 1
          ? values[1].toString().replaceAll('00:00:00.000', '')
          : 'null';
      valueText = '$startDate to $endDate';
    } else {
      return 'null';
    }
  }

  return valueText;
}

String _getDateText(
  List<DateTime?> values,
) {
  var valueText = (values.isNotEmpty ? values[0] : null)
      .toString()
      .replaceAll('00:00:00.000', '');

  valueText = values.isNotEmpty
      ? values
          .map((v) => v.toString().replaceAll('00:00:00.000', ''))
          .join(', ')
      : 'null';

  return valueText;
}
