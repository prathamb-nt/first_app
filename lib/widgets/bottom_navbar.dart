import 'package:all_social_app/screens/home_screen.dart';
import 'package:all_social_app/screens/profile_screen.dart';
import 'package:all_social_app/screens/schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle labelText = GoogleFonts.montserrat(
  textStyle: TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
    color: const Color(0xff1C1C1C),
  ),
);

class BottomAppBarWidget extends StatefulWidget {
  const BottomAppBarWidget({
    super.key,
  });

  @override
  State<BottomAppBarWidget> createState() => _BottomAppBarWidgetState();
}

class _BottomAppBarWidgetState extends State<BottomAppBarWidget> {
  int _index = 0;
  late PageController _pageController;
  late List<Widget> widgets = [
    const HomeWidget(),
    const ScheduleWidget(),
    const ProfileWidget(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _index);
  }

  // @override
  // void dispose() {
  //   _pageController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 80.h,
        child: BottomNavigationBar(
          iconSize: 24.h,
          selectedLabelStyle: labelText,
          unselectedLabelStyle: labelText,
          selectedItemColor: const Color(0xffED4D86),
          type: BottomNavigationBarType.fixed,
          elevation: 5,
          unselectedItemColor: Colors.black54,
          currentIndex: _index,
          onTap: _itemTapped,
          items: [
            BottomNavigationBarItem(
              label: "Home",
              activeIcon: SvgPicture.asset("assets/ic_home_selected.svg"),
              icon: SvgPicture.asset("assets/ic_home.svg"),
            ),
            BottomNavigationBarItem(
              label: "Schedule",
              activeIcon: SvgPicture.asset("assets/ic_schedule_selected.svg"),
              icon: SvgPicture.asset("assets/ic_schedule.svg"),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              activeIcon: SvgPicture.asset("assets/ic_profile_selected.svg"),
              icon: SvgPicture.asset("assets/ic_profile.svg"),
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            _index = value;
          });
        },
        children: widgets,
      ),
    );
  }

  void _itemTapped(int index) {
    setState(() {
      _index = index;

      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
      debugPrint("${widgets[index]}");
    });
  }
}
