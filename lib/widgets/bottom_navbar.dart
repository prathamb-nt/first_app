import 'package:all_social_app/screens/account_screen.dart';
import 'package:all_social_app/screens/home_screen.dart';
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

class BottomAppBarExample extends StatefulWidget {
  const BottomAppBarExample({super.key});

  @override
  State<BottomAppBarExample> createState() => _BottomAppBarExampleState();
}

class _BottomAppBarExampleState extends State<BottomAppBarExample> {
  int _index = 0;
  late PageController _pagecontroller;
  List<Widget> widgets = [
    const HomeWidget(),
    const Settings(),
    AccountWidget(
      userId: 5,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pagecontroller = PageController(initialPage: _index);
  }

  @override
  void dispose() {
    _pagecontroller.dispose();
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
        controller: _pagecontroller,
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
      _pagecontroller.animateToPage(
        index,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
      print(widgets[index]);
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
      body: Center(child: Text('Account')),
    );
  }
}

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 236, 168),
      body: Center(child: Text('Messages')),
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
        ));
  }
}
