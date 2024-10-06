import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/main_controller.dart';
import 'package:soulscribe/models/entries.dart';
import 'package:soulscribe/pages/main/pages/home/components/entries.dart';
import 'package:soulscribe/pages/main/pages/home/components/entries_error.dart';
import 'package:soulscribe/pages/new_entry/controller.dart';
import 'package:soulscribe/widgets/circles_background/main_circles_background.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (_) {
      return Stack(
        children: [
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: _.entires.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 70),
                      child: RefreshIndicator(
                          onRefresh: () async {
                            getEntries();
                            await Future.delayed(
                                const Duration(milliseconds: 1750));
                          },
                          color: kSecondaryColor,
                          backgroundColor: kWhiteColor,
                          child: const HomePageEntries()),
                    )
                  : const HomePageEntriesError()),
          MainCirclesBackground(
            backgroundColor: kSecondaryColor,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 17.5),
              child: Text(
                "SoulScript",
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
}
