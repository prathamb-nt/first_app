import 'package:all_social_app/custom%20widgets/custom_primary_button.dart';
import 'package:all_social_app/screens/create_posts/class/frame_class.dart';
import 'package:all_social_app/screens/create_posts/image_select_screen.dart';
import 'package:all_social_app/widgets/progress_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class FrameSelectScreen extends StatefulWidget {
  const FrameSelectScreen({
    super.key,
  });

  @override
  State<FrameSelectScreen> createState() => _FrameSelectScreenState();
}

class _FrameSelectScreenState extends State<FrameSelectScreen> {
  late PageController _pageController = PageController(viewportFraction: 1.1);
  int _pageIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var idx = _pageIndex;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Column(
            children: [
              SizedBox(
                height: 40.h,
              ),
              buildTweenAnimationBuilder(0.25, 0.25),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Text(
                  'Step 1',
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
                    'Select your post frame.',
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
                child: PageView.builder(
                  itemCount: frames.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                      debugPrint("$_pageIndex");
                      debugPrint(frames[index].frameType);
                    });
                  },
                  itemBuilder: (context, index) => FrameContent(
                      frameType: frames[index].frameType,
                      frameContainer: frames[index].frameContainer),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 32, 0, 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xffED4D86),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Text(
                        frames[idx].frameType,
                        style: GoogleFonts.montserrat(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Color(0xff1C1C1C),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.ease,
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_forward_ios,
                        color: Color(0xffED4D86),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageSelectScreen(
                          frame: FrameContent(
                              frameType: 'frameType',
                              frameContainer:
                                  frames[_pageIndex].frameContainer),
                        ),
                      ),
                    );
                  },
                  child: const CustomPrimaryButton(
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
}
