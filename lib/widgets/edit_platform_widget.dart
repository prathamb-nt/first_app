import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class EditPlatformWidget extends StatefulWidget {
  final String postPlatform;
  const EditPlatformWidget({super.key, required this.postPlatform});

  @override
  State<EditPlatformWidget> createState() => _EditPlatformWidgetState();
}

class _EditPlatformWidgetState extends State<EditPlatformWidget> {
  late String selectedPlatform = 'Instagram';

  bool isAMSelected = true;
  bool isInstagramSelected = true;
  TextStyle textStyle = GoogleFonts.montserrat(
    textStyle: const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 24,
      color: Color(0xff353535),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Post Platform',
          style: GoogleFonts.montserrat(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 24,
              color: Color(0xff353535),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 24, 0, 24),
                child: Text(
                  'Select Platform',
                  style: GoogleFonts.montserrat(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: Color(0xff1C1C1C),
                    ),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isInstagramSelected == true) {
                        isInstagramSelected = !isInstagramSelected;
                        selectedPlatform = 'Instagram';
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 40.0),
                    child: Container(
                      height: 66,
                      width: 66,
                      decoration: BoxDecoration(
                        color: isInstagramSelected
                            ? Colors.white
                            : const Color(0xffFCE6EE),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: isInstagramSelected
                              ? const Color(0xffE6E6E6)
                              : const Color(0xffED4D86),
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Image.asset("assets/ic_instagram_logo.png"),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isInstagramSelected == false) {
                        isInstagramSelected = !isInstagramSelected;
                        selectedPlatform = 'Facebook';
                      }
                    });
                  },
                  child: Container(
                    height: 66,
                    width: 66,
                    decoration: BoxDecoration(
                      color: isInstagramSelected
                          ? const Color(0xffFCE6EE)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: isInstagramSelected
                            ? const Color(0xffED4D86)
                            : const Color(0xffE6E6E6),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset("assets/ic_facebook_logo.svg"),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.pop(context, selectedPlatform);
                  });
                },
                child: Container(
                  height: 40,
                  width: 342,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(6),
                      ),
                      color: Color(0xffED4D86)),
                  child: Center(
                    child: Text(
                      'Save',
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
            )
          ],
        ),
      ),
    );
  }
}
