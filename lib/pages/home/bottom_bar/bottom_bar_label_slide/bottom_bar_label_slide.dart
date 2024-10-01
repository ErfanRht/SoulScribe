import 'package:flutter/material.dart';
import 'package:soulscribe/pages/home/bottom_bar/utils/app_utils.dart';
import '../bottom_bar_item.dart';
import 'bottom_bar_label_slide_icon.dart';

class BottomBarLabelSlide extends StatefulWidget {
  BottomBarLabelSlide({
    super.key,
    required this.items,
    this.selectedIndex = 0,
    this.height = 71,
    this.bubbleSize = 10,
    this.color = Colors.green,
    this.backgroundColor = Colors.white,
    this.onSelect,
  }) : assert(items.every((element) => element.label?.isNotEmpty ?? false));

  final int selectedIndex;
  final double height;
  final double bubbleSize;
  final Color color;
  final Color backgroundColor;
  final ValueChanged<int>? onSelect;
  final List<BottomBarItem> items;

  @override
  State<BottomBarLabelSlide> createState() => _BottomBarLabelSlideState();
}

class _BottomBarLabelSlideState extends State<BottomBarLabelSlide>
    with SingleTickerProviderStateMixin {
  static const duration = Duration(milliseconds: 300);
  List<GlobalKey<BottomBarLabelSlideIconState>> iconsKey = [];

  late int _iconCount = 0;
  late int _selectedIndex;
  late int _oldSelectedIndex;
  late AnimationController _animationController;
  late Tween<double> _colorTween;
  late Animation<double?> _animation;
  late double screenWidth;

  @override
  void initState() {
    _colorTween = Tween(begin: 0, end: 1);
    _animationController = AnimationController(vsync: this, duration: duration);
    _animation = _colorTween.animate(_animationController);

    _selectedIndex = widget.selectedIndex;
    _oldSelectedIndex = widget.selectedIndex;
    _handleTextChangeFromOutside();

    super.initState();
  }

  @override
  void didUpdateWidget(covariant BottomBarLabelSlide oldWidget) {
    super.didUpdateWidget(oldWidget);
    _handleTextChangeFromOutside();
  }

  void _handleTextChangeFromOutside() {
    _iconCount = widget.items.length;

    iconsKey.clear();
    for (var i = 0; i < _iconCount; i++) {
      final key = GlobalKey<BottomBarLabelSlideIconState>();
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

  Pair<double, double> _getAnimationPostion(int index) {
    final iconWidth = screenWidth / (_iconCount + 1);

    double left, right;
    if (_selectedIndex > index) {
      left = index * iconWidth;
      right = (_iconCount - index) * iconWidth;
    } else if (_selectedIndex == index) {
      left = index * iconWidth;
      right = (_iconCount - index - 1) * iconWidth;
    } else {
      left = (index + 1) * iconWidth;
      right = (_iconCount - index - 1) * iconWidth;
    }

    return Pair(left, right);
  }

  Pair<double, double> _getOldPosition(int index) {
    final iconWidth = screenWidth / (_iconCount + 1);

    double left, right;
    if (_oldSelectedIndex > index) {
      left = index * iconWidth;
      right = (_iconCount - index) * iconWidth;
    } else if (_oldSelectedIndex == index) {
      left = index * iconWidth;
      right = (_iconCount - index - 1) * iconWidth;
    } else {
      left = (index + 1) * iconWidth;
      right = (_iconCount - index - 1) * iconWidth;
    }

    return Pair(left, right);
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: widget.backgroundColor,
      height: widget.height,
      child: Stack(children: _iconsWidget()),
    );
  }

  List<Widget> _iconsWidget() {
    List<Widget> iconWidgets = [];

    widget.items.asMap().forEach((index, item) {
      iconWidgets.add(AnimatedBuilder(
        animation: _animation,
        builder: (BuildContext context, Widget? child) {
          final value = Utils.getAnimationOneWayValue(_animation);

          final pos = _getOldPosition(index);
          final left = pos.left;
          final right = pos.right;

          final newPos = _getAnimationPostion(index);
          final newLeft = newPos.left;
          final newRight = newPos.right;

          return Positioned(
            left: left + value * (newLeft - left),
            right: right + value * (newRight - right),
            top: 0,
            bottom: 0,
            child: InkWell(
                onTap: () => _onChangeIndex(index),
                child: BottomBarLabelSlideIcon(
                  key: iconsKey[index],
                  isSelected: _selectedIndex == index,
                  item: item,
                  color: widget.color,
                  backgroundColor: widget.backgroundColor,
                )),
          );
        },
      ));
    });

    return iconWidgets;
  }

  Future _onChangeIndex(int index) async {
    if (index == _selectedIndex) {
      return;
    }

    _oldSelectedIndex = _selectedIndex;
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

    widget.onSelect?.call(_selectedIndex);
  }
}
