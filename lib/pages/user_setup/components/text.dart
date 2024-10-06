import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';

class SetupText extends StatefulWidget {
  const SetupText({super.key});
  @override
  _SetupTextState createState() => _SetupTextState();
}

class _SetupTextState extends State<SetupText> {
  final Duration _animationSpeed = const Duration(milliseconds: 750);
  double _opacity = 0.0, _opacity2 = 0.0, _opacity3 = 0.0;
  EdgeInsets _padding = const EdgeInsets.only(top: 15),
      _padding2 = const EdgeInsets.only(top: 15);

  @override
  void initState() {
    super.initState();
    animationController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedOpacity(
            opacity: _opacity,
            duration: _animationSpeed,
            child: AnimatedPadding(
              duration: _animationSpeed,
              padding: _padding,
              child: Text("Hi!",
                  style: GoogleFonts.ubuntu(
                      color: kWhiteColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 50)),
            )),
        const SizedBox(
          height: 15,
        ),
        AnimatedOpacity(
            opacity: _opacity3,
            duration: _animationSpeed,
            child: AnimatedPadding(
              duration: _animationSpeed,
              padding: _padding2,
              child: Text("It's so nice to meet you here!",
                  style: GoogleFonts.ubuntu(
                      color: kWhiteColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 22.5)),
            )),
        const SizedBox(
          height: 15,
        ),
        Center(
            child: AnimatedOpacity(
          opacity: _opacity2,
          duration: _animationSpeed,
          child: Text("What do your friends call you?",
              style: GoogleFonts.ubuntu(
                  color: kWhiteColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 22.5)),
        )),
      ],
    );
  }

  animationController() async {
    await Future.delayed(const Duration(milliseconds: 150));
    setState(() {
      _opacity = 1.0;
      _padding = EdgeInsets.zero;
    });
    await Future.delayed(const Duration(milliseconds: 550));
    setState(() {
      _opacity3 = 1.0;
      _padding2 = EdgeInsets.zero;
    });
    await Future.delayed(const Duration(milliseconds: 1250));
    setState(() {
      _opacity2 = 1.0;
    });
  }
}
