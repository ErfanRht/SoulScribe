import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ms_undraw/ms_undraw.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/pages/home/home.dart';
import 'package:soulscribe/pages/login/login.dart';
import 'transition/concentric_transition.dart';

final pages = [
  PageData(
      icon: Icons.bubble_chart,
      title: "Capture Your Journey",
      description:
          "Track your daily thoughts, emotions, and experiences in one place. SoulScribe makes journaling simple and meaningful.",
      bgColor: const LinearGradient(
        colors: [Color(0xff662D8C), Color(0xffED1E79)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      textColor: Colors.white,
      child: Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(35)),
          child: Image.asset('assets/images/logo.png'))),
  PageData(
      icon: Icons.format_size,
      title: "Visualize Your Emotions",
      description:
          "Easily track your mood with insightful charts and trends. See how your feelings evolve over time and gain self-awareness.",
      textColor: Colors.black,
      child: UnDraw(
        color: const Color(0xffED1E79),
        width: 225,
        height: 225,
        illustration: UnDrawIllustration.feeling_blue,
        placeholder: const Text(
            "Illustration is loading..."), //optional, default is the CircularProgressIndicator().
        errorWidget: const Icon(Icons.error_outline,
            color: Colors.red,
            size:
                100), //optional, default is the Text('Could not load illustration!').
      )),
  PageData(
      icon: Icons.hdr_weak,
      title: "Look Back and Reflect",
      description:
          "SoulScribe helps you reflect on your personal growth. Review past entries to better understand yourself and your emotional journey.",
      bgColor: const LinearGradient(
        colors: [Color(0xff662D8C), Color(0xffED1E79)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      textColor: Colors.white,
      child: Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(35)),
          child: Image.asset('assets/images/analyze.png'))),
  PageData(
      icon: Icons.hdr_weak,
      title: "Your Data, Always Safe",
      description:
          "With cloud integration, your journal entries and mood data are securely stored and easily recoverable. Stay connected and never worry about losing your personal journey.",
      textColor: Colors.black,
      child: UnDraw(
        color: const Color(0xffED1E79),
        width: 225,
        height: 225,
        illustration: UnDrawIllustration.security_on,
        placeholder: const Text(
            "Illustration is loading..."), //optional, default is the CircularProgressIndicator().
        errorWidget: const Icon(Icons.error_outline,
            color: Colors.red,
            size:
                100), //optional, default is the Text('Could not load illustration!').
      ))
];

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ConcentricPageView(
        colors: (pages.map((p) => p.bgColor).toList())
          ..add(
            const LinearGradient(
              colors: [Color(0xff662D8C), Color(0xffED1E79)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        radius: screenWidth * 0.1,
        nextButtonBuilder: (context) => Padding(
          padding: const EdgeInsets.only(left: 0), // visual center
          child: Icon(
            Icons.arrow_downward_rounded,
            size: screenWidth * 0.08,
          ),
        ),
        itemCount: pages.length,
        onFinish: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        },
        scaleFactor: 2,
        direction: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (index) {
          final page = pages[index % pages.length];
          return _Page(page: page);
        },
      ),
    );
  }
}

class PageData {
  final String? title;
  final String? description;
  final IconData? icon;
  final LinearGradient bgColor;
  final Color textColor;
  final Widget child;

  PageData({
    this.title,
    this.description,
    this.icon,
    this.bgColor = const LinearGradient(
      colors: [Colors.white, Colors.white],
    ),
    this.textColor = Colors.black,
    required this.child,
  });
}

class _Page extends StatelessWidget {
  final PageData page;
  const _Page({required this.page});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    space(double p) => SizedBox(height: screenHeight * p / 100);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          space(10),
          page.child,
          space(3),
          Text(
            page.title ?? '',
            style: GoogleFonts.ubuntu(
              textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenHeight * 0.046,
                  color: page.textColor),
            ),
            textAlign: TextAlign.center,
          ),
          space(2),
          Opacity(
            opacity: 0.75,
            child: Text(
              page.description ?? '',
              style: GoogleFonts.ubuntu(
                textStyle: TextStyle(
                    fontSize: screenHeight * 0.02, color: page.textColor),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _Text extends StatelessWidget {
  const _Text({
    required this.page,
    this.style,
  });

  final PageData page;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Text(
      page.title ?? '',
      style: TextStyle(
        color: page.textColor,
        fontWeight: FontWeight.w600,
        fontFamily: 'Helvetica',
        letterSpacing: 0.0,
        fontSize: 18,
        height: 1.2,
      ).merge(style),
      textAlign: TextAlign.center,
    );
  }
}
