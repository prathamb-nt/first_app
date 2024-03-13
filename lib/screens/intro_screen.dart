import 'package:all_social_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingScreen extends StatefulWidget {
  final String currentUser;
  const OnBoardingScreen({super.key, required this.currentUser});

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
            NextButton(
              pageController: _pageController,
              pageIndex: _pageIndex,
              currentUser: widget.currentUser,
            ),
            BackButton(
              pageIndex: _pageIndex,
              pageController: _pageController,
            ),
          ],
        ),
      ),
    );
  }
}

class NextButton extends StatefulWidget {
  final String currentUser;
  final int pageIndex;

  const NextButton({
    super.key,
    required PageController pageController,
    required this.pageIndex,
    required this.currentUser,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  State<NextButton> createState() => _NextButtonState();
}

class _NextButtonState extends State<NextButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Builder(builder: (context) {
        if (widget.pageIndex == 2) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(
                    currentUser: widget.currentUser!,
                  ),
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
                color: Color(0xffED4D86),
              ),
              child: Center(
                child: Text(
                  'Finished',
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
          );
        }
        return GestureDetector(
          onTap: () {
            widget._pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
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
                'Next',
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
        );
      }),
    );
  }
}

class BackButton extends StatelessWidget {
  final int pageIndex;

  const BackButton({
    super.key,
    required PageController pageController,
    required this.pageIndex,
  }) : _pageController = pageController;

  final PageController _pageController;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Builder(
        builder: (context) {
          if (pageIndex != 0) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 45),
              child: GestureDetector(
                onTap: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
                child: AnimatedContainer(
                  height: 40,
                  width: 342,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
                    color: Color(0xffFFFFFC),
                  ),
                  duration: const Duration(milliseconds: 300),
                  child: Center(
                    child: Text(
                      'Back',
                      style: GoogleFonts.montserrat(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Color(0xffED4D86),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 45),
            child: GestureDetector(
              onTap: () {},
              child: AnimatedContainer(
                height: 40,
                width: 342,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(6),
                  ),
                  color: Color(0xffFFFFFC),
                ),
                duration: const Duration(milliseconds: 300),
                child: Center(
                  child: Text(
                    'Back',
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
          );
        },
      ),
    );
  }
}

class DotIndicator extends StatelessWidget {
  const DotIndicator({
    super.key,
    this.isActive = false,
  });

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xffED4D86) : const Color(0xffFCE6EE),
        borderRadius: const BorderRadius.all(
          Radius.circular(100),
        ),
      ),
    );
  }
}

class Onboard {
  final String image, title, description;

  Onboard({
    required this.image,
    required this.title,
    required this.description,
  });
}

final List<Onboard> demoData = [
  Onboard(
      image: 'assets/intro_create_posts_image.svg',
      title: 'Create Posts',
      description:
          'Lorem ipsum dolor sit amet consectetur. Purus tempor in in rhoncus quisque viverra amet. Nisl nam ut lobortis quam.'),
  Onboard(
      image: 'assets/intro_schedule_posts_image.svg',
      title: 'Schedule Posts',
      description:
          'Lorem ipsum dolor sit amet consectetur. Purus tempor in in rhoncus quisque viverra amet. Nisl nam ut lobortis quam.'),
  Onboard(
      image: 'assets/intro_share_posts_image.svg',
      title: 'Share Posts',
      description:
          'Lorem ipsum dolor sit amet consectetur. Purus tempor in in rhoncus quisque viverra amet. Nisl nam ut lobortis quam.'),
];

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });
  final String image, title, description;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          image,
          height: 342,
          width: 342,
        ),
        const Spacer(),
        Text(
          title,
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 24,
              color: Color(0xff1C1C1C),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          description,
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: Color(0xff1C1C1C),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
