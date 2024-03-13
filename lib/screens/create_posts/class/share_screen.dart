import 'dart:io';
import 'dart:typed_data';

import 'package:all_social_app/models/users.dart';
import 'package:all_social_app/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';

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
  String? downloadUrl;

  // @override
  // void initState() {
  //   loadImage();
  //   super.initState();
  // }

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

                    // await uploadImage();
                    // Save the post and navigate to the HomeScreen or show a success message

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => HomeScreen(
                    //       currentUser: widget.currentUser,
                    //       displayImage: widget.displayImage,
                    //       imageText: widget.imageText,
                    //     ),
                    //   ),
                    // );
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

  Future<String> uploadImage() async {
    final int postId = ShareScreen.postIdCounter++;

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File imageFile = File('$tempPath/post_$postId.png');

    await imageFile.writeAsBytes(widget.postBytes);

    Reference ref =
        FirebaseStorage.instance.ref().child("posts").child("$postId.png");
    UploadTask uploadTask = ref.putFile(imageFile);

    try {
      await uploadTask;
      String downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      print("Error uploading image: $e");
      return "";
    }
  }

  void savePost() async {
    String downloadUrl = await uploadImage();

    if (downloadUrl.isEmpty) {
      print("Failed to upload image");
      return;
    }

    final docPost = FirebaseFirestore.instance.collection('posts').doc();

    final post = PostFire(
      userId: FirebaseAuth.instance.currentUser!.uid,
      post: downloadUrl,
      postDate: widget.selectedDate,
      postTime: widget.selectedTime,
      postPlatform: widget.currentUser,
      postId: ShareScreen.postIdCounter,
    );

    final json = post.toJson();
    await docPost.set(json);
    print("created post");

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
  }

  // void savePost() async {
  //   final docPost = FirebaseFirestore.instance.collection('posts').doc();
  //   final int postId = ShareScreen.postIdCounter++;

  //   final post = PostFire(
  //     userId: FirebaseAuth.instance.currentUser!.uid,
  //     post: widget.postBytes,
  //     postDate: widget.selectedDate,
  //     postTime: widget.selectedTime,
  //     postPlatform: widget.selectedPlatform,
  //     postId: postId,
  //   );
  //   final json = post.toJson();
  //   await docPost.set(json);
  //   print("created post");
  // }

  // void savePost() async {
  //   final db = DatabaseHelper();
  //   final int postId = ShareScreen.postIdCounter++;

  //   await db.savePost(
  //     Posts(
  //       userId: currentUserId,
  //       post: widget.postBytes,
  //       postDate: widget.selectedDate,
  //       postTime: widget.selectedTime,
  //       postPlatform: widget.selectedPlatform,
  //       postId: postId,
  //     ),
  //   );
  // }

  // Future uploadImage() async {
  //   final int postId = ShareScreen.postIdCounter++;

  //   Uint8List imageInUnit8List = widget.postBytes;
  //   final tempDir = await getTemporaryDirectory();
  //   File file = await File('${tempDir.path}/$postId.png').create();
  //   file.writeAsBytesSync(imageInUnit8List);
  //   print('1');

  //   Reference ref = FirebaseStorage.instance.ref().child("images");
  //   await ref.putFile(file);
  //   downloadUrl = await ref.getDownloadURL();
  //   print(downloadUrl);
  // }
  // Future<void> uploadImage() async {
  //   final int postId = ShareScreen.postIdCounter++;

  //   File file = await imageConvert(postId);

  //   Reference ref =
  //       FirebaseStorage.instance.ref().child("images").child("$postId.png");
  //   UploadTask uploadTask = ref.putFile(file);

  //   try {
  //     await uploadTask;
  //     String downloadUrl = await ref.getDownloadURL();
  //     print(downloadUrl);
  //   } on FirebaseException catch (e) {
  //     print("Error uploading image: $e");
  //   }
  // }

  // Future<File> imageConvert(int postId) async {
  //   Uint8List imageInUnit8List = widget.postBytes;
  //   final tempDir = await getTemporaryDirectory();
  //   final file = File('${tempDir.path}/$postId.png');
  //   await file.writeAsBytes(imageInUnit8List);
  //   return file;
  // }
}
