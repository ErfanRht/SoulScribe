import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';

import '../controller.dart';

class NewEntryTitleTextFeild extends StatelessWidget {
  const NewEntryTitleTextFeild({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewEntryController>(builder: (_) {
      return TextField(
        controller: _.titleController,
        maxLength: 50,
        autofocus: true,
        cursorWidth: 2.5,
        dragStartBehavior: DragStartBehavior.start,
        cursorRadius: const Radius.circular(10),
        enableSuggestions: true,
        scrollPhysics: const BouncingScrollPhysics(),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          hintText: 'Journal Title...',
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
          filled: true,
          fillColor: kSecondaryColor,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(color: kSecondaryColor, width: 3.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(width: 1.0, color: Colors.white),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(width: 1.0, color: Colors.white),
          ),
        ),
        style: GoogleFonts.ubuntu(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      );
    });
  }
}
