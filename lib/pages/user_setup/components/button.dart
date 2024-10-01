import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/widgets/rounded_loading_button.dart';

class SetupButton extends StatefulWidget {
  const SetupButton({super.key});
  @override
  _SetupButtonState createState() => _SetupButtonState();
}

class _SetupButtonState extends State<SetupButton> {
  final Duration _animationSpeed = const Duration(milliseconds: 500);
  double _opacity = 0.0;

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  void _setName() async {
    // await setUserName(userName: Get.find<MainController>().userName)
    //     .then((value) {
    //   if (value) {
    //     Timer(Duration(seconds: 2), () {
    //       _btnController.success();
    //       Timer(Duration(milliseconds: 1500), () {
    //         Navigator.pushReplacementNamed(context, home_route);
    //       });
    //     });
    //   } else {
    //     Timer(Duration(seconds: 2), () {
    //       _btnController.error();
    //       Timer(Duration(seconds: 2), () {
    //         _btnController.reset();
    //       });
    //     });
    //   }
    // });
  }

  @override
  void initState() {
    super.initState();
    animationController();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: _animationSpeed,
      child: RoundedLoadingButton(
        height: 55,
        color: kPrimaryColor,
        successColor: Colors.greenAccent,
        errorColor: Colors.redAccent,
        controller: _btnController,
        onPressed: _setName,
        valueColor: Colors.white,
        child: Text('continue',
            style: GoogleFonts.ubuntu(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700)),
      ),
    );
  }

  animationController() async {
    await Future.delayed(const Duration(milliseconds: 6500));
    setState(() {
      _opacity = 1.0;
    });
  }
}
