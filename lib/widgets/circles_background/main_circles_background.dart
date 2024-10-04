import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/pages/login/animations.dart';

class MainCirclesBackground extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;

  const MainCirclesBackground({
    super.key,
    required this.child,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: MediaQuery.of(context).size.height - 200,
      right: -300,
      left: -300,
      child: Container(
        width: 1000,
        height: 1000,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(500),
            boxShadow: [
              BoxShadow(
                color: backgroundColor.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 5,
              ),
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [child],
        ),
      ),
    );
  }
}
