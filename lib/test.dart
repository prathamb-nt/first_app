import 'package:all_social_app/models/users.dart';
import 'package:all_social_app/screens/create_posts/frame_select_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
class HomeScreen extends StatefulWidget {
  final String? currentDocId;
  const HomeScreen({super.key, this.currentDocId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _showFab = false; // Add this line

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBarWidget(),
      body: HomeWidget(showFab: _showFab), // Pass _showFab as an argument
    );
  }
}

class HomeWidget extends StatefulWidget {
  final bool showFab;

  const HomeWidget({
    super.key,
    required this.showFab,
  });

  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  Users? users;
  late String name;
  TextStyle textstyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
  );
  int hours = DateTime.now().hour;
  late String docId = "docSnapshot.id";
  bool _showFab = false;

  @override
  void initState() {
    super.initState();
    _showFab = widget.showFab; // Use the passed _showFab value
  }

  // ... Rest of the code ...

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // ... Rest of the code ...

        Positioned(
          bottom: 6,
          right: 24,
          child: AnimatedOpacity(
            opacity: _showFab ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              child: isShowPostVisible
                  ? FloatingActionButton(
                      heroTag: null,
                      backgroundColor: const Color(0xffED4D86),
                      shape: const CircleBorder(),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FrameSelectScreen(),
                          ),
                        );
                      },
                      child: const Center(
                        child: SvgPicture.asset("assets/ic_plus.svg"),
                      ),
                    )
                  : Container(
                      height: 100,
                      width: 100,
                      color: Colors.red,
                    ),
            ),
          ),
        ),
      ],
    );
  }
}