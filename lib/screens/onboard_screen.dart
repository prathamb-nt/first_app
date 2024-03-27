import 'package:all_social_app/widgets/onboarding/back_btn.dart';
import 'package:all_social_app/widgets/onboarding/dot_indicator.dart';
import 'package:all_social_app/widgets/onboarding/next_btn.dart';
import 'package:all_social_app/widgets/onboarding/onboarding_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({
    super.key,
  });

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController _pageController;
  int _pageIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 40.h),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _pageController.jumpToPage(2);
                      });
                    },
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Skip",
                        style: GoogleFonts.montserrat(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16.sp,
                            color: const Color(0xff1C1C1C),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 600.h,
                child: PageView.builder(
                  itemCount: demoData.length,
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _pageIndex = index;
                      debugPrint("$_pageIndex");
                    });
                  },
                  itemBuilder: (context, index) => OnBoardingContent(
                    image: demoData[index].image,
                    title: demoData[index].title,
                    description: demoData[index].description,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    demoData.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: DotIndicator(isActive: index == _pageIndex),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              CustomNextButton(
                pageController: _pageController,
                pageIndex: _pageIndex,
              ),
              CustomBackButton(
                pageIndex: _pageIndex,
                pageController: _pageController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
