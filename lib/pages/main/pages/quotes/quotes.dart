import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/main_controller.dart';
import 'package:soulscribe/pages/main/pages/quotes/components/quote_builder.dart';
import 'package:soulscribe/pages/main/pages/quotes/components/quote_settings.dart';
import 'package:soulscribe/widgets/circles_background/main_circles_background.dart';

class QuotesPage extends StatelessWidget {
  const QuotesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (_) {
      return Stack(
        children: [
          MainCirclesBackground(
            backgroundColor: kPrimaryColor,
            duration: 750,
            position: -525,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 27.5),
                  child: Text(
                    "Quotes",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ubuntu(
                        color: kWhiteColor,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const QuoteSettings()
              ],
            ),
          ),
          const QuoteBuilder()
        ],
      );
    });
  }
}
