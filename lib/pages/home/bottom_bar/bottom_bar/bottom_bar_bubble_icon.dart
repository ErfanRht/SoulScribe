import 'dart:math';
import 'package:flutter/material.dart';
import '../bottom_bar_item.dart';
import '../clipper/custom_clipper.dart';
import '../components/colors.dart';

class BottomBarBubbleIcon extends StatefulWidget {
  const BottomBarBubbleIcon({
    Key? key,
    required this.item,
    required this.color,
    this.isSelected = false,
  }) : super(key: key);

  final BottomBarItem item;
  final Color color;
  final bool isSelected;

  @override
  BottomBarBubbleIconState createState() => BottomBarBubbleIconState();
}

class BottomBarBubbleIconState extends State<BottomBarBubbleIcon>
    with SingleTickerProviderStateMixin {
  static const duration = Duration(milliseconds: 500);

  late AnimationController _animationController;
  late Tween<double> _colorTween;
  late Animation<double> _animation;
  bool _isSelect = false;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: duration);
    _colorTween = Tween(begin: 0, end: 1);
    _animation = _colorTween.animate(_animationController);
    if (widget.isSelected) {
      _isSelect = widget.isSelected;
      _animationController.forward();
    }
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: Stack(
        children: [
          Positioned(bottom: 5, left: 0, right: 0, child: _labelWidget()),
          Positioned(
              bottom: widget.item.label != null ? 10 : 0,
              top: 0,
              left: 0,
              right: 0,
              child: _iconWidget()),
          Container(
            alignment: Alignment.center,
            padding:
                EdgeInsets.only(bottom: widget.item.label != null ? 10 : 0),
            child: AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget? child) {
                final scaleValue = _animation.value;

                final opacityValue = (-6.25 * pow(_animation.value, 2) +
                    6.25 * _animation.value);

                return Opacity(
                  opacity: _isSelect
                      ? opacityValue > 1
                          ? 1
                          : opacityValue
                      : 0,
                  child: Transform.scale(
                    scale: scaleValue,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: widget.color, width: 2),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      width: 50,
                      height: 50,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _iconWidget() {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipPath(
          clipper: Clipper1(),
          child: AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context, Widget? child) {
              var value = _animation.value * 2;
              value = value < 0 ? 0 : value;
              value = value > 1 ? 1 : value;
              final color = Color.lerp(colorGrey5, widget.color, value);

              final scaleValue =
                  -5 * (pow(_animation.value, 2) - _animation.value);
              return Transform.scale(
                scale: scaleValue < 1 ? 1 : scaleValue,
                child: _buildIconWidget(color!),
              );
            },
          ),
        ),
        ClipPath(
          clipper: Clipper2(),
          child: AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context, Widget? child) {
              var value = _animation.value * 3;
              value = value < 0 ? 0 : value;
              value = value > 1 ? 1 : value;
              final color = Color.lerp(colorGrey5, widget.color, value);
              final scaleValue =
                  -5 * (pow(_animation.value, 2) - _animation.value);
              return Transform.scale(
                scale: scaleValue < 1 ? 1 : scaleValue,
                child: _buildIconWidget(color!),
              );
            },
          ),
        ),
        ClipPath(
          clipper: Clipper3(),
          child: AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context, Widget? child) {
              var value = _animation.value * 4;
              value = value < 0 ? 0 : value;
              value = value > 1 ? 1 : value;
              final color = Color.lerp(colorGrey5, widget.color, value);
              final scaleValue =
                  -5 * (pow(_animation.value, 2) - _animation.value);
              return Transform.scale(
                scale: scaleValue < 1 ? 1 : scaleValue,
                child: _buildIconWidget(color!),
              );
            },
          ),
        ),
        ClipPath(
          clipper: Clipper4(),
          child: AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context, Widget? child) {
              var value = _animation.value * 5;
              value = value < 0 ? 0 : value;
              value = value > 1 ? 1 : value;
              final color = Color.lerp(colorGrey5, widget.color, value);

              final scaleValue =
                  -5 * (pow(_animation.value, 2) - _animation.value);
              return Transform.scale(
                scale: scaleValue < 1 ? 1 : scaleValue,
                child: _buildIconWidget(color!),
              );
            },
          ),
        ),
        ClipPath(
          clipper: Clipper5(),
          child: AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context, Widget? child) {
              var value = _animation.value * 6;
              value = value < 0 ? 0 : value;
              value = value > 1 ? 1 : value;
              final color = Color.lerp(colorGrey5, widget.color, value);
              final scaleValue =
                  -5 * (pow(_animation.value, 2) - _animation.value);
              return Transform.scale(
                scale: scaleValue < 1 ? 1 : scaleValue,
                child: _buildIconWidget(color!),
              );
            },
          ),
        ),
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

  Widget _labelWidget() {
    if (widget.item.label != null) {
      return Text(
        widget.item.label!,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: (widget.item.labelTextStyle ?? const TextStyle()).copyWith(
          color: _isSelect ? widget.color : colorGrey5,
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  void updateSelect(bool isSelect) {
    setState(() {
      _isSelect = isSelect;
    });

    if (!isSelect) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
  }
}
