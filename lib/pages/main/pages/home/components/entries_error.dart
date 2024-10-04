import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:soulscribe/constants/colors.dart';

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
        Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: UnDraw(
            height: MediaQuery.of(context).size.width - 100,
            color: kSecondaryColor,
            illustration: UnDrawIllustration.tree_swing,
            placeholder: const Padding(
              padding: EdgeInsets.only(top: 100),
              child: SpinKitDoubleBounce(
                color: kSecondaryColor,
                size: 75,
              ),
            ),
            errorWidget:
                const Icon(Icons.error_outline, color: Colors.red, size: 50),
          ),
        ),
      ],
    ));
  }
}
