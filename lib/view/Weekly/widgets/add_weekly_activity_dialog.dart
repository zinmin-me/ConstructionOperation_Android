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

Future<T?> AddWeeklyActivityDialog<T>(BuildContext context) => showDialog<T>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AddWeeklyActivity(),
    );

class AddWeeklyActivity extends StatefulWidget {
  DateRangePickerController datePickerController = DateRangePickerController();

  List<DateTime?> plannedDateList = <DateTime>[];
  List<DateTime?> actualDateList = <DateTime>[];

  AddWeeklyActivity({
    super.key,
  });

  @override
  State<AddWeeklyActivity> createState() => _AddWeeklyActivityState();
}

class _AddWeeklyActivityState extends State<AddWeeklyActivity> {
  // late TextEditingController activityNameController = TextEditingController();
  late SingleValueDropDownController activityNameController =
      SingleValueDropDownController();
  late TextEditingController pOne = TextEditingController();
  late TextEditingController pTwo = TextEditingController();
  late TextEditingController pThree = TextEditingController();
  late TextEditingController pFour = TextEditingController();
  late TextEditingController pFive = TextEditingController();
  late TextEditingController pSix = TextEditingController();
  late TextEditingController pSeven = TextEditingController();
  late TextEditingController remarks = TextEditingController();

  //late TextEditingController activityNameControllerCancel;
  late SingleValueDropDownController activityNameControllerCancel;
  late TextEditingController pOneCancel;
  late TextEditingController pTwoCancel;
  late TextEditingController pThreeCancel;
  late TextEditingController pFourCancel;
  late TextEditingController pFiveCancel;
  late TextEditingController pSixCancel;
  late TextEditingController pSevenCancel;
  late TextEditingController remarksCancel;

  FocusNode searchFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // activityNameControllerCancel = TextEditingController(text: "");
    activityNameControllerCancel = SingleValueDropDownController(
        data: DropDownValueModel(name: "", value: ""));

    pOneCancel = TextEditingController(text: "");
    pTwoCancel = TextEditingController(text: "");
    pThreeCancel = TextEditingController(text: "");
    pFourCancel = TextEditingController(text: "");
    pFiveCancel = TextEditingController(text: "");
    pSixCancel = TextEditingController(text: "");
    pSevenCancel = TextEditingController(text: "");
    remarksCancel = TextEditingController(text: "");
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
                            aOne: "",
                            pTwo: pTwoCancel.text,
                            aTwo: "",
                            pThree: pThreeCancel.text,
                            aThree: "",
                            pFour: pFourCancel.text,
                            aFour: "",
                            pFive: pFiveCancel.text,
                            aFive: "",
                            pSix: pSixCancel.text,
                            aSix: "",
                            pSeven: pSevenCancel.text,
                            aSeven: "",
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
                            labelText: 'P-1',
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
                            labelText: 'P-2',
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
                            labelText: 'P-3',
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
                            labelText: 'P-4',
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
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: TextField(
                        decoration: InputDecoration(
                            labelText: 'P-5',
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
                            labelText: 'P-6',
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
                            labelText: 'P-7',
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
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  decoration: InputDecoration(
                      hintText: "Enter Remarks",
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
                            aOne: "",
                            pTwo: pTwo.text,
                            aTwo: "",
                            pThree: pThree.text,
                            aThree: "",
                            pFour: pFour.text,
                            aFour: "",
                            pFive: pFive.text,
                            aFive: "",
                            pSix: pSix.text,
                            aSix: "",
                            pSeven: pSeven.text,
                            aSeven: "",
                            remarks: remarks.text,
                            status: "false"));
                      } else {
                        Navigator.of(context).pop(WeeklyWorkActivity(
                            activityName: activityNameController
                                .dropDownValue!.value
                                .toString(),
                            pOne: pOne.text,
                            aOne: "",
                            pTwo: pTwo.text,
                            aTwo: "",
                            pThree: pThree.text,
                            aThree: "",
                            pFour: pFour.text,
                            aFour: "",
                            pFive: pFive.text,
                            aFive: "",
                            pSix: pSix.text,
                            aSix: "",
                            pSeven: pSeven.text,
                            aSeven: "",
                            remarks: remarks.text,
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
