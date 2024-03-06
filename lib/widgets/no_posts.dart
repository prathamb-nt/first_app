import 'package:all_social_app/screens/create_posts/step_1_screen.dart';
import 'package:all_social_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class NoPosts extends StatelessWidget {
  const NoPosts({
    super.key,
    required this.widget,
  });

  final HomeWidget widget;

  @override
  Widget build(BuildContext context) {
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
