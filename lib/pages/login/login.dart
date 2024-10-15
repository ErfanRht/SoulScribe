// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/pages/login/animations.dart';
import 'package:soulscribe/pages/login/components/login_button.dart';
import 'package:soulscribe/pages/login/components/sorry_alert.dart';
import 'package:soulscribe/pages/user_setup/user_setup.dart';
import 'package:soulscribe/widgets/copyright.dart';
import 'package:soulscribe/widgets/page_transition/src/enum.dart';
import 'package:soulscribe/widgets/page_transition/src/page_transition.dart';
import '../../widgets/circles_background/intro_circles_background.dart';
import 'components/scrollable_form.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';

  static route() => MaterialPageRoute(builder: (_) => const LoginScreen());

  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _passwordController = TextEditingController();

  final String _username = '';
  final bool _loading = false;

  @override
  void dispose() {
    super.dispose();

    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    LoginPageAnimationsController loginPageAnimationsController =
        Get.put(LoginPageAnimationsController());
    startAnimations();
    return GetBuilder<LoginPageAnimationsController>(builder: (_) {
      return Scaffold(
        body: IntroCirclesBackground(
          backgroundColor: kWhiteColor,
          topMediumCircleColor: kSecondaryColor,
          topRightCircleColor: kPrimaryColor,
          child: Stack(
            children: [
              Column(
                children: [
                  ScrollableForm(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    children: [
                      const SizedBox(
                        height: 75,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 250),
                            child: Text(
                              'Welcome To SoulScribe',
                              style: GoogleFonts.ubuntu(
                                textStyle: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: kWhiteColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 200,
                          ),
                          LoginButton(
                            text: "Continue with email",
                            textColor: kWhiteColor,
                            outsideColor: kSecondaryColor,
                            insideColor: kSecondaryColor,
                            image: const SizedBox(),
                            onTap: () {
                              sorryAlert(context);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          LoginButton(
                            image: const Padding(
                                padding: EdgeInsets.only(right: 10, left: 12.5),
                                child: Icon(
                                  FontAwesomeIcons.google,
                                  color: kPrimaryColor,
                                )),
                            text: "Continue with Google",
                            textColor: kPrimaryColor,
                            outsideColor: kPrimaryColor,
                            insideColor: kWhiteColor,
                            onTap: () {
                              sorryAlert(context);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          LoginButton(
                            image: const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Icon(
                                  FontAwesomeIcons.apple,
                                  color: kPrimaryColor,
                                  size: 30,
                                )),
                            text: "Continue with Apple",
                            textColor: kPrimaryColor,
                            outsideColor: kPrimaryColor,
                            insideColor: kWhiteColor,
                            onTap: () {
                              sorryAlert(context);
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
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
                                      duration:
                                          const Duration(milliseconds: 150),
                                      childCurrent: const LoginScreen(),
                                      type: PageTransitionType.fade,
                                      child: const SetupScreen()));
                            },
                          ),
                          const SizedBox(
                            height: 150,
                          ),
                          const CopyRightWidget(
                            color: Colors.grey,
                            nameColor: kSecondaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
