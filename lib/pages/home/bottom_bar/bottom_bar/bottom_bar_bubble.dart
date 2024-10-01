import 'dart:math';
import 'package:flutter/material.dart';
import '../bottom_bar_item.dart';
import 'bottom_bar_bubble_icon.dart';

class BottomBarBubble extends StatefulWidget {
  const BottomBarBubble({
    Key? key,
    required this.items,
    this.selectedIndex = 0,
    this.height = 71,
    this.bubbleSize = 10,
    this.color = Colors.green,
    this.backgroundColor = Colors.white,
    this.onSelect,
  }) : super(key: key);

  final int selectedIndex;
  final double height;
  final double bubbleSize;
  final Color color;
  final Color backgroundColor;
  final ValueChanged<int>? onSelect;
  final List<BottomBarItem> items;

  @override
  State<BottomBarBubble> createState() => _BottomBarBubbleState();
}

class _BottomBarBubbleState extends State<BottomBarBubble>
    with SingleTickerProviderStateMixin {
  static const duration = Duration(milliseconds: 500);
  List<GlobalKey<BottomBarBubbleIconState>> iconsKey = [];

  late int _iconCount = 0;
  late int _selectedIndex;
  late AnimationController _animationController;
  late Tween<double> _colorTween;
  late Animation<double?> _animation;

  @override
  void initState() {
    _colorTween = Tween(begin: 0, end: 1);
    _animationController = AnimationController(vsync: this, duration: duration);
    _animation = _colorTween.animate(_animationController);

    _selectedIndex = widget.selectedIndex;
    _handleTextChangeFromOutside();

    super.initState();
  }

  @override
  void didUpdateWidget(covariant BottomBarBubble oldWidget) {
    super.didUpdateWidget(oldWidget);
    _handleTextChangeFromOutside();
  }

  void _handleTextChangeFromOutside() {
    _iconCount = widget.items.length;

    iconsKey.clear();
    for (var i = 0; i < _iconCount; i++) {
      final key = GlobalKey<BottomBarBubbleIconState>();
      iconsKey.add(key);
    }

    if (widget.selectedIndex >= _iconCount || widget.selectedIndex < 0) {
      throw RangeError('selectedIndex is out of range');
    }
    _onChangeIndex(widget.selectedIndex);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  double _getLeftPosition() {
    double width = MediaQuery.of(context).size.width;

    final iconWidth = width / _iconCount;

    return (_selectedIndex * iconWidth) + (iconWidth / 2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.backgroundColor,
      height: widget.height,
      child: Stack(
        children: [
          Row(children: _iconsWidget()),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            top: (widget.height - widget.bubbleSize) / 2,
            curve: const Cubic(0.3, 0.6, 0.6, 0.3),
            left: _getLeftPosition(),
            child: AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget? child) {
                return _bubbleWidget(
                    const Offset(0, 0), widget.bubbleSize * 0.9);
              },
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 350),
            top: (widget.height - widget.bubbleSize) / 2,
            curve: const Cubic(0.3, 0.6, 0.6, 0.3),
            left: _getLeftPosition() + 3,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget? child) {
                return _bubbleWidget(
                    const Offset(0, 13), widget.bubbleSize * 0.8);
              },
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            curve: const Cubic(0.3, 0.6, 0.6, 0.3),
            top: (widget.height - widget.bubbleSize) / 2,
            left: _getLeftPosition() + 3,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget? child) {
                return _bubbleWidget(
                    const Offset(0, -10), widget.bubbleSize * 1.1);
              },
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 450),
            top: (widget.height - widget.bubbleSize) / 2,
            curve: const Cubic(0.3, 0.6, 0.6, 0.3),
            left: _getLeftPosition() - 3,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget? child) {
                return _bubbleWidget(
                    const Offset(0, -13), widget.bubbleSize * 0.85);
              },
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: const Cubic(0.3, 0.6, 0.6, 0.3),
            top: (widget.height - widget.bubbleSize) / 2,
            left: _getLeftPosition() - 3,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget? child) {
                return _bubbleWidget(
                    const Offset(0, 15), widget.bubbleSize * 0.9);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _bubbleWidget(Offset offset, double size) {
    final value = _animation.value!;
    final scaleValue = -4 * (pow(value, 2) - value);
    return Transform.scale(
      scale: scaleValue,
      child: Transform.translate(
        offset: offset,
        child: ClipOval(
          child: Container(
            color: widget.color,
            width: size,
            height: size,
          ),
        ),
      ),
    );
  }

  List<Widget> _iconsWidget() {
    List<Widget> iconWidgets = [];

    widget.items.asMap().forEach((index, item) {
      iconWidgets.add(Expanded(
        child: InkWell(
          onTap: () => _onChangeIndex(index),
          child: BottomBarBubbleIcon(
            key: iconsKey[index],
            isSelected: _selectedIndex == index,
            item: item,
            color: widget.color,
          ),
        ),
      ));
    });

    return iconWidgets;
  }

  Future _onChangeIndex(int index) async {
    if (index == _selectedIndex) {
      return;
    }

    widget.onSelect?.call(index);

    iconsKey[_selectedIndex].currentState?.updateSelect(false);
    await Future.delayed(const Duration(milliseconds: 200));

    if (_animationController.status == AnimationStatus.completed) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }

    setState(() {
      _selectedIndex = index;
    });

    await Future.delayed(const Duration(milliseconds: 200));
    iconsKey[_selectedIndex].currentState?.updateSelect(true);
  }
}
