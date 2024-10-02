import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';

class NewEntryDatePicker extends StatelessWidget {
  const NewEntryDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
            context: context,
            builder: (BuildContext context, child) {
              return Theme(
                  data: ThemeData(
                    // dialogBackgroundColor: kSecondaryColor,
                    // cardColor: kSecondaryColor,
                    // primaryColor: kPrimaryColor,
                    // scaffoldBackgroundColor: kSecondaryColor,
                    colorScheme: const ColorScheme.light(
                      primary: kSecondaryColor,
                      onPrimary: Colors.white,
                      onSurface: Colors.white,
                      surface: kPrimaryColor,
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          textStyle: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                  child: child!);
            },
            initialDate: DateTime.now(),
            currentDate: DateTime.now(),
            selectableDayPredicate: (DateTime date) =>
                date.isAfter(DateTime.now()) ? false : true,
            firstDate: DateTime(1901),
            lastDate: DateTime(2101));
        if (picked != null && picked != DateTime.now()) {
          // setState(() {
          //   //selectedDate = picked;
          // });
        }
      },
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17.5), color: kPrimaryColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.calendar_month_rounded,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Today",
              style: GoogleFonts.ubuntu(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 17.5),
            )
          ],
        ),
      ),
    );
  }
}
