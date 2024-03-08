import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditTimeWidget extends StatefulWidget {
  final String postTime;

  const EditTimeWidget({Key? key, required this.postTime}) : super(key: key);

  @override
  State<EditTimeWidget> createState() => _EditTimeWidgetState();
}

class _EditTimeWidgetState extends State<EditTimeWidget> {
  DateTime now = DateTime.now();

  late String paddedHour = now.hour.toString().padLeft(2, "0");
  late String paddedMinute = now.minute.toString().padLeft(2, "0");
  late final _hourController = TextEditingController(text: paddedHour);
  late final _minuteController = TextEditingController(text: paddedMinute);
  late String selectedTime = widget.postTime;
  late String selectedPlatform = 'Instagram';

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
        title: Text(
          'Edit Post Time',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              color: Color(0xff353535),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SizedBox(
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
                        color: isAMSelected
                            ? Colors.white
                            : const Color(0xffFCE6EE),
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
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTime =
                          '${_hourController.text} : ${_minuteController.text} ${isAMSelected ? 'AM' : 'PM'}';

                      Navigator.pop(context, selectedTime);
                    });
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
                        'Save',
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
}
