import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/pages/main/pages/settings/components/settings_item.dart';
import 'package:soulscribe/widgets/circles_background/main_circles_background.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 130, horizontal: 15),
          child: Column(
            children: [
              SettingsItem(
                title: "BIOMETRIC PASSCODE",
                icon: Icon(
                  FontAwesomeIcons.fingerprint,
                  color: kPrimaryColor.withOpacity(0.25),
                  size: 150,
                ),
                onIcon: IconlyBold.lock,
                doesItWork: false,
                offIcon: IconlyBold.unlock,
              ),
              const SizedBox(
                height: 25,
              ),
              SettingsItem(
                title: "PIN PASSCODE",
                icon: Icon(
                  IconlyBold.bag,
                  color: kPrimaryColor.withOpacity(0.25),
                  size: 150,
                ),
                onIcon: IconlyBold.lock,
                doesItWork: false,
                offIcon: IconlyBold.unlock,
              ),
              const SizedBox(
                height: 25,
              ),
              SettingsItem(
                title: "DARK MODE",
                icon: Icon(
                  FontAwesomeIcons.cloudMoon,
                  color: kPrimaryColor.withOpacity(0.25),
                  size: 150,
                ),
                doesItWork: false,
                onIcon: Icons.nightlight_round,
                offIcon: Icons.sunny,
              )
            ],
          ),
        ),
        MainCirclesBackground(
          backgroundColor: kSecondaryColor,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 17.5),
            child: Text(
              "Settings",
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(
                  color: kWhiteColor,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
