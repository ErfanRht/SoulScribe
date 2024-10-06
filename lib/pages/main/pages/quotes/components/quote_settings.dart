import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/models/quotes.dart';
import 'package:soulscribe/pages/main/pages/quotes/components/quote_category.dart';
import 'package:soulscribe/pages/main/pages/quotes/quotes.dart';
import 'package:soulscribe/widgets/page_transition/page_transition.dart';
import 'package:soulscribe/widgets/rounded_loading_button.dart';

class QuoteSettings extends StatefulWidget {
  const QuoteSettings({super.key});

  @override
  State<QuoteSettings> createState() => _QuoteSettingsState();
}

class _QuoteSettingsState extends State<QuoteSettings> {
  double categoryButtonOpacity = 0, reloadButtonOpacity = 0;
  @override
  void initState() {
    super.initState();
    loadAnimations();
  }

  @override
  Widget build(BuildContext context) {
    final RoundedLoadingButtonController btnController =
        RoundedLoadingButtonController();
    return Column(
      children: [
        AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: categoryButtonOpacity,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: RoundedLoadingButton(
              animateOnTap: false,
              height: 55,
              width: MediaQuery.of(context).size.width - 60,
              color: Colors.white,
              successColor: Colors.greenAccent,
              errorColor: kSecondaryColor,
              controller: btnController,
              onPressed: () async {
                // Navigator.push(
                //     context,
                //     PageTransition(
                //         duration: const Duration(milliseconds: 350),
                //         reverseDuration: const Duration(milliseconds: 350),
                //         childCurrent: const QuotesPage(),
                //         type: PageTransitionType.scale,
                //         fullscreenDialog: true,
                //         maintainStateData: false,
                //         alignment: Alignment.topCenter,
                //         child: const QuoteCategoryPage()));
              },
              valueColor: Colors.white,
              child: Text('Category',
                  style: GoogleFonts.ubuntu(
                      color: kPrimaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700)),
            ),
          ),
        ),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: reloadButtonOpacity,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 225),
            child: RoundedLoadingButton(
              height: 55,
              animateOnTap: false,
              width: MediaQuery.of(context).size.width - 250,
              color: kSecondaryColor,
              successColor: Colors.greenAccent,
              errorColor: kSecondaryColor,
              controller: btnController,
              onPressed: () async {
                reloadQuotes();
              },
              valueColor: Colors.white,
              child: Text('Reload',
                  style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700)),
            ),
          ),
        )
      ],
    );
  }

  loadAnimations() async {
    await Future.delayed(const Duration(milliseconds: 800));
    setState(() {
      categoryButtonOpacity = 1;
    });
    await Future.delayed(const Duration(milliseconds: 250));
    setState(() {
      reloadButtonOpacity = 1;
    });
  }
}
