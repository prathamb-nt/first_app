import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

TweenAnimationBuilder<double> buildTweenAnimationBuilder(
    double end, double percent) {
  return TweenAnimationBuilder<double>(
    duration: const Duration(milliseconds: 250),
    curve: Curves.easeInOut,
    tween: Tween<double>(
      begin: 0.0,
      end: end,
    ),
    builder: (context, value, _) => LinearPercentIndicator(
      animation: true,
      animationDuration: 300,
      animateFromLastPercent: true,
      width: 340.w,
      lineHeight: 8.0,
      percent: percent,
      barRadius: const Radius.circular(20),
      progressColor: const Color(0xffED4D86),
      backgroundColor: const Color(0xffE6E6E6),
    ),
  );
}
