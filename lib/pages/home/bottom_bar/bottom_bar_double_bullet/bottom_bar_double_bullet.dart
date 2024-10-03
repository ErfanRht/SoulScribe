import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/pages/home/home.dart';
import 'package:soulscribe/pages/new_entry/new-entry.dart';
import 'package:soulscribe/widgets/page_transition/src/enum.dart';
import 'package:soulscribe/widgets/page_transition/src/page_transition.dart';
import '../bottom_bar_item.dart';
import 'bottom_bar_double_bullet_icon.dart';
import 'dart:math' as math;

class BottomBarDoubleBullet extends StatefulWidget {
  const BottomBarDoubleBullet({
    super.key,
    required this.items,
    this.selectedIndex = 0,
    this.height = 71,
    this.bubbleSize = 10,
    this.color = Colors.green,
    this.circle1Color = Colors.blue,
    this.circle2Color = Colors.red,
    this.backgroundColor = Colors.white,
    this.onSelect,
  });

  final int selectedIndex;
  final double height;
  final double bubbleSize;
  final Color color;
  final Color circle1Color;
  final Color circle2Color;
  final Color backgroundColor;
  final ValueChanged<int>? onSelect;
  final List<BottomBarItem> items;

  @override
  State<BottomBarDoubleBullet> createState() => _BottomBarDoubleBulletState();
}

