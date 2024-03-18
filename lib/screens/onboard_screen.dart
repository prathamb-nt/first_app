import 'package:all_social_app/widgets/onboarding/back_btn.dart';
import 'package:all_social_app/widgets/onboarding/dot_indicator.dart';
import 'package:all_social_app/widgets/onboarding/next_btn.dart';
import 'package:all_social_app/widgets/onboarding/onboarding_content.dart';
import 'package:flutter/material.dart';
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(305, 40, 0, 40),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _pageController.jumpToPage(2);
                      });
                    },
                    child: Text(
                      "Skip",
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
              ],
            ),
            Expanded(
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    demoData.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: DotIndicator(isActive: index == _pageIndex),
                    ),
                  )
                ],
              ),
            ),
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
    );
  }
}