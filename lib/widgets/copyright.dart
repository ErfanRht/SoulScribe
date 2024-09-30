import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CopyRightWidget extends StatelessWidget {
  const CopyRightWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Copyright ©2024 All rights reserved',
                style: GoogleFonts.rubik(
                    color: Colors.grey,
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700),
              ),
              Row(
                children: [
                  Text(
                    'This site is developed by ',
                    style: GoogleFonts.rubik(
                        color: Colors.grey,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700),
                  ),
                  InkWell(
                    onTap: () {
                      // html.window.open('https://ErfanRht.GitHub.io', '_blank');
                    },
                    child: Text(
                      ' Erfan Rahmati ',
                      style: GoogleFonts.rubik(
                          color: const Color(0xffE11A38),
                          fontSize: 13.0,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
