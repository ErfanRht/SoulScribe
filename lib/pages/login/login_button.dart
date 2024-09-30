import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';

class LoginButton extends StatelessWidget {
  final Color insideColor;
  final Color outsideColor;
  final Color textColor;
  final String text;
  final Widget image;
  const LoginButton(
      {super.key,
      required this.image,
      required this.insideColor,
      required this.outsideColor,
      required this.text,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {},
        child: Container(
          width: MediaQuery.of(context).size.width - 75,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: insideColor,
            border: Border.all(
              color: outsideColor,
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image,
              Text(
                text,
                style: GoogleFonts.ubuntu(
                    textStyle: TextStyle(
                        color: textColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
