import 'package:get/get.dart';

class LoginPageAnimationsController extends GetxController {
  double bigCirclePositionWidth = 184;
  double bigCirclePositionHeight = -500;
  double smallCirclePositionWidth = 235;
  double smallCirclePositionHeight = -500;
  double circleOpacity = 0;

  updateAnimations(
      {double? newBigCirclePositionWidth,
      double? newBigCirclePositionHeight,
      double? newSmallCirclePositionWidth,
      double? newSmallCirclePositionHeight,
      double? newCircleOpacity}) {
    bigCirclePositionWidth =
        newBigCirclePositionWidth ?? bigCirclePositionWidth;
    bigCirclePositionHeight =
        newBigCirclePositionHeight ?? bigCirclePositionHeight;
    smallCirclePositionWidth =
        newSmallCirclePositionWidth ?? smallCirclePositionWidth;
    smallCirclePositionHeight =
        newSmallCirclePositionHeight ?? smallCirclePositionHeight;
    circleOpacity = newCircleOpacity ?? circleOpacity;
    update();
  }
}

startAnimations() async {
  await Future.delayed(const Duration(milliseconds: 5));
  Get.find<LoginPageAnimationsController>().updateAnimations(
      newSmallCirclePositionHeight: -16, newSmallCirclePositionWidth: 235);
  Get.find<LoginPageAnimationsController>().updateAnimations(
      newBigCirclePositionHeight: -412, newBigCirclePositionWidth: -184);
  Get.find<LoginPageAnimationsController>()
      .updateAnimations(newCircleOpacity: 1.0);
}
