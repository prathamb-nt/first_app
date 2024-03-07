import 'dart:typed_data';

import 'package:all_social_app/SQLLite/database_helper.dart';
import 'package:all_social_app/models/users.dart';
import 'package:all_social_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ShareScreen extends StatefulWidget {
  static int postIdCounter = 0;
  final String selectedDate, selectedTime, selectedPlatform;
  late Uint8List postBytes;
  final String currentUser;

  final String displayImage;
  final String imageText;

  ShareScreen({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.selectedPlatform,
    required this.postBytes,
    required this.currentUser,
    required this.displayImage,
    required this.imageText,
  });

  @override
  State<ShareScreen> createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  bool isTimeSelectionVisible = false;

  bool isDateSelected = true;

  bool isTimeSelected = false;

  late int currentUserId = int.parse(widget.currentUser);

  bool isAMSelected = true;
  bool isInstagramSelected = true;

  int selectedIndex = 0;

  TextAlign? alignText;

  TextStyle textStyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 24,
      color: Color(0xff353535),
    ),
  );

  Uint8List? bytes;

  // @override
  // void initState() {
  //   loadImage();
  //   super.initState();
  // }

  final GlobalKey _globalKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 15),
          child: Column(
            children: [
              SizedBox(
                width: 342,
                height: 342,
                child: widget.postBytes == null
                    ? Container(
                        width: 342,
                        height: 342,
                        color: Colors.red,
                      )
                    : Image.memory(widget.postBytes),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Post Schedule',
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
                    if (isDateSelected == false) {
                      isDateSelected = !isDateSelected;
                    }
                    isTimeSelectionVisible = false;
                  });
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
                          widget.selectedDate,
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
                          widget.selectedTime,
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
                        widget.selectedPlatform,
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
                padding: const EdgeInsets.fromLTRB(0, 33, 0, 83),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => {},
                      child: Container(
                        height: 40,
                        width: 155,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: const Color(0xffED4D86),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/ic_download.svg"),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  "Download",
                                  style: GoogleFonts.montserrat(
                                    textStyle: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      color: Color(0xff1C1C1C),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 155,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: const Color(0xffED4D86),
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/ic_download.svg"),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                "Share",
                                style: GoogleFonts.montserrat(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16,
                                    color: Color(0xff1C1C1C),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: GestureDetector(
                  onTap: () {
                    savePost();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(
                          currentUser: widget.currentUser,
                          displayImage: widget.displayImage,
                          imageText: widget.imageText,
                        ),
                      ),
                    );
                    debugPrint("go to home pushed");
                  },
                  child: Container(
                    height: 40,
                    width: 342,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                      color: Color(0xffED4D86),
                    ),
                    child: Center(
                      child: Text(
                        'Go to home',
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

  // void savePost() async {
  //   // Save the post to the database
  //   final db = DatabaseHelper();
  //   static int postIdCounter = 0; // Add this line
  //   final int postId = await db.savePost(
  //     Posts(
  //       userId: currentUserId,
  //       post: widget.postBytes,
  //       postDate: widget.selectedDate,
  //       postTime: widget.selectedTime,
  //       postPlatform: widget.selectedPlatform,
  //       postId: 1,
  //     ),
  //   );
  // }

  void savePost() async {
    final db = DatabaseHelper();
    final int postId = ShareScreen.postIdCounter++;
    debugPrint("${widget.postBytes}");
    await db.savePost(
      Posts(
        userId: currentUserId,
        post: widget.postBytes,
        postDate: widget.selectedDate,
        postTime: widget.selectedTime,
        postPlatform: widget.selectedPlatform,
        postId: postId,
      ),
    );
  }
}
