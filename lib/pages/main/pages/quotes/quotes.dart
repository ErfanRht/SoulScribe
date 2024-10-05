import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/main_controller.dart';
import 'package:soulscribe/widgets/circles_background/main_circles_background.dart';
import 'package:typewritertext/typewritertext.dart';

class QuotesPage extends StatefulWidget {
  const QuotesPage({super.key});

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage> {
  double quoteBoxOpacity = 0.0, quoteIconOpacity = 0;
  double quoteBoxPadding = 75;
  bool textWriterOn = false;

  @override
  void initState() {
    super.initState();
    loadAnimations();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (_) {
      return Stack(
        children: [
          MainCirclesBackground(
            backgroundColor: kPrimaryColor,
            duration: 750,
            position: -525,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 392.5),
              child: Text(
                "Quotes",
                textAlign: TextAlign.center,
                style: GoogleFonts.ubuntu(
                    color: Colors.white,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Center(
            child: AnimatedPadding(
              padding: EdgeInsets.only(top: quoteBoxPadding),
              duration: const Duration(milliseconds: 650),
              child: AnimatedOpacity(
                opacity: quoteBoxOpacity,
                duration: const Duration(milliseconds: 650),
                child: SizedBox(
                  height: 320,
                  child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _.quotes.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 30),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              width: MediaQuery.of(context).size.width - 60,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(37.5),
                                boxShadow: [
                                  BoxShadow(
                                      color: kPrimaryColor.withOpacity(0.25),
                                      spreadRadius: 0,
                                      blurRadius: 12.5,
                                      offset: const Offset(0, 15)),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  textWriterOn
                                      ? TypeWriter.text(
                                          _.quotes[index][0],
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.esteban(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.2,
                                            fontSize: 20,
                                            shadows: [
                                              Shadow(
                                                blurRadius: 4.0,
                                                color: kPrimaryColor
                                                    .withOpacity(0.25),
                                                offset: const Offset(2, 2),
                                              ),
                                            ],
                                          ),
                                          maintainSize: true,
                                          duration:
                                              const Duration(milliseconds: 25),
                                        )
                                      : const SizedBox(),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "--- ${_.quotes[index][1]} ---",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.esteban(
                                        color: kPrimaryColor.withOpacity(0.75),
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.1,
                                        fontSize: 20,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 4.0,
                                            color:
                                                kPrimaryColor.withOpacity(0.15),
                                            offset: const Offset(2, 2),
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left:
                                  (MediaQuery.of(context).size.width / 2) - 30,
                              right:
                                  (MediaQuery.of(context).size.width / 2) - 30,
                              child: AnimatedOpacity(
                                duration: const Duration(milliseconds: 650),
                                opacity: quoteIconOpacity,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: kSecondaryColor,
                                      borderRadius: BorderRadius.circular(50),
                                      boxShadow: [
                                        BoxShadow(
                                            color: kSecondaryColor
                                                .withOpacity(0.275),
                                            spreadRadius: 4,
                                            blurRadius: 8,
                                            offset: const Offset(0, 5)),
                                      ]),
                                  child: const Icon(
                                    Icons.format_quote,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      }),
                ),
              ),
            ),
          )
        ],
      );
    });
  }

  loadAnimations() async {
    await Future.delayed(const Duration(milliseconds: 750));
    setState(() {
      quoteBoxOpacity = 1;
      quoteBoxPadding = 0;
    });
    await Future.delayed(const Duration(milliseconds: 250));
    setState(() {
      quoteIconOpacity = 1;
    });
    await Future.delayed(const Duration(milliseconds: 250));
    setState(() {
      textWriterOn = true;
    });
  }
}
