import 'package:all_social_app/custom%20widgets/custom_primary_button.dart';
import 'package:all_social_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

class CustomNextButton extends StatefulWidget {
  final int pageIndex;

  const CustomNextButton({
    super.key,
    required PageController pageController,
    required this.pageIndex,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  State<CustomNextButton> createState() => _CustomNextButtonState();
}

class _CustomNextButtonState extends State<CustomNextButton> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      if (widget.pageIndex == 2) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ),
            );
          },
          child: const CustomPrimaryButton(
            label: 'Finished',
          ),
        );
      }
      return GestureDetector(
        onTap: () {
          widget._pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        },
        child: const CustomPrimaryButton(
          label: 'Next',
        ),
      );
    });
  }
}
