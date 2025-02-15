import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:share_plus/share_plus.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/main_controller.dart';
import 'package:soulscribe/widgets/snackbar.dart';
import 'package:typewritertext/typewritertext.dart';

class QuoteBuilder extends StatefulWidget {
  const QuoteBuilder({super.key});

  @override
  State<QuoteBuilder> createState() => _QuoteBuilderState();
}

class _QuoteBuilderState extends State<QuoteBuilder> {
  double quoteBoxOpacity = 0.0, quoteIconOpacity = 0;
  double quoteBoxPadding = 125;
  bool textWriterOn = false;
  @override
  void initState() {
    super.initState();
    loadAnimations();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (_) {
      return Center(
        child: AnimatedPadding(
          padding: EdgeInsets.only(top: quoteBoxPadding),
          duration: const Duration(milliseconds: 650),
          child: AnimatedOpacity(
            opacity: quoteBoxOpacity,
            duration: const Duration(milliseconds: 650),
            child: SizedBox(
              height: 400,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: _.quotes.isNotEmpty
                    ? PageView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: _.quotes.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 260,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 30, vertical: 30),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 15),
                                    width:
                                        MediaQuery.of(context).size.width - 60,
                                    decoration: BoxDecoration(
                                      color: kWhiteColor,
                                      borderRadius: BorderRadius.circular(37.5),
                                      boxShadow: [
                                        BoxShadow(
                                            color:
                                                kPrimaryColor.withOpacity(0.25),
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
                                                      offset:
                                                          const Offset(2, 2),
                                                    ),
                                                  ],
                                                ),
                                                maintainSize: true,
                                                duration: const Duration(
                                                    milliseconds: 25),
                                              )
                                            : const SizedBox(),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "--- ${_.quotes[index][1]} ---",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.esteban(
                                              color: kPrimaryColor
                                                  .withOpacity(0.75),
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.1,
                                              fontSize: 20,
                                              shadows: [
                                                Shadow(
                                                  blurRadius: 4.0,
                                                  color: kPrimaryColor
                                                      .withOpacity(0.15),
                                                  offset: const Offset(2, 2),
                                                ),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Clipboard.setData(ClipboardData(
                                              text:
                                                  "${_.quotes[index][0]}\n---${_.quotes[index][1]}---"));
                                          ShowSnackBar(context,
                                              backgroundColor: kPrimaryColor
                                                  .withOpacity(0.9),
                                              content: "Copied to clipboard");
                                        },
                                        style: ButtonStyle(
                                            minimumSize:
                                                WidgetStateProperty.all(
                                              const Size(60, 70),
                                            ),
                                            alignment: Alignment.center,
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    kPrimaryColor)),
                                        child: const Icon(
                                          FontAwesomeIcons.solidCopy,
                                          color: kWhiteColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ButtonStyle(
                                            minimumSize:
                                                WidgetStateProperty.all(
                                              const Size(60, 70),
                                            ),
                                            alignment: Alignment.center,
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    kSecondaryColor)),
                                        child: const Icon(
                                          FontAwesomeIcons.heart,
                                          color: kWhiteColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      ElevatedButton(
                                        onPressed: () async {
                                          final result = await Share.share(
                                              '${_.quotes[index][0]}\n---${_.quotes[index][1]}---',
                                              subject:
                                                  'Look at this quote which i found on SoulScribe!');

                                          if (result.status ==
                                              ShareResultStatus.success) {
                                            ShowSnackBar(context,
                                                backgroundColor: kPrimaryColor
                                                    .withOpacity(0.9),
                                                content:
                                                    "Successfully shared!");
                                          } else {
                                            ShowSnackBar(context,
                                                backgroundColor: kSecondaryColor
                                                    .withOpacity(0.9),
                                                success: false,
                                                content: "Sahring failed!");
                                          }
                                        },
                                        style: ButtonStyle(
                                            minimumSize:
                                                WidgetStateProperty.all(
                                              const Size(60, 70),
                                            ),
                                            alignment: Alignment.center,
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                    kPrimaryColor)),
                                        child: const Icon(
                                          IconlyBold.send,
                                          color: kWhiteColor,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Positioned(
                                top: 0,
                                left: (MediaQuery.of(context).size.width / 2) -
                                    30,
                                right: (MediaQuery.of(context).size.width / 2) -
                                    30,
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
                                      FontAwesomeIcons.quoteRight,
                                      color: kWhiteColor,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        })
                    : const SpinKitDoubleBounce(
                        color: kSecondaryColor,
                        size: 100,
                      ),
              ),
            ),
          ),
        ),
      );
    });
  }

  loadAnimations() async {
    await Future.delayed(const Duration(milliseconds: 750));
    setState(() {
      quoteBoxOpacity = 1;
      quoteBoxPadding = 50;
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
