import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/pages/login/login.dart';
import 'package:soulscribe/pages/user_setup/user_setup.dart';
import 'package:soulscribe/widgets/page_transition/src/enum.dart';
import 'package:soulscribe/widgets/page_transition/src/page_transition.dart';
import 'login_button.dart';

void sorryAlert(BuildContext context) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5), // Background color
    transitionDuration: const Duration(milliseconds: 200), // Faster animation
    pageBuilder: (_, __, ___) {
      return Center(
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Sorry",
                    style: GoogleFonts.ubuntu(
                        fontSize: 25,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Currently, you can only continue as a guest.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ubuntu(
                        color: kPrimaryColor, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  LoginButton(
                    image: const SizedBox(),
                    text: "Continue as a guest",
                    textColor: kWhiteColor,
                    outsideColor: kPrimaryColor,
                    insideColor: kPrimaryColor,
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              duration: const Duration(milliseconds: 150),
                              childCurrent: const LoginScreen(),
                              type: PageTransitionType.fade,
                              child: const SetupScreen()));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (_, anim, __, child) {
      return ScaleTransition(
        scale: Tween<double>(
          begin: 0.7, // Start smaller
          end: 1.0, // Grow to full size
        ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOut)),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  );
}
