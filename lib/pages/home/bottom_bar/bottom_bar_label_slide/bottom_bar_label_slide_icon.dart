import 'dart:math';
import 'package:flutter/material.dart';
import 'package:soulscribe/pages/home/bottom_bar/components/common/ripple_animation_widget.dart';
import 'package:soulscribe/pages/home/bottom_bar/components/decorations.dart';
import 'package:soulscribe/pages/home/bottom_bar/utils/app_utils.dart';
import '../bottom_bar_item.dart';
import '../components/colors.dart';

class BottomBarLabelSlideIcon extends StatefulWidget {
  const BottomBarLabelSlideIcon({
    super.key,
    required this.item,
    required this.color,
    this.backgroundColor = Colors.white,
    this.isSelected = false,
  });

  final BottomBarItem item;
  final Color color;
  final Color backgroundColor;
  final bool isSelected;

  @override
  BottomBarLabelSlideIconState createState() => BottomBarLabelSlideIconState();
}

class BottomBarLabelSlideIconState extends State<BottomBarLabelSlideIcon>
    with TickerProviderStateMixin {
  static const duration = Duration(milliseconds: 500);

  final Tween<double> _tween = Tween(begin: 0, end: 1);

  late AnimationController _controller1;
  late Animation<double> _animation1;

  late AnimationController _controller2;
  late Animation<double> _animation2;

  late AnimationController _controller3;
  late Animation<double> _animation3;

  @override
  void initState() {
    _controller1 = AnimationController(vsync: this, duration: duration);
    _animation1 = _tween.animate(_controller1);
    _controller2 = AnimationController(vsync: this, duration: duration);
    _animation2 = _tween.animate(_controller2);
    _controller3 = AnimationController(vsync: this, duration: duration);
    _animation3 = _tween.animate(_controller3);
    if (widget.isSelected) {
      _controller1.forward();
      _controller2.forward();
      _controller3.forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _animation3,
            builder: (BuildContext context, Widget? child) {
              // var value = Utils.getAnimationOneWayValue(_animation3);
              var value = _animation3.value;

              final color = Color.lerp(colorGrey5, widget.color, value);

              return Positioned(
                bottom: value * 15 + 12,
                left: widget.item.iconSize + 13,
                right: 0,
                child: value == 0
                    ? const SizedBox()
                    : Text(
                        widget.item.label!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: (widget.item.labelTextStyle ?? const TextStyle())
                            .copyWith(color: color),
                      ),
              );
            },
          ),
          AnimatedBuilder(
            animation: _animation2,
            builder: (BuildContext context, Widget? child) {
              // final value = Utils.getAnimationOneWayValue(_animation2);

              var value = _animation2.value;

              var reverseValue = 1 - value;

              return Positioned(
                  bottom: 22,
                  left: value * widget.item.iconSize + 13,
                  right: reverseValue * 100 + 30,
                  child: Container(
                    height: 2.5,
                    decoration: decorSolidRound(
                      radius: 5,
                      color: widget.color,
                    ),
                  ));
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(color: widget.backgroundColor, height: 22),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            top: 0,
            child: _iconWidget(),
          ),
        ],
      ),
    );
  }

  Widget _iconWidget() {
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedBuilder(
          animation: _animation1,
          builder: (BuildContext context, Widget? child) {
            final color =
                Color.lerp(colorGrey5, widget.color, _animation1.value);
            final oneWayValue = Utils.getAnimationOneWayValue(_animation1);
            final double scaleValue =
                _animation1.status == AnimationStatus.reverse
                    ? 1
                    : -5 * (pow(oneWayValue, 2) - oneWayValue);

            return Transform.scale(
              scale: scaleValue < 1 ? 1 : scaleValue,
              child: _buildIconWidget(color!),
            );
          },
        ),
        RippleAnimationWidget(
          animation: _animation1,
          isSelect: widget.isSelected,
          color: widget.color,
        )
      ],
    );
  }

  Widget _buildIconWidget(Color color) {
    if (widget.item.iconBuilder != null) {
      return Padding(
          padding: const EdgeInsets.all(10),
          child: widget.item.iconBuilder!.call(color));
    } else {
      return Icon(widget.item.iconData!,
          size: widget.item.iconSize, color: color);
    }
  }

  Future updateSelect(bool isSelect) async {
    if (!isSelect) {
      _controller3.reverse();
      await Future.delayed(const Duration(milliseconds: 200));
      _controller2.reverse();
      await Future.delayed(const Duration(milliseconds: 200));
      _controller1.reverse();
      await Future.delayed(const Duration(milliseconds: 200));
    } else {
      _controller1.forward();
      await Future.delayed(const Duration(milliseconds: 200));
      _controller2.forward();
      await Future.delayed(const Duration(milliseconds: 200));
      _controller3.forward();
      await Future.delayed(const Duration(milliseconds: 200));
    }
  }
}
