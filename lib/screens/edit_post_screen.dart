import 'dart:typed_data';

import 'package:all_social_app/SQLLite/database_helper.dart';
import 'package:all_social_app/models/users.dart';
import 'package:all_social_app/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class EditPost extends StatefulWidget {
  final String currentUser;
  final Uint8List displayImage;
  final String postDate;
  final String postPlatform;
  final String postTime;
  final int postId;

  const EditPost({
    super.key,
    required this.currentUser,
    required this.displayImage,
    required this.postDate,
    required this.postPlatform,
    required this.postTime,
    required this.postId,
  });

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  @override
  void initState() {
    super.initState();
  }

  late int currentUserId = int.parse(widget.currentUser);

  Users? users;
  late String name;
  late String email;
  late String password;

  TextStyle textstyle = GoogleFonts.montserrat(
    textStyle: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: isIncorrect ? const Color(0xff353535) : Colors.red),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Post',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              color: Color(0xff353535),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 15),
          child: Column(
            children: [
              SizedBox(
                width: 342,
                height: 342,
                child: widget.displayImage == null
                    ? Container(
                        width: 342,
                        height: 342,
                        color: Colors.red,
                      )
                    : Image.memory(widget.displayImage),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Edit Post Schedule',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color(0xff1C1C1C),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditDateWidget(
                        postDate: widget.postDate,
                      ),
                    ),
                  );
                },
                child: Container(
                  height: 40,
                  width: 342,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: const Color(0xffED4D86),
                      width: 1,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          widget.postDate,
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xff1C1C1C),
                            ),
                          ),
                        ),
                        SvgPicture.asset("assets/ic_calander.svg")
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EditTimeWidget(),
                      ),
                    );
                  },
                  child: Container(
                    height: 40,
                    width: 342,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: const Color(0xffED4D86),
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.postTime,
                            style: GoogleFonts.montserrat(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: Color(0xff1C1C1C),
                              ),
                            ),
                          ),
                          SvgPicture.asset("assets/ic_time.svg")
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 40,
                width: 342,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: const Color(0xffED4D86),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.postPlatform,
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xff1C1C1C),
                          ),
                        ),
                      ),
                      SvgPicture.asset("assets/ic_platform.svg")
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
                child: GestureDetector(
                  onTap: () {
                    debugPrint("update pushed");
                  },
                  child: Container(
                    height: 40,
                    width: 342,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ),
                        color: Color(0xffED4D86)),
                    child: Center(
                      child: Text(
                        'Update',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xffFFFFFC),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // void update(BuildContext context) {
  //   debugPrint('pressed');
  //   final db = DatabaseHelper();
  //   db
  //       .updateUser(
  //     Users(
  //       userEmail: _emailController.text,
  //       userPassword: _passwordController.text,
  //       userName: _nameController.text,
  //     ),
  //   )
  //       .whenComplete(() {
  //     debugPrint('UPDATED');
  //   });
  // }

  updatePost() async {
    final db = DatabaseHelper();
    String updatedDate = "_nameController.text";
    String updatedTime = "_emailController.text";
    String updatedPlatform = "_passwordController.tex";

    var response = await db.updatePost(
      Posts(
        userId: currentUserId,
        post: widget.displayImage,
        postId: widget.postId,
        postDate: updatedDate,
        postTime: updatedTime,
        postPlatform: updatedPlatform,
      ),
    );
    if (response is String) {
      late String editPostId = response as String;
      print(editPostId);
    } else {
      debugPrint("invalid user");
    }
  }
}

class EditTimeWidget extends StatefulWidget {
  const EditTimeWidget({Key? key}) : super(key: key);

  @override
  State<EditTimeWidget> createState() => _EditTimeWidgetState();
}

class _EditTimeWidgetState extends State<EditTimeWidget> {
  DateTime now = DateTime.now();

  // late String hour = now.hour.toString();
  // late String minute = now.minute.toString();

  late String paddedHour = now.hour.toString().padLeft(2, "0");
  late String paddedMinute = now.minute.toString().padLeft(2, "0");
  late final _hourController = TextEditingController(text: paddedHour);
  late final _minuteController = TextEditingController(text: paddedMinute);
  String selectedTime = 'Select time';
  String selectedPlatform = 'Instagram';

