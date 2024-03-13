import 'dart:typed_data';

import 'package:all_social_app/SQLLite/database_helper.dart';
import 'package:all_social_app/models/users.dart';
import 'package:all_social_app/screens/sign_up_screen.dart';
import 'package:all_social_app/widgets/edit_date_widget.dart';
import 'package:all_social_app/widgets/edit_platform_widget.dart';
import 'package:all_social_app/widgets/edit_time_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPost extends StatefulWidget {
  final String currentUser;
  final String displayImage;
  final String postDate;
  final String postPlatform;
  final String postTime;
  final int postId;
  String? updatedDate;
  String? updatedTime;
  String? updatedPlatform;

  EditPost({
    super.key,
    required this.currentUser,
    required this.displayImage,
    required this.postDate,
    required this.postPlatform,
    required this.postTime,
    required this.postId,
    this.updatedDate,
    this.updatedTime,
    this.updatedPlatform,
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
                    : Text("widget.displayImage"),
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
                  _navigateAndDisplayDate(context).then((updatedDate) {
                    setState(() {
                      widget.updatedDate = updatedDate;
                    });
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
                          widget.updatedDate ?? widget.postDate,
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
                    _navigateAndDisplayTime(context).then((updatedTime) {
                      setState(() {
                        widget.updatedTime = updatedTime;
                      });
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
                            widget.updatedTime ?? widget.postTime,
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
              GestureDetector(
                onTap: () {
                  _navigateAndDisplayPlatform(context).then((updatedPlatform) {
                    setState(() {
                      widget.updatedPlatform = updatedPlatform;
                    });
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
                          widget.updatedPlatform ?? widget.postPlatform,
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
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
                child: GestureDetector(
                  onTap: () {
                    // updatePost();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text('Post Updated!'),
                        ),
                      );
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

  // updatePost() async {
  //   final db = DatabaseHelper();
  //   String? updatedDate = widget.updatedDate;
  //   String? updatedTime = widget.updatedTime;
  //   String? updatedPlatform = widget.updatedPlatform;

  //   await db.updatePost(
  //     Posts(
  //       userId: currentUserId,
  //       post: pickedImage,
  //       postId: widget.postId,
  //       postDate: updatedDate!,
  //       postTime: updatedTime!,
  //       postPlatform: updatedPlatform!,
  //     ),
  //   );

  //   debugPrint("${widget.postId}");
  // }

  Future<String?> _navigateAndDisplayDate(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditDateWidget(postDate: widget.postDate),
      ),
    );
    String? updatedDate = result;

    return updatedDate;
  }

  Future<String?> _navigateAndDisplayTime(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditTimeWidget(
          postTime: widget.postTime,
        ),
      ),
    );
    String? updatedTime = result;

    return updatedTime;
  }

  Future<String?> _navigateAndDisplayPlatform(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPlatformWidget(
          postPlatform: widget.postPlatform,
        ),
      ),
    );
    String? updatedPlatform = result;

    return updatedPlatform;
  }
}