class _BottomBarDoubleBulletState extends State<BottomBarDoubleBullet>
    with SingleTickerProviderStateMixin {
  static const duration = Duration(milliseconds: 500);
  List<GlobalKey<BottomBarDoubleBulletIconState>> iconsKey = [];

  late int _iconCount = 0;
  late int _selectedIndex;
  late int _oldSelectedIndex;
  late AnimationController _animationController;
  late Tween<double> _colorTween;
  late Animation<double?> _animation;

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
  void didUpdateWidget(covariant BottomBarDoubleBullet oldWidget) {
    super.didUpdateWidget(oldWidget);
    _handleTextChangeFromOutside();
  }

  void _handleTextChangeFromOutside() {
    _iconCount = widget.items.length;

    iconsKey.clear();
    for (var i = 0; i < _iconCount; i++) {
      final key = GlobalKey<BottomBarDoubleBulletIconState>();
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: widget.backgroundColor,
            border: Border.all(
              color: Colors.grey.shade300, // Border color
              width: 1.5, // Border width
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Shadow color
                blurRadius: 8, // Blur effect
                offset: const Offset(0, 4), // Position of shadow
              ),
            ],
          ),
          height: widget.height,
          child: Stack(
            children: [
              // Bullet animation for the first path
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (BuildContext context, Widget? child) {
                    if (_oldSelectedIndex == _selectedIndex) {
                      return const SizedBox();
                    }
                    final startOffSet = _getStartOffset();
                    final endOffSet = _getEndOffset();

                    return ClipPath(
                      clipper: BottomBarDoubleBulletClipper(
                        _getAnimationValue(),
                        startOffSet.dx,
                        endOffSet.dx,
                        _oldSelectedIndex > _selectedIndex,
                      ),
                      child: CustomPaint(
                        painter: BulletLinePainter(_getPath1(), widget.color),
                      ),
                    );
                  },
                ),
              ),
              AnimatedBuilder(
                animation: _animation,
                builder: (BuildContext context, Widget? child) {
                  if (_oldSelectedIndex == _selectedIndex) {
                    return const SizedBox();
                  }
                  final path = _getPath1();
                  return Positioned(
                    top: calculate(path).dy - 3,
                    left: calculate(path).dx +
                        (_oldSelectedIndex < _selectedIndex ? 13 : -17),
                    child: Opacity(
                      opacity: _getAnimationValue() * 1.5 >= 0.9 ? 0 : 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: widget.circle1Color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 5,
                        height: 5,
                      ),
                    ),
                  );
                },
              ),
              // Bullet animation for the second path
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _animation,
                  builder: (BuildContext context, Widget? child) {
                    if (_oldSelectedIndex == _selectedIndex) {
                      return const SizedBox();
                    }
                    final startOffSet = _getStartOffset();
                    final endOffSet = _getEndOffset();

                    return ClipPath(
                      clipper: BottomBarDoubleBulletClipper(
                        _getAnimationValue(),
                        startOffSet.dx,
                        endOffSet.dx,
                        _oldSelectedIndex > _selectedIndex,
                      ),
                      child: CustomPaint(
                        painter: BulletLinePainter(_getPath2(), widget.color),
                      ),
                    );
                  },
                ),
              ),
              AnimatedBuilder(
                animation: _animation,
                builder: (BuildContext context, Widget? child) {
                  if (_oldSelectedIndex == _selectedIndex) {
                    return const SizedBox();
                  }
                  final path = _getPath2();
                  return Positioned(
                    top: calculate(path).dy - 3,
                    left: calculate(path).dx +
                        (_oldSelectedIndex < _selectedIndex ? 13 : -17),
                    child: Opacity(
                      opacity: _getAnimationValue() * 1.5 >= 0.9 ? 0 : 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: widget.circle2Color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 5,
                        height: 5,
                      ),
                    ),
                  );
                },
              ),
              // Bottom bar icons
              Row(children: _iconsWidget()),
            ],
          ),
        ),
        // Add FAB in the center
        Positioned.fill(
          child: Align(
            alignment: Alignment.topCenter,
            child: Transform.rotate(
              angle: -math.pi / 4,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            duration: const Duration(milliseconds: 350),
                            reverseDuration: const Duration(milliseconds: 350),
                            childCurrent: const HomePage(),
                            type: PageTransitionType.scale,
                            fullscreenDialog: true,
                            alignment: Alignment.bottomCenter,
                            child: NewEntryPage()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: kSecondaryColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 25,
                          offset: const Offset(0, 5),
                          color: widget.color.withOpacity(0.75),
                        ),
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(18)),
                      // gradient: LinearGradient(
                      //   begin: Alignment.topCenter,
                      //   end: Alignment.bottomCenter,
                      //   colors: [
                      //     widget.circle1Color,
                      //     widget.circle2Color,
                      //   ],
                      // ),
                    ),
                    height: 60,
                    width: 60,
                    child: Center(
                      child: Transform.rotate(
                        angle: math.pi / 4,
                        child: const Icon(
                          Icons.add,
                          size: 32.5,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _iconsWidget() {
    List<Widget> iconWidgets = [];

    widget.items.asMap().forEach((index, item) {
      iconWidgets.add(Expanded(
        child: InkWell(
          onTap: () => _onChangeIndex(index),
          child: IgnorePointer(
            child: BottomBarDoubleBulletIcon(
              key: iconsKey[index],
              isSelected: _selectedIndex == index,
              item: item,
              color: widget.color,
            ),
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

    _oldSelectedIndex = _selectedIndex;
    iconsKey[_oldSelectedIndex]
        .currentState
        ?.updateSelect(false, _oldSelectedIndex < _selectedIndex);
    // await Future.delayed(const Duration(milliseconds: 200));

    if (_animationController.status == AnimationStatus.completed) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }

    setState(() {
      _selectedIndex = index;
    });

    await Future.delayed(const Duration(milliseconds: 200));
    iconsKey[_selectedIndex]
        .currentState
        ?.updateSelect(true, _oldSelectedIndex < _selectedIndex);

    widget.onSelect?.call(_selectedIndex);
  }

  double _getAnimationValue() {
    final value = _animation.value!;

    if (_animation.status == AnimationStatus.dismissed) {
      return 1;
    }
    return _animation.status == AnimationStatus.reverse ? 1 - value : value;
  }

  Offset _getStartOffset() {
    double screenWidth = MediaQuery.of(context).size.width;
    final iconWidth = screenWidth / _iconCount;

    return Offset(
        (_oldSelectedIndex * iconWidth) + (iconWidth / 2), widget.height / 2);
  }

  Offset _getEndOffset() {
    double screenWidth = MediaQuery.of(context).size.width;
    final iconWidth = screenWidth / _iconCount;

    return Offset(
        (_selectedIndex * iconWidth) + (iconWidth / 2), widget.height / 2);
  }

  Path _getPath1() {
    final isReverse = _oldSelectedIndex > _selectedIndex;

    final startOffSet = _getStartOffset();
    final endOffSet = _getEndOffset();

    final width = (startOffSet.dx - endOffSet.dx).abs();

    double sx, sy, p1x, p1y, p2x, p2y, ex, ey;
    if (!isReverse) {
      sx = startOffSet.dx;
      sy = widget.height / 4 * 1.5;

      p1x = startOffSet.dx + width / 4;
      p1y = widget.height / 4 * 0.5;

      p2x = startOffSet.dx + 3 * width / 4;
      p2y = widget.height / 4 * 3.5;

      ex = endOffSet.dx;
      ey = widget.height / 4 * 2.5;
    } else {
      sx = startOffSet.dx;
      sy = widget.height / 4 * 2.5;

      p1x = endOffSet.dx + 3 * width / 4;
      p1y = widget.height / 4 * 3.5;

      p2x = endOffSet.dx + width / 4;
      p2y = widget.height / 4 * 0.5;

      ex = endOffSet.dx;
      ey = widget.height / 4 * 1.5;
    }

    Path path = Path();
    path.moveTo(sx, sy);

    path.cubicTo(p1x, p1y, p2x, p2y, ex, ey);
    return path;
  }

  Path _getPath2() {
    final isReverse = _oldSelectedIndex > _selectedIndex;

    final startOffSet = _getStartOffset();
    final endOffSet = _getEndOffset();

    final width = (startOffSet.dx - endOffSet.dx).abs();

    double sx, sy, p1x, p1y, p2x, p2y, ex, ey;
    if (!isReverse) {
      sx = startOffSet.dx;
      sy = widget.height / 4 * 2.5;

      p1x = startOffSet.dx + width / 4;
      p1y = widget.height / 4 * 3.5;

      p2x = startOffSet.dx + 3 * width / 4;
      p2y = widget.height / 4 * 0.5;

      ex = endOffSet.dx;
      ey = widget.height / 4 * 1.5;
    } else {
      sx = startOffSet.dx;
      sy = widget.height / 4 * 1.5;

      p1x = endOffSet.dx + 3 * width / 4;
      p1y = widget.height / 4 * 0.5;

      p2x = endOffSet.dx + width / 4;
      p2y = widget.height / 4 * 3.5;

      ex = endOffSet.dx;
      ey = widget.height / 4 * 2.5;
    }

    Path path = Path();
    path.moveTo(sx, sy);

    path.cubicTo(p1x, p1y, p2x, p2y, ex, ey);
    return path;
  }

  Offset calculate(Path path) {
    var value = _getAnimationValue() * 1.5;
    PathMetrics pathMetrics = path.computeMetrics();
    PathMetric pathMetric = pathMetrics.elementAt(0);
    value = pathMetric.length * value;
    Tangent pos = pathMetric.getTangentForOffset(value)!;
    return pos.position;
  }
}

class BulletLinePainter extends CustomPainter {
  final Path path;
  final Color color;

  BulletLinePainter(this.path, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
        path,
        Paint()
          ..color = color
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5);
  }

  @override
  bool shouldRepaint(BulletLinePainter oldDelegate) {
    return oldDelegate.path != path;
  }
}

class BottomBarDoubleBulletClipper extends CustomClipper<Path> {
  final double progress;
  final double startX;
  final double endX;
  final bool isReverse;

  BottomBarDoubleBulletClipper(
    this.progress,
    this.startX,
    this.endX,
    this.isReverse,
  );

  @override
  Path getClip(Size size) {
    final value = progress;

    final width = (endX - startX).abs();

    final path = Path();
    if (!isReverse) {
      path.moveTo(startX + width * value * 1.5 - 30, 0.0);
      path.lineTo(startX + width * value * 1.5 + 10, 0.0);
      path.lineTo(startX + width * value * 1.5 + 10, size.height);
      path.lineTo(startX + width * value * 1.5 - 30, size.height);
    } else {
      path.moveTo(startX - width * value * 1.5 + 30, 0.0);
      path.lineTo(startX - width * value * 1.5 - 10, 0.0);
      path.lineTo(startX - width * value * 1.5 - 10, size.height);
      path.lineTo(startX - width * value * 1.5 + 30, size.height);
    }

    path.close();
    return path;
  }

  @override
  bool shouldReclip(BottomBarDoubleBulletClipper oldClipper) {
    return oldClipper.progress != progress;
  }
}
