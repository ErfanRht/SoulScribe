import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/pages/new_entry/controller.dart';

class NewEntryJournalTextFeild extends StatefulWidget {
  const NewEntryJournalTextFeild({super.key});

  @override
  State<NewEntryJournalTextFeild> createState() =>
      _NewEntryJournalTextFeildState();
}

class _NewEntryJournalTextFeildState extends State<NewEntryJournalTextFeild> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewEntryController>(builder: (_) {
      return Expanded(
        child: Stack(
          children: [
            TextField(
              controller: _.journalController,
              autocorrect: true,
              cursorOpacityAnimates: true,
              cursorWidth: 2.5,
              dragStartBehavior: DragStartBehavior.start,
              enableIMEPersonalizedLearning: true,
              enableInteractiveSelection: true,
              cursorRadius: const Radius.circular(10),
              enableSuggestions: true,
              scrollPhysics: const BouncingScrollPhysics(),
              textAlignVertical: TextAlignVertical.top,
              style: GoogleFonts.ubuntu(
                  color: Colors.white, fontWeight: FontWeight.w600),
              strutStyle: StrutStyle.fromTextStyle(GoogleFonts.ubuntu(
                  color: Colors.white, fontWeight: FontWeight.w600)),
              spellCheckConfiguration: const SpellCheckConfiguration(
                  misspelledSelectionColor: Colors.white),
              cursorColor: Colors.white,
              maxLines: null,
              expands: true,
              onChanged: (text) {
                _.updateNewEntryController(newJournalCharCount: text.length);
              },
              decoration: InputDecoration(
                hintText: 'Start writing your thoughts...',
                hintStyle: TextStyle(
                    color: Colors.white.withOpacity(0.8)), // Hint text color
                filled: true,
                fillColor: kSecondaryColor.withOpacity(1), // Background color
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide:
                      const BorderSide(color: kSecondaryColor, width: 3.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(width: 1.0, color: Colors.white),
                ),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(width: 1.0, color: Colors.white),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17.5),
                          color: kPrimaryColor),
                      width: _.journalCharCount == 0
                          ? 150
                          : _.journalCharCount < 1000
                              ? 40
                              : 80,
                      height: 50,
                      child: Center(
                        child: Text(
                          _.journalCharCount == 0
                              ? "Character Counter"
                              : _.journalCharCount.toString(),
                          style: GoogleFonts.ubuntu(
                              fontSize: _.journalCharCount == 0 ? 15 : 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
