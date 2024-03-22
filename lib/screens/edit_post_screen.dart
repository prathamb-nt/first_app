import 'package:all_social_app/custom%20widgets/custom_primary_btn.dart';
import 'package:all_social_app/models/users.dart';
import 'package:all_social_app/screens/sign_up_screen.dart';
import 'package:all_social_app/widgets/edit_date_widget.dart';
import 'package:all_social_app/widgets/edit_platform_widget.dart';
import 'package:all_social_app/widgets/edit_time_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPost extends StatefulWidget {
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
                    : Image.network(widget.displayImage),
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
                    fetchPosts();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(
                          content: Text('Post Updated!'),
                        ),
                      );
                  },
                  child: const CustomPrimaryBtn(
                    label: 'Save',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  late String docId = "userId";
  late String postDocId = "docSnapshot.id";
  fetchPosts() async {
    await FirebaseFirestore.instance
        .collection("users")
        .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          docId = docSnapshot.id;
        }
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );
    setState(() {});
    await FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .collection('posts')
        .where('postId', isEqualTo: widget.postId)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          postDocId = docSnapshot.id;
        }
      },
      onError: (e) => debugPrint("Error completing: $e"),
    );

    updatePost();
  }

  updatePost() async {
    String? updatedDate = widget.updatedDate;
    String? updatedTime = widget.updatedTime;
    String? updatedPlatform = widget.updatedPlatform;

    debugPrint("${widget.postId}");
    debugPrint(FirebaseAuth.instance.currentUser!.uid);

    debugPrint("post doc is: $postDocId");
    debugPrint("user doc is: $docId");
    final docPost = FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .collection('posts')
        .doc(postDocId);

    await docPost.update({
      'postDate': updatedDate != null ? widget.updatedDate : widget.postDate,
      'postTime': updatedTime != null ? widget.updatedTime : widget.postTime,
      'postPlatform': updatedPlatform != null
          ? widget.updatedPlatform
          : widget.postPlatform,
    });

    debugPrint("completed");
  }

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
