import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/main_controller.dart';

class SetupName extends StatefulWidget {
  const SetupName({super.key});
  @override
  _SetupNameState createState() => _SetupNameState();
}

class _SetupNameState extends State<SetupName> {
  final Duration _animationSpeed = const Duration(milliseconds: 666);
  double _opacity = 0.0;
  EdgeInsets _padding = const EdgeInsets.only(top: 33);

  @override
  void initState() {
    super.initState();
    animationController();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      padding: _padding,
      duration: _animationSpeed,
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: _animationSpeed,
        child: Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 10,
          ),
          width: MediaQuery.of(context).size.width - 80,
          height: 80,
          decoration: BoxDecoration(
            color: kSecondaryColor,
            borderRadius: BorderRadius.circular(17.5),
            boxShadow: [
              BoxShadow(
                color: kSecondaryColor.withOpacity(0.45),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: TextField(
              textAlign: TextAlign.center,
              maxLength: 25,
              cursorColor: kWhiteColor,
              style: GoogleFonts.ubuntu(
                color: kWhiteColor,
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
              cursorHeight: 35,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                counterText: '',
                hintStyle:
                    GoogleFonts.ubuntu(color: kWhiteColor, fontSize: 21.0),
                hintText: "Your nickname...",
              ),
              onChanged: (value) {
                Get.find<MainController>().updateMainStete(newUserName: value);
              },
              onTap: () {}),
        ),
      ),
    );
  }

  animationController() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    setState(() {
      _opacity = 1.0;
      _padding = EdgeInsets.zero;
    });
  }
}
