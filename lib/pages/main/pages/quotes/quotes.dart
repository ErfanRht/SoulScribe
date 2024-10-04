import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/widgets/circles_background/main_circles_background.dart';

class QuotesPage extends StatelessWidget {
  const QuotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MainCirclesBackground(
          backgroundColor: kPrimaryColor,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 17.5),
            child: Text(
              "Quotes",
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
