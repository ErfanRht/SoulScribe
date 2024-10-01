import 'dart:math';
import 'package:flutter/material.dart';
import 'package:soulscribe/pages/home/bottom_bar/utils/app_utils.dart';

class RippleAnimationWidget extends StatelessWidget {
  const RippleAnimationWidget({
    super.key,
    required this.animation,
    required this.isSelect,
    required this.color,
  });

  final Animation<double> animation;

  final bool isSelect;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        if (animation.status == AnimationStatus.reverse) {
          return const SizedBox(width: 50, height: 50);
        }
        var scaleValue = Utils.getAnimationOneWayValue(animation);

        final opacityValue =
            (-6.25 * pow(animation.value, 2) + 6.25 * animation.value);

        return Opacity(
          opacity: isSelect
              ? opacityValue > 1
                  ? 1
                  : opacityValue
              : 0,
          child: Transform.scale(
            scale: scaleValue,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: color, width: 2),
                borderRadius: BorderRadius.circular(100),
              ),
              width: 50,
              height: 50,
            ),
          ),
        );
      },
    );
  }
}
