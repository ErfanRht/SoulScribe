import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/pages/login/animations.dart';

class MainCirclesBackground extends StatefulWidget {
  final Widget child;
  final Color backgroundColor;

  const MainCirclesBackground({
    super.key,
    required this.child,
    required this.backgroundColor,
  });

  @override
  State<MainCirclesBackground> createState() => _MainCirclesBackgroundState();
}

class _MainCirclesBackgroundState extends State<MainCirclesBackground> {
  double opacity = 0.0;
  double position = -1000;
  @override
  void initState() {
    super.initState();
    loadAnimations();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      top: position,
      right: -300,
      left: -300,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: opacity,
        child: Container(
          width: 1000,
          height: 1000,
          decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(500),
              boxShadow: [
                BoxShadow(
                  color: widget.backgroundColor.withOpacity(0.3),
                  spreadRadius: 5,
                  blurRadius: 5,
                ),
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [widget.child],
          ),
        ),
      ),
    );
  }

  loadAnimations() async {
    await Future.delayed(const Duration(milliseconds: 200));
    setState(() {
      position = -900;
      opacity = 1;
    });
  }
}
