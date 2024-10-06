import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/pages/loading/animations.dart';
import 'package:soulscribe/widgets/copyright.dart';

class LoadingLogo extends StatelessWidget {
  const LoadingLogo({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoadingAnimationsController>(builder: (_) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedOpacity(
            opacity: _.logoOpacity,
            duration: _.animationSpeed,
            child: AnimatedPadding(
                duration: _.animationSpeed,
                padding: _.logoTextpadding,
                child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                        color: kWhiteColor,
                        borderRadius: BorderRadius.circular(35)),
                    child: Image.asset('assets/images/logo.png'))),
          ),
          const SizedBox(
            height: 35,
          ),
          AnimatedOpacity(
            opacity: _.textOpacity,
            duration: _.animationSpeed,
            child: Text(
              "SoulScript",
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(
                  color: kWhiteColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 45),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          AnimatedOpacity(
            opacity: _.textOpacity,
            duration: _.animationSpeed,
            child: Text(
              "Capture Your Journey, Visualize Your Emotions",
              style: GoogleFonts.ubuntu(
                  color: kWhiteColor,
                  fontWeight: FontWeight.w900,
                  fontSize: 10),
            ),
          ),
        ],
      );
    });
  }
}
