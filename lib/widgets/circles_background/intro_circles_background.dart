import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulscribe/pages/login/animations.dart';

class IntroCirclesBackground extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final Color topMediumCircleColor;
  final Color topRightCircleColor;

  const IntroCirclesBackground({
    super.key,
    required this.child,
    required this.backgroundColor,
    required this.topMediumCircleColor,
    required this.topRightCircleColor,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginPageAnimationsController>(builder: (_) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(color: backgroundColor),
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              top: _.smallCirclePositionHeight,
              left: _.smallCirclePositionWidth,
              child: AnimatedOpacity(
                opacity: _.circleOpacity,
                duration: const Duration(milliseconds: 500),
                child: _CircularBox(
                  width: 398,
                  height: 398,
                  color: topRightCircleColor,
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              top: _.bigCirclePositionHeight,
              left: _.bigCirclePositionWidth,
              child: AnimatedOpacity(
                opacity: _.circleOpacity,
                duration: const Duration(milliseconds: 500),
                child: _CircularBox(
                  width: 700,
                  height: 700,
                  color: topMediumCircleColor,
                ),
              ),
            ),
            AnimatedOpacity(
                opacity: _.circleOpacity,
                duration: const Duration(milliseconds: 700),
                child: SafeArea(child: child)),
          ],
        ),
      );
    });
  }
}

class _CircularBox extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const _CircularBox({
    super.key,
    required this.width,
    required this.height,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(height),
      ),
    );
  }
}
