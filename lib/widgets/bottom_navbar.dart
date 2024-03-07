import 'package:all_social_app/screens/account_screen.dart';
import 'package:all_social_app/screens/home_screen.dart';
import 'package:all_social_app/screens/schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle labelText = GoogleFonts.montserrat(
  textStyle: const TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    color: Color(0xff1C1C1C),
  ),
);

class BottomAppBarWidget extends StatefulWidget {
  final String displayImage;
  final String imageText;
  final String currentUser;

  const BottomAppBarWidget(
      {super.key,
      required this.currentUser,
      required this.displayImage,
      required this.imageText});

  @override
  State<BottomAppBarWidget> createState() => _BottomAppBarWidgetState();
}

class _BottomAppBarWidgetState extends State<BottomAppBarWidget> {
  int _index = 0;
  late PageController _pageController;
  late List<Widget> widgets = [
    HomeWidget(currentUser: widget.currentUser),
    ScheduleWidget(
      currentUser: widget.currentUser,
      displayImage: widget.displayImage,
      imageText: widget.imageText,
    ),
    AccountWidget(currentUser: widget.currentUser),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _index);
  }

  @override
  void dispose() {
    _pageController.dispose();

    super.dispose();
  }

  int selectedIcon = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SizedBox(
        height: 78,
        child: BottomNavigationBar(
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
              icon: selectedIcon == 0
                  ? SvgPicture.asset("assets/ic_home_selected.svg")
                  : SvgPicture.asset("assets/ic_home.svg"),
            ),
            BottomNavigationBarItem(
              label: "Schedule",
              icon: selectedIcon == 1
                  ? SvgPicture.asset("assets/ic_schedule_selected.svg")
                  : SvgPicture.asset("assets/ic_schedule.svg"),
            ),
            BottomNavigationBarItem(
              label: "Profile",
              icon: selectedIcon == 2
                  ? SvgPicture.asset("assets/ic_profile_selected.svg")
                  : SvgPicture.asset("assets/ic_profile.svg"),
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
      selectedIcon = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
      debugPrint("${widgets[index]}");
    });
  }
}

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 97, 205, 255),
      body: Center(child: Text('Settings')),
    );
  }
}

class Account extends StatelessWidget {
  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 139),
      body: Center(
        child: Text('Account'),
      ),
    );
  }
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 236, 168),
      body: Center(
        child: Text('Messages'),
      ),
    );
  }
}

class Modal extends StatelessWidget {
  const Modal({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      width: 400,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 1),
            child: Container(
              height: 5,
              width: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.circular(20),
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
