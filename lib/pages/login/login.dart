import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/pages/login/login_button.dart';
import 'package:soulscribe/widgets/copyright.dart';
import 'components/circles_background.dart';
import 'components/main_text_field.dart';
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

  String _username = '';
  final bool _loading = false;

  @override
  void dispose() {
    super.dispose();

    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final node = FocusScope.of(context);

    return Scaffold(
      body: CirclesBackground(
        backgroundColor: Colors.white,
        topMediumCircleColor: const Color(0xffED1E79),
        topSmallCircleColor: const Color(0xffED1E79),
        topRightCircleColor: const Color(0xff3450A1),
        bottomRightCircleColor: Colors.white,
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
                            'Welcome To SoulScript',
                            style: GoogleFonts.ubuntu(
                              textStyle: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 200,
                        ),
                        const LoginButton(
                          text: "Continue with email",
                          textColor: Colors.white,
                          outsideColor: kSecondaryColor,
                          insideColor: kSecondaryColor,
                          image: SizedBox(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        LoginButton(
                            image: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Image.asset("assets/images/google.png"),
                            ),
                            text: "Continue with Google",
                            textColor: kPrimaryColor,
                            outsideColor: kPrimaryColor,
                            insideColor: Colors.white),
                        const SizedBox(
                          height: 20,
                        ),
                        LoginButton(
                            image: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Image.asset(
                                "assets/images/apple.png",
                              ),
                            ),
                            text: "Continue with Apple",
                            textColor: kPrimaryColor,
                            outsideColor: kPrimaryColor,
                            insideColor: Colors.white),
                        const SizedBox(
                          height: 20,
                        ),
                        const LoginButton(
                            image: SizedBox(),
                            text: "Continue as a guest",
                            textColor: Colors.white,
                            outsideColor: kPrimaryColor,
                            insideColor: kPrimaryColor),
                        const SizedBox(
                          height: 150,
                        ),
                        const CopyRightWidget(),
                        // _form(node, context),
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
  }

  Widget _form(FocusScopeNode node, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTextField(
          label: 'Username',
          usernameField: true,
          onChanged: (value) => setState(() {
            _username = value;
          }),
          onEditingComplete: () => node.nextFocus(),
        ),
        const SizedBox(
          height: 20,
        ),
        MainTextField(
          label: 'Password',
          controller: _passwordController,
          passwordField: true,
          onSubmitted: (_) {
            node.unfocus();
          },
        ),
        const SizedBox(
          height: 20,
        ),
        const Row(
          children: [
            Text(
              'Sign In',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
