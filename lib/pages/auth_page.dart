import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:local_auth/local_auth.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/constants/routes.dart';
import 'package:soulscribe/models/biometrics.dart';

class BiometricAuthScreen extends StatelessWidget {
  final LocalAuthentication auth = LocalAuthentication();

  BiometricAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    authIt(context);
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: GestureDetector(
        onTap: () {
          authIt(context);
        },
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff662D8C), Color(0xffED1E79)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Stack(
                children: [
                  const SpinKitDoubleBounce(
                    color: kWhiteColor,
                    size: 400,
                    duration: Duration(milliseconds: 4000),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: kWhiteColor, shape: BoxShape.circle),
                      margin: EdgeInsets.symmetric(
                          horizontal:
                              (MediaQuery.of(context).size.width / 2) - 75),
                      padding: const EdgeInsets.all(7.5),
                      child: const Icon(
                        Icons.fingerprint_rounded,
                        color: kSecondaryColor,
                        size: 100,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Text(
                  "Please authenticate to access SoulScribe",
                  style: GoogleFonts.ubuntu(
                      color: kWhiteColor,
                      fontSize: 17.5,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  authIt(BuildContext context) async {
    final bool didAuthenticate = await auth.authenticate(
        localizedReason: 'Please authenticate to access SoulScribe');
    if (didAuthenticate) {
      authenticateWithBiometricsStatus(status: true);
      Navigator.pushReplacementNamed(context, home_route);
    }
  }
}
