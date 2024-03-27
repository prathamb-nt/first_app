import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 76.h),
          Container(
            height: 342.h,
            width: 342.w,
            child: SvgPicture.asset(
              image,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            title,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 24.sp,
                color: Color(0xff1C1C1C),
              ),
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              textStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: Color(0xff1C1C1C),
              ),
            ),
          ),
          SizedBox(height: 32.h),
        ],
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
          'Lorem ipsum dolor sit amet consectetur. Purus tempor in in rhoncus quisque viverra amet.'),
  Onboard(
      image: 'assets/intro_schedule_posts_image.svg',
      title: 'Schedule Posts',
      description:
          'Lorem ipsum dolor sit amet consectetur. Purus tempor in in rhoncus quisque viverra amet.'),
  Onboard(
      image: 'assets/intro_share_posts_image.svg',
      title: 'Share Posts',
      description:
          'Lorem ipsum dolor sit amet consectetur. Purus tempor in in rhoncus quisque viverra amet.'),
];
