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

Future<T?> ShowUpdateMonthlyDialog<T>(
  BuildContext context, {
  required String title,
  required WorkActivity value,
  required int mopID,
}) =>
    showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (context) => UpdateMonthlyDialog(
        title: title,
        value: value,
        mopID: mopID,
      ),
    );

class UpdateMonthlyDialog extends StatefulWidget {
  final String title;
  final WorkActivity value;
  int mopID;
  DateRangePickerController datePickerController = DateRangePickerController();

  UpdateMonthlyDialog({
    super.key,
    required this.title,
    required this.value,
    required this.mopID,
  });

  @override
  State<UpdateMonthlyDialog> createState() => _UpdateMonthlyDialogState();
}

class _UpdateMonthlyDialogState extends State<UpdateMonthlyDialog> {
  late List<DateTime?> plannedDateList;
  late List<DateTime?> actualDateList;

  late List<DateTime?> plannedDateListCancel;
  late List<DateTime?> actualDateListCancel;

  // late TextEditingController activityNameController;
  late SingleValueDropDownController activityNameController;
  late TextEditingController aController;
  late TextEditingController bController;
  late TextEditingController cController;
  late TextEditingController dController;
  late TextEditingController eController;
  late TextEditingController fController;

  // late TextEditingController activityNameControllerCancel;
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

    // activityNameController =
    //     TextEditingController(text: widget.value.activityName);

    activityNameController = SingleValueDropDownController(
        data: DropDownValueModel(
            name: widget.value.activityName, value: widget.value.activityID));

    aController = TextEditingController(text: widget.value.a);

    bController = TextEditingController(text: widget.value.b);

    cController = TextEditingController(text: widget.value.c);

    dController = TextEditingController(text: widget.value.d);

    eController = TextEditingController(text: widget.value.e);

    fController = TextEditingController(text: widget.value.f);

    // activityNameControllerCancel =
    //     TextEditingController(text: widget.value.activityName);
    activityNameControllerCancel = SingleValueDropDownController(
        data: DropDownValueModel(
            name: widget.value.activityName, value: widget.value.activityName));

    aControllerCancel = TextEditingController(text: widget.value.a);

    bControllerCancel = TextEditingController(text: widget.value.b);

    cControllerCancel = TextEditingController(text: widget.value.c);

    dControllerCancel = TextEditingController(text: widget.value.d);

    eControllerCancel = TextEditingController(text: widget.value.e);

    fControllerCancel = TextEditingController(text: widget.value.f);

    plannedDateList = widget.value.plannedDateList;
    actualDateList = widget.value.actualDateList;

