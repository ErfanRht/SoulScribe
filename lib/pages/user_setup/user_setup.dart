import 'package:flutter/material.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/widgets/circles_background/intro_circles_background.dart';
import 'components/button.dart';
import 'components/name.dart';
import 'components/text.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: IntroCirclesBackground(
      backgroundColor: Colors.white,
      topMediumCircleColor: kSecondaryColor,
      topRightCircleColor: kPrimaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 25),
            child: Center(child: SetupText()),
          ),
          SizedBox(
            height: 150,
          ),
          Center(
            child: SetupName(),
          ),
          SizedBox(
            height: 150,
          ),
          SetupButton(),
          SizedBox(),
          SizedBox(),
        ],
      ),
    ));
  }
}
