import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/constants/data.dart';
import 'package:soulscribe/main_controller.dart';
import 'package:soulscribe/models/user/entries.dart';
import 'package:soulscribe/pages/main/pages/home/components/day_entries.dart';

class HomePageEntries extends StatelessWidget {
  const HomePageEntries({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (_) {
      return ListView.builder(
        addAutomaticKeepAlives: true,
        dragStartBehavior: DragStartBehavior.down,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: _.entriesDates.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 70,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.5),
                          color: Colors.white.withOpacity(1)),
                      child: Column(
                        children: [
                          Text(
                            _.entriesDates[index][2],
                            style: GoogleFonts.ubuntu(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: kSecondaryColor),
                          ),
                          Text(
                            months[int.parse(_.entriesDates[index][1]) - 1]
                                .substring(0, 3),
                            style: GoogleFonts.ubuntu(
                                fontWeight: FontWeight.bold,
                                fontSize: 17.5,
                                color: kSecondaryColor.withOpacity(0.75)),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          days[
                              dateTimeFormatter(_.entriesDates[index]).weekday -
                                  1],
                          style: GoogleFonts.ubuntu(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: kPrimaryColor),
                        ),
                        Text(
                          dateDifference(_.entriesDates[index]) > 1
                              ? "${dateDifference(_.entriesDates[index]).toString()} Days Ago"
                              : dateDifference(_.entriesDates[index]) == 0
                                  ? "Today"
                                  : "Yesterday",
                          style: GoogleFonts.ubuntu(
                              fontWeight: FontWeight.bold,
                              fontSize: 17.5,
                              color: kPrimaryColor.withOpacity(0.75)),
                        ),
                      ],
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: HomePageEachDayEntries(
                    datetime:
                        "${_.entriesDates[index][0]}-${_.entriesDates[index][1]}-${_.entriesDates[index][2]}",
                  ),
                ),
                const SizedBox(
                  height: 12.5,
                )
              ],
            ),
          );
        },
      );
    });
  }
}
