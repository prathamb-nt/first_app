import 'dart:io';
import 'dart:typed_data';

import 'package:all_social_app/custom%20widgets/custom_primary_button.dart';
import 'package:all_social_app/screens/create_posts/post_schedule_screen.dart';
import 'package:all_social_app/widgets/progress_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class CaptionSelectScreen extends StatefulWidget {
  final String displayImage;
  final Widget? frame;
  final bool? isPicked;

  const CaptionSelectScreen(
      {super.key, required this.displayImage, this.frame, this.isPicked});

  @override
  _CaptionSelectScreenState createState() => _CaptionSelectScreenState();
}

class _CaptionSelectScreenState extends State<CaptionSelectScreen> {
  int selectedIndex = 0;

  TextAlign? alignText;
  final _textController = TextEditingController(
      text:
          "Lorem ipsum dolor sit amet consectetur. Senectus eleifend purus viverra placerat pellentesque ac et commodo. Viverra tellus risus arcu integer justo malesuada in urna enim.");
  TextStyle textstyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
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

  Uint8List? bytes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
          child: Column(
            children: [
              SizedBox(
                height: 40.h,
              ),
              buildTweenAnimationBuilder(0.75, 0.75),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 14, 0, 14),
                child: Text(
                  'Step 3',
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
                  'Enter your caption.',
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
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: SizedBox(
                  height: 120,
                  width: 342,
                  child: TextFormField(
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    onChanged: (text) {
                      setState(() {
                        text = _textController.text;
                      });
                    },
                    minLines: 5,
                    maxLines: 5,
                    style: textstyle,
                    controller: _textController,
                    decoration: const InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffED4D86),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xffED4D86),
                          width: 1.0,
                        ),
                      ),
                      alignLabelWithHint: false,
                      contentPadding: EdgeInsetsDirectional.all(10),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              buildPostImage(),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                child: SizedBox(
                  height: 100,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 14.0),
                          child: Text(
                            'Select text alignment',
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
                        height: 46,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: svgUrl.length,
                          itemBuilder: _getListItemTile,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final controller = ScreenshotController();
                  final bytes = await controller.captureFromWidget(
                    Material(
                      child: buildPostImage(),
                    ),
                  );

                  setState(() => this.bytes = bytes);
                  saveImage(bytes);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostScheduleScreen(
                        postBytes: bytes,
                        displayImage: widget.displayImage,
                        imageText: _textController.text,
                      ),
                    ),
                  );
                },
                child: const CustomPrimaryButton(
                  label: 'Next',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox buildPostImage() {
    return SizedBox(
      height: 342,
      width: 342,
      child: Column(
        children: [
          SizedBox(
            height: 342,
            width: 342,
            child: Stack(
              children: [
                Container(
                  child: widget.frame,
                ),
                Center(
                  child: SizedBox(
                    height: 322,
                    width: 322,
                    child: widget.isPicked!
                        ? Image.file(
                            File(widget.displayImage),
                            fit: BoxFit.fill,
                          )
                        : Image.asset(
                            widget.displayImage,
                            fit: BoxFit.fill,
                          ),
                  ),
                ),
                Center(
                  child: SizedBox(
                    height: 220,
                    width: 237,
                    child: LimitedBox(
                      maxHeight: 220,
                      child: Center(
                        child: Container(
                          width: 237,
                          decoration: BoxDecoration(
                            color: const Color(0xffFFFFFC),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: const Color(0xffE6E6E6), width: 1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              maxLines: 20,
                              textAlign: alignText,
                              _textController.text,
                              style: GoogleFonts.montserrat(
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Color(0xff1C1C1C),
                                ),
                              ),
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
          const Spacer(),
        ],
      ),
    );
  }

  Widget _getListItemTile(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          alignText = textAlignment[index];

          debugPrint("$alignText");
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Container(
          height: 46,
          width: 46,
          decoration: BoxDecoration(
            color:
                selectedIndex == index ? const Color(0xffFCE6EE) : Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
                color: selectedIndex == index
                    ? const Color(0xffED4D86)
                    : const Color(0xffE6E6E6),
                width: 1),
          ),
          child: Center(
            child: SvgPicture.asset(svgUrl[index]),
          ),
        ),
      ),
    );
  }

  Future saveImage(Uint8List bytes) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/image.png');
    file.writeAsBytes(bytes);
    debugPrint("took screenshot of the image");
  }
}
