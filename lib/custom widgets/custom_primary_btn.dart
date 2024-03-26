import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPrimaryBtn extends StatelessWidget {
  final String? label;
  const CustomPrimaryBtn({super.key, this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          label!,
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xffFFFFFC),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSecondaryBtn extends StatelessWidget {
  final String? label;
  const CustomSecondaryBtn({super.key, this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 342,
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
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xffED4D86),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDeleteBtn extends StatelessWidget {
  final String? label;
  const CustomDeleteBtn({super.key, this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 342,
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
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xffFFFFFC),
            ),
          ),
        ),
      ),
    );
  }
}
