import 'package:flutter/material.dart';

class Frame {
  final String frameType;
  final Widget frameContainer;

  Frame({required this.frameType, required this.frameContainer});
}

final List<Frame> frames = [
  Frame(
    frameType: 'Frame 1',
    frameContainer: Container(
      height: 342,
      width: 342,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xff33F2F2),
            Color(0xffE47CE7),
          ],
        ),
      ),
      child: Center(
        child: Container(
          height: 322,
          width: 322,
          color: const Color(0xffFFFFFC),
        ),
      ),
    ),
  ),
  Frame(
    frameType: 'Frame 2',
    frameContainer: Container(
      height: 342,
      width: 342,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xffF2C833),
            Color(0xff7CE7A0),
          ],
        ),
      ),
      child: Center(
        child: Container(
          height: 322,
          width: 322,
          color: const Color(0xffFFFFFC),
        ),
      ),
    ),
  ),
  Frame(
    frameType: 'Frame 3',
    frameContainer: Container(
      height: 342,
      width: 342,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xffF23333),
            Color(0xffE7BC7C),
          ],
        ),
      ),
      child: Center(
        child: Container(
          height: 322,
          width: 322,
          color: const Color(0xffFFFFFC),
        ),
      ),
    ),
  ),
  Frame(
    frameType: 'Frame 4',
    frameContainer: Container(
      height: 342,
      width: 342,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xffD833F2),
            Color(0xffE7967C),
          ],
        ),
      ),
      child: Center(
        child: Container(
          height: 322,
          width: 322,
          color: const Color(0xffFFFFFC),
        ),
      ),
    ),
  ),
  Frame(
    frameType: 'Frame 5',
    frameContainer: Container(
      height: 342,
      width: 342,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xffF23361),
            Color(0xff847CE7),
          ],
        ),
      ),
      child: Center(
        child: Container(
          height: 322,
          width: 322,
          color: const Color(0xffFFFFFC),
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
