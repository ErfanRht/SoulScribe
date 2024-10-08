import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/constants/data.dart';
import 'package:soulscribe/models/entries.dart';

class HomePageDateIndicator extends StatefulWidget {
  const HomePageDateIndicator({super.key, required this.dateTime});
  final DateTime dateTime;
  @override
  State<HomePageDateIndicator> createState() => _HomePageDateIndicatorState();
}

class _HomePageDateIndicatorState extends State<HomePageDateIndicator> {
  double calOpacity = 0, titleOpacity = 0, differenceOpacity = 0;
  double titlePadding = 25, differencePadding = 25;
  @override
  void initState() {
    super.initState();
    loadAnimations();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AnimatedOpacity(
          duration: const Duration(milliseconds: 250),
          opacity: calOpacity,
          child: Container(
            width: 60,
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.5),
                color: kWhiteColor.withOpacity(1)),
            child: Column(
              children: [
                Text(
                  widget.dateTime.day.toString(),
                  style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: kSecondaryColor),
                ),
                Text(
                  months[widget.dateTime.month - 1].substring(0, 3),
                  style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.5,
                      color: kSecondaryColor.withOpacity(0.75)),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: titleOpacity,
              child: AnimatedPadding(
                padding: EdgeInsets.only(left: titlePadding),
                duration: const Duration(milliseconds: 400),
                child: Text(
                  days[widget.dateTime.weekday - 1],
                  style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: kPrimaryColor),
                ),
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              opacity: differenceOpacity,
              child: AnimatedPadding(
                padding: EdgeInsets.only(left: differencePadding),
                duration: const Duration(milliseconds: 600),
                child: Text(
                  dateDifference([
                            widget.dateTime.year.toString(),
                            widget.dateTime.month.toString(),
                            widget.dateTime.day.toString()
                          ]) >
                          1
                      ? "${dateDifference([
                              widget.dateTime.year.toString(),
                              widget.dateTime.month.toString(),
                              widget.dateTime.day.toString()
                            ]).toString()} Days Ago"
                      : dateDifference([
                                widget.dateTime.year.toString(),
                                widget.dateTime.month.toString(),
                                widget.dateTime.day.toString()
                              ]) ==
                              0
                          ? "Today"
                          : "Yesterday",
                  style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.5,
                      color: kPrimaryColor.withOpacity(0.75)),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  loadAnimations() async {
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() {
      titleOpacity = 1;
      differenceOpacity = 1;
    });
    await Future.delayed(const Duration(milliseconds: 250));
    setState(() {
      calOpacity = 1;
      titlePadding = 0;
      differencePadding = 0;
    });
  }
}
