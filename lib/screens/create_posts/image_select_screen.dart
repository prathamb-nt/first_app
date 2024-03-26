import 'dart:io';

import 'package:all_social_app/custom%20widgets/custom_primary_btn.dart';
import 'package:all_social_app/screens/create_posts/caption_select_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ImageSelectScreen extends StatefulWidget {
  final Widget? frame;
  const ImageSelectScreen({
    super.key,
    this.frame,
  });

  @override
  State<ImageSelectScreen> createState() => _ImageSelectScreenState();
}

class _ImageSelectScreenState extends State<ImageSelectScreen> {
  int selectedIndex = 0;

  late List<ListItem<String>> list;
  @override
  void initState() {
    super.initState();
    postImages();
  }

  final List<String> imageUrl = [
    'assets/default_post_image.png',
    'assets/waterfall_image.png',
    'assets/lake_image.png',
    'assets/sunset_image.png',
  ];
  void postImages() {
    list = [];
    for (int i = 0; i < imageUrl.length; i++) {
      list.add(
        ListItem<String>(
          imageUrl[i].toString(),
        ),
      );
    }
  }

  File? pickedImage;
  bool isPicked = false;
  TextStyle textStyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
  );
  String displayImageUrl = "assets/default_post_image.png";
  late String nextImageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
          child: Column(
            children: [
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
                tween: Tween<double>(
                  begin: 0.25,
                  end: 0.50,
                ),
                builder: (context, value, _) => LinearPercentIndicator(
                  animation: true,
                  animationDuration: 300,
                  animateFromLastPercent: true,
                  width: 342.0,
                  lineHeight: 8.0,
                  percent: 0.50,
                  barRadius: const Radius.circular(20),
                  progressColor: const Color(0xffED4D86),
                  backgroundColor: const Color(0xffE6E6E6),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
                child: Text(
                  'Step 2',
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
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Text(
                    'Select your post background image.',
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
                height: 342,
                width: 342,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: 342,
                          width: 342,
                          child: widget.frame,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                            height: 322,
                            width: 322,
                            child: isPicked
                                ? Image.file(
                                    pickedImage!,
                                    fit: BoxFit.fill,
                                  )
                                : Image.asset(
                                    displayImageUrl,
                                    fit: BoxFit.fill,
                                  ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer()
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 42, 0, 55),
                child: SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: imageUrl.length + 1,
                    itemBuilder: _getListItemTile,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      nextImageUrl =
                          isPicked ? pickedImage!.path : displayImageUrl;
                    });
                    debugPrint(nextImageUrl);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CaptionSelectScreen(
                          displayImage: nextImageUrl,
                          frame: widget.frame,
                          isPicked: isPicked,
                        ),
                      ),
                    );
                  },
                  child: const CustomPrimaryBtn(
                    label: 'Next',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getListItemTile(BuildContext context, int index) {
    if (index == 0) {
      return GestureDetector(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return SizedBox(
                height: 200,
                width: 400,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Choose photo from',
                        style: textStyle,
                      ),
                      GestureDetector(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null) {
                            pickedImage = File(image.path);
                            setState(() {
                              isPicked = true;
                              debugPrint("$pickedImage");
                            });
                          }
                        },
                        child: const CustomPrimaryBtn(
                          label: 'Gallery',
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? image = await picker.pickImage(
                              source: ImageSource.camera);
                          if (image != null) {
                            pickedImage = File(image.path);
                            setState(() {
                              isPicked = true;
                              debugPrint("$pickedImage");
                            });
                          }
                        },
                        child: const CustomSecondaryBtn(
                          label: 'Camera',
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
              color: Color(0xffD9D9D9),
            ),
            child: Center(
              child: SvgPicture.asset('assets/ic_add_posts.svg'),
            ),
          ),
        ),
      );
    }
    index -= 1;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          displayImageUrl = imageUrl[index].toString();
          debugPrint(displayImageUrl);
          isPicked = false;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            border: selectedIndex == index
                ? Border.all(
                    width: 2,
                    color: const Color(0xffED4D86),
                  )
                : Border.all(width: 2, color: Colors.transparent),
          ),
          child: Image.asset(
            imageUrl[index],
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}

class ListItem<T> {
  int? selectedIndex;
  T data;
  ListItem(this.data);
}
