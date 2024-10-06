import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';

class NewEntryMoodPicker extends StatelessWidget {
  const NewEntryMoodPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17.5),
          color: const Color(0xffFFD700)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            FontAwesomeIcons.solidFaceSmile,
            size: 22.5,
            color: kWhiteColor,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "Mood",
            style: GoogleFonts.ubuntu(
                color: kWhiteColor,
                fontWeight: FontWeight.bold,
                fontSize: 17.5),
          )
        ],
      ),
    );
  }
}
