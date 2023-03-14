// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:calendar_date_picker2/calendar_date_picker2.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import '../../../models/Monthly/monthly_work_activities_model.dart';
import '../../../models/Project/projects_list_model.dart';

import '../../../models/Weekly/weekly_work_activities_model.dart';
import '../../../responsive.dart';
import '../../../utils/global.dart';
import '../../Login/widgets/text.form.global.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

var today = DateUtils.dateOnly(DateTime.now());

Future<T?> UpdateWeeklyActivityDialog<T>(
  BuildContext context, {
  required String title,
  required WeeklyWorkActivity value,
}) =>
    showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (context) => UpdateWeeklyActivity(
        title: title,
        value: value,
      ),
    );

class UpdateWeeklyActivity extends StatefulWidget {
  final String title;
  final WeeklyWorkActivity value;
  DateRangePickerController datePickerController = DateRangePickerController();

  UpdateWeeklyActivity({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  State<UpdateWeeklyActivity> createState() => _UpdateWeeklyActivityState();
}

class _UpdateWeeklyActivityState extends State<UpdateWeeklyActivity> {
  // late TextEditingController activityNameController = TextEditingController();
  late SingleValueDropDownController activityNameController;
  late TextEditingController pOne;
  late TextEditingController aOne;
  late TextEditingController pTwo;
  late TextEditingController aTwo;
  late TextEditingController pThree;
  late TextEditingController aThree;
  late TextEditingController pFour;
  late TextEditingController aFour;
  late TextEditingController pFive;
  late TextEditingController aFive;
  late TextEditingController pSix;
  late TextEditingController aSix;
  late TextEditingController pSeven;
  late TextEditingController aSeven;
  late TextEditingController remarks;

  //late TextEditingController activityNameControllerCancel;
  late SingleValueDropDownController activityNameControllerCancel;
  late TextEditingController pOneCancel;
  late TextEditingController aOneCancel;
  late TextEditingController pTwoCancel;
  late TextEditingController aTwoCancel;
  late TextEditingController pThreeCancel;
  late TextEditingController aThreeCancel;
  late TextEditingController pFourCancel;
  late TextEditingController aFourCancel;
  late TextEditingController pFiveCancel;
  late TextEditingController aFiveCancel;
  late TextEditingController pSixCancel;
  late TextEditingController aSixCancel;
  late TextEditingController pSevenCancel;
  late TextEditingController aSevenCancel;
  late TextEditingController remarksCancel;

  FocusNode searchFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    activityNameController = SingleValueDropDownController(
        data: DropDownValueModel(
            name: widget.value.activityName, value: widget.value.activityName));

    pOne = TextEditingController(text: widget.value.pOne);
    aOne = TextEditingController(text: widget.value.aOne);
    pTwo = TextEditingController(text: widget.value.pTwo);
    aTwo = TextEditingController(text: widget.value.aTwo);
    pThree = TextEditingController(text: widget.value.pThree);
    aThree = TextEditingController(text: widget.value.aThree);
    pFour = TextEditingController(text: widget.value.pFour);
    aFour = TextEditingController(text: widget.value.aFour);
    pFive = TextEditingController(text: widget.value.pFive);
    aFive = TextEditingController(text: widget.value.aFive);
    pSix = TextEditingController(text: widget.value.pSix);
    aSix = TextEditingController(text: widget.value.aSix);
    pSeven = TextEditingController(text: widget.value.pSeven);
    aSeven = TextEditingController(text: widget.value.aSeven);
    remarks = TextEditingController(text: widget.value.remarks);

    // activityNameControllerCancel = TextEditingController(text: "");
    activityNameControllerCancel = SingleValueDropDownController(
        data: DropDownValueModel(
            name: widget.value.activityName, value: widget.value.activityName));

    pOneCancel = TextEditingController(text: widget.value.pOne);
    aOneCancel = TextEditingController(text: widget.value.aOne);
    pTwoCancel = TextEditingController(text: widget.value.pTwo);
    aTwoCancel = TextEditingController(text: widget.value.aTwo);
    pThreeCancel = TextEditingController(text: widget.value.pThree);
    aThreeCancel = TextEditingController(text: widget.value.aThree);
    pFourCancel = TextEditingController(text: widget.value.pFour);
    aFourCancel = TextEditingController(text: widget.value.aFour);
    pFiveCancel = TextEditingController(text: widget.value.pFive);
    aFiveCancel = TextEditingController(text: widget.value.aFive);
    pSixCancel = TextEditingController(text: widget.value.pSix);
    aSixCancel = TextEditingController(text: widget.value.aSix);
    pSevenCancel = TextEditingController(text: widget.value.pSeven);
    aSevenCancel = TextEditingController(text: widget.value.aSeven);
    remarksCancel = TextEditingController(text: widget.value.remarks);
  }

  String todayDate = DateFormat("MMMM/ dd/ yyyy").format(DateTime.now());

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
                        Navigator.of(context).pop(WeeklyWorkActivity(
                            activityName: activityNameControllerCancel
                                .dropDownValue!.value
                                .toString(),
                            pOne: pOneCancel.text,
                            aOne: aOneCancel.text,
                            pTwo: pTwoCancel.text,
                            aTwo: aTwoCancel.text,
                            pThree: pThreeCancel.text,
                            aThree: aThreeCancel.text,
                            pFour: pFourCancel.text,
                            aFour: aFourCancel.text,
                            pFive: pFiveCancel.text,
                            aFive: aFiveCancel.text,
                            pSix: pSixCancel.text,
                            aSix: aSixCancel.text,
                            pSeven: pSevenCancel.text,
                            aSeven: aSevenCancel.text,
                            remarks: remarksCancel.text,
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
                            labelText: 'p-1',
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
                        controller: pOne,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'a-1',
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
                        controller: aOne,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'p-2',
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
                        controller: pTwo,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'a-2',
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
                        controller: aTwo,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'p-3',
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
                        controller: pThree,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'a-3',
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
                        controller: aThree,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'p-4',
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
                        controller: pFour,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'a-4',
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
                        controller: aFour,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'p-5',
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
                        controller: pFive,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'a-5',
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
                        controller: aFive,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'p-6',
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
                        controller: pSix,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'a-6',
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
                        controller: aSix,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'p-7',
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
                        controller: pSeven,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'a-7',
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
                        controller: aSeven,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  decoration: InputDecoration(
                      labelText: 'Remarks',
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      // hintText: "Enter Remarks",
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.blueAccent))),
                  controller: remarks,
                ),
                const SizedBox(height: 30),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: ElevatedButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      minimumSize: Size(150, 60),
                    ),
                    onPressed: () {
                      if (activityNameController.dropDownValue?.value == null) {
                        Navigator.of(context).pop(WeeklyWorkActivity(
                            activityName: "",
                            pOne: pOne.text,
                            aOne: aOne.text,
                            pTwo: pTwo.text,
                            aTwo: aTwo.text,
                            pThree: pThree.text,
                            aThree: aThree.text,
                            pFour: pFour.text,
                            aFour: aFour.text,
                            pFive: pFive.text,
                            aFive: aFive.text,
                            pSix: pSix.text,
                            aSix: aSix.text,
                            pSeven: pSeven.text,
                            aSeven: aSeven.text,
                            remarks: remarks.text,
                            status: "false"));
                      } else {
                        Navigator.of(context).pop(WeeklyWorkActivity(
                            activityName: activityNameController
                                .dropDownValue!.value
                                .toString(),
                            pOne: pOne.text,
                            aOne: aOne.text,
                            pTwo: pTwo.text,
                            aTwo: aTwo.text,
                            pThree: pThree.text,
                            aThree: aThree.text,
                            pFour: pFour.text,
                            aFour: aFour.text,
                            pFive: pFive.text,
                            aFive: aFive.text,
                            pSix: pSix.text,
                            aSix: aSix.text,
                            pSeven: pSeven.text,
                            aSeven: aSeven.text,
                            remarks: remarks.text,
                            status: "false"));
                      }
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
