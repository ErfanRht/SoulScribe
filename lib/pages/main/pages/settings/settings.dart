import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:local_auth/local_auth.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/main_controller.dart';
import 'package:soulscribe/models/biometrics.dart';
import 'package:soulscribe/models/entries.dart';
import 'package:soulscribe/pages/main/main_page.dart';
import 'package:soulscribe/pages/main/pages/settings/components/settings_item.dart';
import 'package:soulscribe/widgets/circles_background/main_circles_background.dart';

import 'components/user-box/user-box.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool authenticate = false;
  @override
  void initState() {
    super.initState();
    getAuthDefaultValue();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (_) {
      return Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 120, horizontal: 15),
              child: Column(
                children: [
                  const SettingsPageUserBox(),
                  const SizedBox(
                    height: 25,
                  ),
                  SettingsItem(
                    title: "BIOMETRIC PASSCODE",
                    icon: Icon(
                      FontAwesomeIcons.fingerprint,
                      color: kPrimaryColor.withOpacity(0.25),
                      size: 150,
                    ),
                    key: ValueKey(authenticate),
                    defaultValue: authenticate,
                    onIcon: IconlyBold.lock,
                    offIcon: IconlyBold.unlock,
                    onTapOn: () async {
                      if (await doesDeviceSupportBiometrics()) {
                        final LocalAuthentication auth = LocalAuthentication();
                        final bool didAuthenticate = await auth.authenticate(
                            localizedReason:
                                'Please authenticate to access SoulScript');
                        if (didAuthenticate) {
                          authenticateWithBiometricsStatus(status: true);
                        }
                        return didAuthenticate;
                      } else {
                        return false;
                      }
                    },
                    onTapOff: () {
                      authenticateWithBiometricsStatus(status: false);
                      return true;
                    },
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
                    onTapOn: () {},
                    onTapOff: () {},
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SettingsItem(
                    title: "SAMPLE RAW ENTRIES",
                    icon: Icon(
                      IconlyBold.wallet,
                      color: kPrimaryColor.withOpacity(0.25),
                      size: 150,
                    ),
                    onIcon: IconlyBold.download,
                    offIcon: IconlyBold.paper_fail,
                    defaultValue: _.isSamplesEnabled,
                    onTapOn: () async {
                      bool? result;
                      result = await _showRawDataAlertDialog(context, true);

                      return result;
                    },
                    onTapOff: () async {
                      bool? result;
                      result = await _showRawDataAlertDialog(context, false);
                      return result;
                    },
                  )
                ],
              ),
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
    });
  }

  Future<bool?> _showRawDataAlertDialog(
      BuildContext context, bool isEnabling) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            isEnabling ? "Enable Sample Data" : "Disable Sample Data",
            style: GoogleFonts.ubuntu(
              fontWeight: FontWeight.bold,
              color:
                  isEnabling ? Colors.teal.withOpacity(0.9) : kSecondaryColor,
            ),
          ),
          content: Text(
            isEnabling
                ? "Enabling this option will add sample raw journal entries to your data. Do you want to proceed?"
                : "Disabling this option will remove all sample entries that haven't been modified. Do you want to proceed?",
            style: GoogleFonts.ubuntu(
                fontWeight: FontWeight.bold, color: kPrimaryColor),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Return false if cancelled
              },
              child: Text(
                "Cancel",
                style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.bold,
                  color: isEnabling
                      ? kSecondaryColor
                      : Colors.teal.withOpacity(0.9),
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                isEnabling ? {enableSampleEntries()} : {disableSampleEntries()};
                checkSamples();
                Navigator.of(context).pop(true);
                !isEnabling ? settingsPageBugFixer() : null;
              },
              child: Text(
                isEnabling ? "Enable" : "Disable",
                style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.bold,
                  color: isEnabling
                      ? Colors.teal.withOpacity(0.9)
                      : kSecondaryColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  getAuthDefaultValue() async {
    bool auth = await authenticateWithBiometricsStatus();
    setState(() {
      authenticate = auth;
    });
  }
}

settingsPageBugFixer() async {
  await MainPage.pageController.animateToPage(3,
      duration: const Duration(milliseconds: 5), curve: Curves.easeIn);
  await MainPage.pageController.animateToPage(4,
      duration: const Duration(milliseconds: 5), curve: Curves.easeIn);
}
