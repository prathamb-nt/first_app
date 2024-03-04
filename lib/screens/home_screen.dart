import 'package:all_social_app/SQLLite/database_helper.dart';
import 'package:all_social_app/widgets/bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'create_posts/step_1_screen.dart';

class HomeScreen extends StatefulWidget {
  final String currentUser;
  const HomeScreen({super.key, required this.currentUser});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBarExample(
        currentUser: widget.currentUser,
      ),
      body: HomeWidget(
        currentUser: widget.currentUser,
      ),
    );
  }
}

class HomeWidget extends StatefulWidget {
  final String currentUser;

  const HomeWidget({
    super.key,
    required this.currentUser,
  });

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  @override
  void initState() {
    super.initState();
    DatabaseHelper().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 48, 24, 24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Good Morning!\nJane Cooper',
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24,
                    color: Color(0xff1C1C1C),
                  ),
                ),
              ),
              const SizedBox(
                width: 113,
              ),
              Container(
                height: 46,
                width: 46,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  //pickedImage.toString(),
                  "assets/profile_default.png",
                  fit: BoxFit.fill,
                  height: 100,
                  width: 100,
                ),
              ),
            ],
          ),
          //buildNoPosts(context),
        ],
      ),
    );
  }

  Column buildNoPosts(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 55, 0, 0),
          child: SvgPicture.asset(
            "assets/no_posts_default_image.svg",
            height: 342,
            width: 342,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 30, 0, 50),
          child: Text(
            "You don’t have create any posts. Please\ncreate a new post.",
            textAlign: TextAlign.center,
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
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreatePostScreenStep1(
                    currentUser: widget.currentUser,
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
                  'Create Post',
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
        ),
      ],
    );
  }
}
