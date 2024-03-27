import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPrimaryButton extends StatelessWidget {
  final String? label;
  const CustomPrimaryButton({super.key, this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 342.w,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
        color: Color(0xffED4D86),
      ),
      child: Center(
        child: Text(
          label!,
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: const Color(0xffFFFFFC),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSecondaryButton extends StatelessWidget {
  final String? label;
  const CustomSecondaryButton({super.key, this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 342.w,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
        color: Color(0xffFFFFFC),
      ),
      child: Center(
        child: Text(
          label!,
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: const Color(0xffED4D86),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDeleteButton extends StatelessWidget {
  final String? label;
  const CustomDeleteButton({super.key, this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 342.w,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(6),
        ),
        color: Color(0xffff4b5b),
      ),
      child: Center(
        child: Text(
          label!,
          style: GoogleFonts.montserrat(
            textStyle: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: const Color(0xffFFFFFC),
            ),
          ),
        ),
      ),
    );
  }
}
