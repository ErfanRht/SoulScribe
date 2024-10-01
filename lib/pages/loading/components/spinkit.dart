import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:soulscribe/pages/loading/animations.dart';

class LoadingSpinkit extends StatelessWidget {
  const LoadingSpinkit({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoadingAnimationsController>(
      builder: (_) {
        return AnimatedOpacity(
          opacity: _.spinkitOpacity,
          duration: const Duration(milliseconds: 666),
          child: const SpinKitSquareCircle(
            color: Colors.white,
            size: 60,
          ),
        );
      },
    );
  }
}
