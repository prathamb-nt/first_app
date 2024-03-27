import 'package:all_social_app/custom%20widgets/custom_primary_button.dart';
import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final int pageIndex;

  const CustomBackButton({
    super.key,
    required PageController pageController,
    required this.pageIndex,
  }) : _pageController = pageController;

  final PageController _pageController;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (pageIndex != 0) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 45),
            child: GestureDetector(
              onTap: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              },
              child: const CustomSecondaryButton(
                label: 'Back',
              ),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 45),
          child: GestureDetector(
            onTap: () {},
            child: const SizedBox(
              height: 40,
              width: 342,
            ),
          ),
        );
      },
    );
  }
}
