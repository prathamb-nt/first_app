import 'package:all_social_app/custom%20widgets/custom_primary_btn.dart';
import 'package:all_social_app/screens/create_posts/class/frame_class.dart';
import 'package:all_social_app/screens/create_posts/image_select_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
          child: Column(
            children: [
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                tween: Tween<double>(
                  begin: 0.0,
                  end: 0.25,
                ),
                builder: (context, value, _) => LinearPercentIndicator(
                  animation: true,
                  animationDuration: 300,
                  animateFromLastPercent: true,
                  width: 342.0,
                  lineHeight: 8.0,
                  percent: 0.25,
                  barRadius: const Radius.circular(20),
                  progressColor: const Color(0xffED4D86),
                  backgroundColor: const Color(0xffE6E6E6),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
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
}
