import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/widgets/illustration_loader.dart';

class HomePageEntriesError extends StatelessWidget {
  const HomePageEntriesError({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 100,
        ),
        Text(
          "No journal entries added yet!",
          style: GoogleFonts.ubuntu(
              color: kSecondaryColor,
              fontSize: 22.2,
              fontWeight: FontWeight.w700),
        ),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 32.5),
            child: const IllustrationLoader(
                address: "assets/illustrations/undraw_tree_swing_re_pqee.svg")),
      ],
    ));
  }
}
