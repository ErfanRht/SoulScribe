import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoadingAnimationsController extends GetxController {
  double logoOpacity = 0, textOpacity = 0, spinkitOpacity = 0;
  EdgeInsets logoTextpadding = const EdgeInsets.only(top: 33);
  Duration animationSpeed = const Duration(milliseconds: 666);
  Duration allAnimationTimes = const Duration(milliseconds: 6000);

  updateLoadingAnimations(
      {double? newLogoOpacity,
      double? newTextOpacity,
      double? newSpinkitOpacity,
      EdgeInsets? newLogoTextPadding}) {
    logoOpacity = newLogoOpacity ?? logoOpacity;
    textOpacity = newTextOpacity ?? textOpacity;
    spinkitOpacity = newSpinkitOpacity ?? spinkitOpacity;
    logoTextpadding = newLogoTextPadding ?? logoTextpadding;

    update();
  }
}

startLoadingAnimations() async {
  await Future.delayed(const Duration(milliseconds: 500));
  Get.find<LoadingAnimationsController>().updateLoadingAnimations(
      newLogoOpacity: 1, newLogoTextPadding: EdgeInsets.zero);
  await Future.delayed(const Duration(milliseconds: 100));
  Get.find<LoadingAnimationsController>()
      .updateLoadingAnimations(newTextOpacity: 1);
  await Future.delayed(const Duration(milliseconds: 250));
  Get.find<LoadingAnimationsController>()
      .updateLoadingAnimations(newSpinkitOpacity: 1);
  await Future.delayed(const Duration(milliseconds: 3850));
  Get.find<LoadingAnimationsController>().updateLoadingAnimations(
      newLogoOpacity: 0,
      newTextOpacity: 0,
      newSpinkitOpacity: 0,
      newLogoTextPadding: const EdgeInsets.only(top: 33));
}
