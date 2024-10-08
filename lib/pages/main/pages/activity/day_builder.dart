import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/models/entries.dart';

class BuildDayWithEntriesMarker extends StatelessWidget {
  const BuildDayWithEntriesMarker(
      {super.key,
      required this.day,
      this.isToday = false,
      this.isSelected = false});
  final DateTime day;
  final bool isToday;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    List<List<String>> entries =
        eachDayGetEntries("${day.year}-${day.month}-${day.day}");
    bool hasEntries = entries.isEmpty ? false : true;
    final textColor =
        isSelected ? Colors.white : (isToday ? kSecondaryColor : kPrimaryColor);
    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          margin: const EdgeInsets.all(2.5),
          // curve: Curves.easeIn,
          decoration: BoxDecoration(
            color: isSelected ? kSecondaryColor : Colors.transparent,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '${day.day}',
              style: GoogleFonts.ubuntu(
                color: textColor,
                fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
              ),
            ),
          ),
        ),
        if (hasEntries)
          Positioned(
            bottom: 7.5,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: isSelected
                    ? kWhiteColor
                    : kSecondaryColor, // Color to indicate entry presence
                shape: BoxShape.circle,
              ),
            ),
          ),
      ],
    );
  }
}
