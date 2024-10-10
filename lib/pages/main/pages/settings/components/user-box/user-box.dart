import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:soulscribe/constants/colors.dart';
import 'user-email.dart';
import 'user-name.dart';
import 'user_profile_image.dart';

class SettingsPageUserBox extends StatefulWidget {
  const SettingsPageUserBox({super.key});

  @override
  State<SettingsPageUserBox> createState() => _SettingsPageUserBoxState();
}

class _SettingsPageUserBoxState extends State<SettingsPageUserBox> {
  double opacity = 0;
  double padding = 15;
  @override
  void initState() {
    super.initState();
    loadAnimations();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: const Duration(milliseconds: 500),
      child: Stack(
        children: [
          Container(
            height: 175,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(top: 75, bottom: 17.5),
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                    color: kPrimaryColor.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 12.5,
                    offset: const Offset(0, 15)),
              ],
            ),
            child: const Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                UserBoxUserName(),
                UserBoxUserEmail(),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 500),
              padding: EdgeInsets.only(top: padding),
              child:
                  userProfileImage(context, icon: IconlyBold.edit, onTap: () {
                // Navigator.push(
                //     context, const ProfilePageEditUserProfile());
              }),
            ),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: AnimatedPadding(
                duration: const Duration(milliseconds: 500),
                padding: EdgeInsets.only(bottom: padding),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: kSecondaryColor),
                  margin: const EdgeInsets.symmetric(horizontal: 85),
                  height: 45,
                  child: Center(
                    child: Text(
                      "Activity Chart",
                      style: GoogleFonts.ubuntu(
                          fontSize: 17.5,
                          fontWeight: FontWeight.bold,
                          color: kWhiteColor),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  loadAnimations() async {
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      opacity = 1;
      padding = 0;
    });
  }
}
