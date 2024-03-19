import 'package:all_social_app/custom%20widgets/custom_primary_btn.dart';
import 'package:all_social_app/screens/create_posts/frame_select_screen.dart';
import 'package:all_social_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          padding: const EdgeInsets.fromLTRB(24, 55, 24, 0),
          child: SvgPicture.asset(
            "assets/no_posts_default_image.svg",
            height: 335.h,
            width: 247.h,
          ),
        ),
        SizedBox(height: 30.h),
        Text(
          "You don’t have create any posts. Please\ncreate a new post.",
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              color: Color(0xff1C1C1C),
            ),
          ),
        ),
        SizedBox(height: 50.h),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FrameSelectScreen(),
              ),
            );
          },
          child: const CustomPrimaryBtn(
            label: 'Create Post',
          ),
        ),
      ],
    );
  }
}
