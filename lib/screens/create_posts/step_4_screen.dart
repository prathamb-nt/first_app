import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class CreatePostScreenStep4 extends StatefulWidget {
  const CreatePostScreenStep4({super.key});

  @override
  State<CreatePostScreenStep4> createState() => _CreatePostScreenStep4State();
}

class _CreatePostScreenStep4State extends State<CreatePostScreenStep4> {
  DateTime now = DateTime.now();

  late String hour = now.hour.toString();
  late String minute = now.minute.toString();

  bool isDateSelected = false;

  bool isTimeSelected = false;

  bool isAMSelected = true;
  bool isInstagramSelected = true;

  int selectedIndex = 0;

  String displayImageUrl = "assets/default_post_image.svg";
  TextAlign? alignText;
  late final _hourController = TextEditingController(text: hour);
  late final _minuteController = TextEditingController(text: minute);

  TextStyle textStyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 24,
      color: Color(0xff353535),
    ),
  );

  final List<String> svgUrl = [
    "assets/ic_left_align.svg",
    "assets/ic_middle_align.svg",
    "assets/ic_right_align.svg"
  ];
  final List<TextAlign> textAlignment = [
    TextAlign.start,
    TextAlign.center,
    TextAlign.end,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 15),
          child: Column(
            children: [
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                tween: Tween<double>(
                  begin: 0.50,
                  end: 1,
                ),
                builder: (context, value, _) => LinearPercentIndicator(
                  animation: true,
                  animationDuration: 300,
                  animateFromLastPercent: true,
                  width: 342.0,
                  lineHeight: 8.0,
                  percent: 1,
                  barRadius: const Radius.circular(20),
                  progressColor: const Color(0xffED4D86),
                  backgroundColor: const Color(0xffE6E6E6),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
                child: Text(
                  'Step 4',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Color(0xff1C1C1C),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Schedule your post.',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xff1C1C1C),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select post date',
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
                  setState(() {
                    if (isTimeSelected == true) {
                      isTimeSelected = !isTimeSelected;
                    }

                    isDateSelected = !isDateSelected;
                  });
                },
                child: Container(
                  height: 40,
                  width: 342,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: isDateSelected
                          ? const Color(0xffED4D86)
                          : const Color(0xffE6E6E6),
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
                          'Select date',
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
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select post time',
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
                  setState(() {
                    if (isDateSelected == true) {
                      isDateSelected = !isDateSelected;
                    }
                    isTimeSelected = !isTimeSelected;
                  });
                },
                child: Container(
                  height: 40,
                  width: 342,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: isTimeSelected
                          ? const Color(0xffED4D86)
                          : const Color(0xffE6E6E6),
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
                          'Select time',
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
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
                        child: Text(
                          'Select time',
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
                            });
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              height: 40,
                              width: 47,
                              decoration: BoxDecoration(
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
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 47,
                            decoration: BoxDecoration(
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
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isInstagramSelected = !isInstagramSelected;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 40.0),
                            child: Container(
                              height: 66,
                              width: 66,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: isInstagramSelected
                                      ? const Color(0xffE6E6E6)
                                      : const Color(0xffED4D86),
                                  width: 1,
                                ),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                    "assets/ic_instagram_logo.svg"),
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isInstagramSelected = !isInstagramSelected;
                            });
                          },
                          child: Container(
                            height: 66,
                            width: 66,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: isInstagramSelected
                                    ? const Color(0xffED4D86)
                                    : const Color(0xffE6E6E6),
                                width: 1,
                              ),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                  "assets/ic_facebook_logo.svg"),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
