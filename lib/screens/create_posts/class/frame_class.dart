import 'package:flutter/material.dart';

class Frame {
  final String frameType;
  final Widget frameContainer;

  Frame({required this.frameType, required this.frameContainer});
}

final List<Frame> frames = [
  Frame(
    frameType: 'Square',
    frameContainer: Container(
      height: 342,
      width: 342,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: const Color(0xffE6E6E6),
        ),
      ),
    ),
  ),
  Frame(
    frameType: 'Vertical',
    frameContainer: SizedBox(
      height: 420,
      width: 342,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: const Color(0xffE6E6E6),
          ),
        ),
      ),
    ),
  ),
  Frame(
    frameType: 'Horizontal',
    frameContainer: SizedBox(
      height: 200,
      width: 342,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: const Color(0xffE6E6E6),
          ),
        ),
      ),
    ),
  ),
];

class FrameContent extends StatelessWidget {
  const FrameContent({
    super.key,
    required this.frameType,
    required this.frameContainer,
  });
  final String frameType;
  final Widget frameContainer;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [frameContainer, const Spacer()],
      ),
    );
  }
}