    plannedDateListCancel = widget.value.plannedDateList;
    actualDateListCancel = widget.value.actualDateList;
  }

  String todayDate = DateFormat("MMMM/ dd/ yyyy").format(DateTime.now());

  @override
  Widget build(BuildContext context) => AlertDialog(
        contentPadding: EdgeInsets.only(left: 20, right: 20),
        // title: Center(child: Text("Information")),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        content: Container(
          // height: (MediaQuery.of(context).size.height / 2) * 1.2,
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
                            plannedDateList: plannedDateListCancel,
                            actualDateList: actualDateListCancel,
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
                        dropDownList: const [],
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
                        backgroundColor: Colors.blueGrey,
                        // minimumSize: Size(
                        //     (MediaQuery.of(this.context).size.width / 3), 30),
                      ),
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
                    //     backgroundColor: Colors.blueGrey,
                    //     // minimumSize: Size(
                    //     //     (MediaQuery.of(this.context).size.width / 3), 30),
                    //   ),
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
                      backgroundColor: Colors.orangeAccent,
                      minimumSize: Size(150, 60),
                    ),
                    onPressed: () {
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
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/edit.svg",
                      height: 18,
                      width: 18,
                      color: Colors.white,
                    ),
                    label: Text("Update"),
                  ),
                ),
                const SizedBox(height: 20),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     ElevatedButton.icon(
                //       style: TextButton.styleFrom(
                //         backgroundColor: Colors.orangeAccent,
                //         minimumSize: Size(150, 60),
                //       ),
                //       onPressed: () {
                //         Navigator.of(context).pop(WorkActivity(
                //             activityName: activityNameController.text,
                //             a: aController.text,
                //             b: bController.text,
                //             c: cController.text,
                //             d: dController.text,
                //             e: eController.text,
                //             f: fController.text,
                //             status: "false"));
                //       },
                //       icon: SvgPicture.asset(
                //         "assets/icons/edit.svg",
                //         height: 18,
                //         width: 18,
                //         color: Colors.white,
                //       ),
                //       label: Text("Update"),
                //     ),
                //     // ElevatedButton.icon(
                //     //   style: TextButton.styleFrom(
                //     //     backgroundColor: Colors.red,
                //     //     minimumSize:
                //     //         Size((MediaQuery.of(context).size.width / 3), 50),
                //     //   ),
                //     //   onPressed: () {
                //     //     Navigator.of(context).pop(WorkActivity(
                //     //         activityName: activityNameController.text,
                //     //         a: aController.text,
                //     //         b: bController.text,
                //     //         c: cController.text,
                //     //         d: dController.text,
                //     //         e: eController.text,
                //     //         f: fController.text,
                //     //         status: "true"));
                //     //   },
                //     //   icon: SvgPicture.asset(
                //     //     "assets/icons/delete.svg",
                //     //     height: 18,
                //     //     width: 18,
                //     //     color: Colors.white,
                //     //   ),
                //     //   label: Text("Delete"),
                //     // ),
                //   ],
                // ),
                // const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      );
  _dismissDialog() {
    Navigator.pop(context);
  }
  // AlertDialog(
  //       content: Container(
  //         height: (MediaQuery.of(context).size.height / 2) * 1.35,
  //         width: (MediaQuery.of(context).size.width),
  //         child: SingleChildScrollView(
  //           child: Column(
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.end,
  //                 crossAxisAlignment: CrossAxisAlignment.stretch,
  //                 children: [
  //                   IconButton(
  //                     onPressed: () {
  //                       Navigator.of(context).pop(WorkActivity(
  //                           activityName: activityNameControllerCancel.text,
  //                           a: aControllerCancel.text,
  //                           b: bControllerCancel.text,
  //                           c: cControllerCancel.text,
  //                           d: dControllerCancel.text,
  //                           e: eControllerCancel.text,
  //                           f: fControllerCancel.text,
  //                           status: "false"));
  //                     },
  //                     icon: Icon(Icons.close),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 10),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Flexible(
  //                     child: TextField(
  //                       decoration: InputDecoration(
  //                           labelText: 'Name of Work Activity',
  //                           enabledBorder: OutlineInputBorder(
  //                             borderSide: const BorderSide(
  //                                 width: 3, color: Colors.blueGrey),
  //                             borderRadius: BorderRadius.circular(15),
  //                           ),
  //                           focusedBorder: OutlineInputBorder(
  //                             borderSide: const BorderSide(
  //                                 width: 3, color: Colors.blueAccent),
  //                             borderRadius: BorderRadius.circular(15),
  //                           )),
  //                       controller: activityNameController,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 20),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Flexible(
  //                     child: TextField(
  //                       decoration: InputDecoration(
  //                           labelText: 'a %',
  //                           enabledBorder: OutlineInputBorder(
  //                             borderSide: const BorderSide(
  //                                 width: 3, color: Colors.blueGrey),
  //                             borderRadius: BorderRadius.circular(15),
  //                           ),
  //                           focusedBorder: OutlineInputBorder(
  //                             borderSide: const BorderSide(
  //                                 width: 3, color: Colors.blueAccent),
  //                             borderRadius: BorderRadius.circular(15),
  //                           )),
  //                       controller: aController,
  //                     ),
  //                   ),
  //                   const SizedBox(width: 15),
  //                   Flexible(
  //                     child: TextField(
  //                       decoration: InputDecoration(
  //                           labelText: 'b %',
  //                           enabledBorder: OutlineInputBorder(
  //                             borderSide: const BorderSide(
  //                                 width: 3, color: Colors.blueGrey),
  //                             borderRadius: BorderRadius.circular(15),
  //                           ),
  //                           focusedBorder: OutlineInputBorder(
  //                             borderSide: const BorderSide(
  //                                 width: 3, color: Colors.blueAccent),
  //                             borderRadius: BorderRadius.circular(15),
  //                           )),
  //                       controller: bController,
  //                     ),
  //                   ),
  //                   const SizedBox(width: 15),
  //                   Flexible(
  //                     child: TextField(
  //                       decoration: InputDecoration(
  //                           labelText: 'c %',
  //                           enabledBorder: OutlineInputBorder(
  //                             borderSide: const BorderSide(
  //                                 width: 3, color: Colors.blueGrey),
  //                             borderRadius: BorderRadius.circular(15),
  //                           ),
  //                           focusedBorder: OutlineInputBorder(
  //                             borderSide: const BorderSide(
  //                                 width: 3, color: Colors.blueAccent),
  //                             borderRadius: BorderRadius.circular(15),
  //                           )),
  //                       controller: cController,
  //                     ),
  //                   ),
  //                   const SizedBox(width: 15),
  //                   Flexible(
  //                     child: TextField(
  //                       decoration: InputDecoration(
  //                           labelText: 'd %',
  //                           enabledBorder: OutlineInputBorder(
  //                             borderSide: const BorderSide(
  //                                 width: 3, color: Colors.blueGrey),
  //                             borderRadius: BorderRadius.circular(15),
  //                           ),
  //                           focusedBorder: OutlineInputBorder(
  //                             borderSide: const BorderSide(
  //                                 width: 3, color: Colors.blueAccent),
  //                             borderRadius: BorderRadius.circular(15),
  //                           )),
  //                       controller: dController,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 20),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   Flexible(
  //                     child: TextField(
  //                       decoration: InputDecoration(
  //                           labelText: 'e %',
  //                           enabledBorder: OutlineInputBorder(
  //                             borderSide: const BorderSide(
  //                                 width: 3, color: Colors.blueGrey),
  //                             borderRadius: BorderRadius.circular(15),
  //                           ),
  //                           focusedBorder: OutlineInputBorder(
  //                             borderSide: const BorderSide(
  //                                 width: 3, color: Colors.blueAccent),
  //                             borderRadius: BorderRadius.circular(15),
  //                           )),
  //                       controller: eController,
  //                       readOnly: true,
  //                     ),
  //                   ),
  //                   const SizedBox(width: 15),
  //                   Flexible(
  //                     child: TextField(
  //                       decoration: InputDecoration(
  //                         labelText: 'f %',
  //                         enabledBorder: OutlineInputBorder(
  //                           borderSide: const BorderSide(
  //                               width: 3, color: Colors.blueGrey),
  //                           borderRadius: BorderRadius.circular(15),
  //                         ),
  //                         focusedBorder: OutlineInputBorder(
  //                           borderSide: const BorderSide(
  //                               width: 3, color: Colors.blueAccent),
  //                           borderRadius: BorderRadius.circular(15),
  //                         ),
  //                       ),
  //                       controller: fController,
  //                       readOnly: true,
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 20),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   ElevatedButton.icon(
  //                     style: TextButton.styleFrom(
  //                         backgroundColor: Colors.blueGrey),
  //                     onPressed: () async {
  //                       var config =
  //                           CalendarDatePicker2WithActionButtonsConfig(
  //                         calendarType: CalendarDatePicker2Type.multi,
  //                         selectedDayHighlightColor: Colors.black,
  //                         shouldCloseDialogAfterCancelTapped: true,
  //                       );
  //                       var values = await showCalendarDatePicker2Dialog(
  //                         context: context,
  //                         config: config,
  //                         dialogSize: const Size(325, 400),
  //                         borderRadius: 15,
  //                         initialValue: widget.plannedDateList,
  //                         dialogBackgroundColor: Colors.white,
  //                       );
  //                       if (values != null) {
  //                         // ignore: avoid_print
  //                         print(_getValueText(
  //                           config.calendarType,
  //                           values,
  //                         ));
  //                         setState(() {
  //                           widget.plannedDateList = values;
  //                         });
  //                       }
  //                     },
  //                     icon: SvgPicture.asset(
  //                       "assets/icons/weekly.svg",
  //                       height: 20,
  //                       width: 20,
  //                       color: Colors.white,
  //                     ),
  //                     label: Text("Planned Date"),
  //                   ),
  //                   ElevatedButton.icon(
  //                     style: TextButton.styleFrom(
  //                         backgroundColor: Colors.blueGrey),
  //                     onPressed: () async {
  //                       var config =
  //                           CalendarDatePicker2WithActionButtonsConfig(
  //                         calendarType: CalendarDatePicker2Type.multi,
  //                         selectedDayHighlightColor: Colors.black,
  //                         shouldCloseDialogAfterCancelTapped: true,
  //                       );
  //                       var values = await showCalendarDatePicker2Dialog(
  //                         context: context,
  //                         config: config,
  //                         dialogSize: const Size(325, 400),
  //                         borderRadius: 15,
  //                         initialValue: widget.actualDateList,
  //                         dialogBackgroundColor: Colors.white,
  //                       );
  //                       if (values != null) {
  //                         // ignore: avoid_print
  //                         print(_getValueText(
  //                           config.calendarType,
  //                           values,
  //                         ));
  //                         setState(() {
  //                           widget.actualDateList = values;
  //                         });
  //                       }
  //                     },
  //                     icon: SvgPicture.asset(
  //                       "assets/icons/weekly.svg",
  //                       height: 20,
  //                       width: 20,
  //                       color: Colors.white,
  //                     ),
  //                     label: Text("Acutal Date"),
  //                   ),
  //                 ],
  //               ),
  //               const SizedBox(height: 50),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   ElevatedButton.icon(
  //                     style: TextButton.styleFrom(
  //                       backgroundColor: Colors.orangeAccent,
  //                       minimumSize:
  //                           Size((MediaQuery.of(context).size.width / 3), 60),
  //                     ),
  //                     onPressed: () {
  //                       Navigator.of(context).pop(WorkActivity(
  //                           activityName: activityNameController.text,
  //                           a: aController.text,
  //                           b: bController.text,
  //                           c: cController.text,
  //                           d: dController.text,
  //                           e: eController.text,
  //                           f: fController.text,
  //                           status: "false"));
  //                     },
  //                     icon: SvgPicture.asset(
  //                       "assets/icons/edit.svg",
  //                       height: 18,
  //                       width: 18,
  //                       color: Colors.white,
  //                     ),
  //                     label: Text("Update"),
  //                   ),
  //                   ElevatedButton.icon(
  //                     style: TextButton.styleFrom(
  //                       backgroundColor: Colors.red,
  //                       minimumSize:
  //                           Size((MediaQuery.of(context).size.width / 3), 60),
  //                     ),
  //                     onPressed: () {
  //                       Navigator.of(context).pop(WorkActivity(
  //                           activityName: activityNameController.text,
  //                           a: aController.text,
  //                           b: bController.text,
  //                           c: cController.text,
  //                           d: dController.text,
  //                           e: eController.text,
  //                           f: fController.text,
  //                           status: "true"));
  //                     },
  //                     icon: SvgPicture.asset(
  //                       "assets/icons/delete.svg",
  //                       height: 18,
  //                       width: 18,
  //                       color: Colors.white,
  //                     ),
  //                     label: Text("Delete"),
  //                   )
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //     );
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