  bool isAMSelected = true;
  bool isInstagramSelected = true;
  TextStyle textStyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 24,
      color: Color(0xff353535),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Edit Post',
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 24,
                color: Color(0xff353535),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        height: 381,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
                child: Text(
                  'Select Time',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xff1C1C1C),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                SizedBox(
                  height: 66,
                  width: 66,
                  child: Center(
                    child: TextFormField(
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      textAlign: TextAlign.center,
                      onChanged: (text) {
                        setState(() {
                          text = _hourController.text;
                          selectedTime =
                              '${_hourController.text} : ${_minuteController.text} ${isAMSelected ? 'AM' : 'PM'}';
                        });
                      },
                      minLines: 1,
                      maxLines: 1,
                      keyboardType: TextInputType.datetime,
                      style: textStyle,
                      controller: _hourController,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffED4D86),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffE6E6E6),
                            width: 1.0,
                          ),
                        ),
                        alignLabelWithHint: false,
                        contentPadding: EdgeInsetsDirectional.all(15),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text(
                    ':',
                    style: GoogleFonts.montserrat(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                        color: Color(0xff1C1C1C),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 66,
                  width: 66,
                  child: Center(
                    child: TextFormField(
                      onTapOutside: (event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      textAlign: TextAlign.center,
                      onChanged: (text) {
                        setState(() {
                          text = _minuteController.text;
                          selectedTime =
                              '${_hourController.text} : ${_minuteController.text} ${isAMSelected ? 'AM' : 'PM'}';
                        });
                      },
                      minLines: 1,
                      maxLines: 1,
                      keyboardType: TextInputType.datetime,
                      style: textStyle,
                      controller: _minuteController,
                      decoration: const InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffED4D86),
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xffE6E6E6),
                            width: 1.0,
                          ),
                        ),
                        alignLabelWithHint: false,
                        contentPadding: EdgeInsetsDirectional.all(15),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAMSelected = !isAMSelected;
                      selectedTime =
                          '${_hourController.text} : ${_minuteController.text} ${isAMSelected ? 'AM' : 'PM'}';
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Container(
                      height: 40,
                      width: 47,
                      decoration: BoxDecoration(
                        color: isAMSelected
                            ? const Color(0xffFCE6EE)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: isAMSelected
                              ? const Color(0xffED4D86)
                              : const Color(0xffE6E6E6),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'AM',
                          style: GoogleFonts.montserrat(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                              color: Color(0xff1C1C1C),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isAMSelected = !isAMSelected;
                      selectedTime =
                          '${_hourController.text} : ${_minuteController.text} ${isAMSelected ? 'AM' : 'PM'}';
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 47,
                    decoration: BoxDecoration(
                      color:
                          isAMSelected ? Colors.white : const Color(0xffFCE6EE),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: isAMSelected
                            ? const Color(0xffE6E6E6)
                            : const Color(0xffED4D86),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'PM',
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color(0xff1C1C1C),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select Platform',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xff1C1C1C),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isInstagramSelected = !isInstagramSelected;
                      selectedPlatform = 'Instagram';
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 40.0),
                    child: Container(
                      height: 66,
                      width: 66,
                      decoration: BoxDecoration(
                        color: isInstagramSelected
                            ? Colors.white
                            : const Color(0xffFCE6EE),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: isInstagramSelected
                              ? const Color(0xffE6E6E6)
                              : const Color(0xffED4D86),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Image.asset("assets/ic_instagram_logo.png"),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isInstagramSelected = !isInstagramSelected;
                      selectedPlatform = 'Facebook';
                    });
                  },
                  child: Container(
                    height: 66,
                    width: 66,
                    decoration: BoxDecoration(
                      color: isInstagramSelected
                          ? const Color(0xffFCE6EE)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: isInstagramSelected
                            ? const Color(0xffED4D86)
                            : const Color(0xffE6E6E6),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset("assets/ic_facebook_logo.svg"),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class EditDateWidget extends StatefulWidget {
  final String postDate;

  const EditDateWidget({super.key, required this.postDate});

  @override
  State<EditDateWidget> createState() => _EditDateWidgetState();
}

class _EditDateWidgetState extends State<EditDateWidget> {
  late String selectedDate = widget.postDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Edit Post',
            style: GoogleFonts.montserrat(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 24,
                color: Color(0xff353535),
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
              child: Text(
                'Select Date',
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: Color(0xff1C1C1C),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 310,
            width: 342,
            child: SfDateRangePicker(
              allowViewNavigation: false,
              selectionMode: DateRangePickerSelectionMode.single,
              enablePastDates: false,
              headerStyle: DateRangePickerHeaderStyle(
                textStyle: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: Color(0xff353535),
                  ),
                ),
              ),
              navigationMode: DateRangePickerNavigationMode.snap,
              showNavigationArrow: true,
              monthViewSettings:
                  const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
              todayHighlightColor: const Color(0xffED4D86),
              selectionColor: const Color(0xffED4D86),
              selectionShape: DateRangePickerSelectionShape.rectangle,
              selectionRadius: 4,
              onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                setState(
                  () {
                    selectedDate = DateFormat.yMMMd().format(
                        dateRangePickerSelectionChangedArgs.value as DateTime);
                    Navigator.pop(context, selectedDate);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}