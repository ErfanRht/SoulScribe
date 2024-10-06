import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/pages/new_entry/components/datepicker.dart';
import 'package:soulscribe/pages/new_entry/components/journal_textfeild.dart';
import 'package:soulscribe/pages/new_entry/components/moodpicker.dart';
import 'package:soulscribe/pages/new_entry/components/save.dart';
import 'package:soulscribe/pages/new_entry/components/title_textfield.dart';
import 'package:soulscribe/pages/new_entry/controller.dart';
import 'package:soulscribe/widgets/rounded_loading_button.dart';

class NewEntryPage extends StatelessWidget {
  NewEntryPage({super.key});

  NewEntryController newEntryController = Get.put(NewEntryController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: kWhiteColor, // Bottom navigation bar color
        systemNavigationBarIconBrightness: Brightness.dark, // Icon color
      ),
    );
    return GetBuilder<NewEntryController>(builder: (_) {
      // ignore: deprecated_member_use
      return WillPopScope(
        onWillPop: () async {
          if (_.titleController.text != '' || _.journalController.text != '') {
            bool shouldPop = await showUnsavedChangesDialog(context);
            if (shouldPop) {
              Get.delete<NewEntryController>();
              SystemChrome.setSystemUIOverlayStyle(
                const SystemUiOverlayStyle(
                  systemNavigationBarColor:
                      Color(0xffEDF3FA), // Bottom navigation bar color
                  systemNavigationBarIconBrightness:
                      Brightness.dark, // Icon color
                ),
              );
            }
            return shouldPop;
          } else {
            Get.delete<NewEntryController>();
            SystemChrome.setSystemUIOverlayStyle(
              const SystemUiOverlayStyle(
                systemNavigationBarColor:
                    Color(0xffEDF3FA), // Bottom navigation bar color
                systemNavigationBarIconBrightness:
                    Brightness.dark, // Icon color
              ),
            );
            return true;
          }
        },
        child: Scaffold(
          backgroundColor: kWhiteColor,
          appBar: AppBar(
            title: Text(
              'New Journal',
              style: GoogleFonts.ubuntu(
                  color: kPrimaryColor, fontWeight: FontWeight.bold),
            ),
            iconTheme: const IconThemeData(
              color: kPrimaryColor,
            ),
            backgroundColor: kWhiteColor,
          ),
          body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                const NewEntryTitleTextFeild(),
                const Row(
                  children: [
                    NewEntryDatePicker(),
                    SizedBox(
                      width: 15,
                    ),
                    NewEntryMoodPicker(),
                  ],
                ),
                const SizedBox(height: 17.5),
                const NewEntryJournalTextFeild(),
                const SizedBox(height: 20),
                NewEntrySaveButton()
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<bool> showUnsavedChangesDialog(BuildContext context) async {
    return (await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Unsaved Changes',
                style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.bold, color: kSecondaryColor),
              ),
              content: Text(
                'You have unsaved changes. Do you want to leave without saving?',
                style: GoogleFonts.ubuntu(
                    fontWeight: FontWeight.w600, color: kPrimaryColor),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(false), // Don't pop
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.bold, color: kPrimaryColor),
                  ),
                ),
                TextButton(
                  onPressed: () =>
                      Navigator.of(context).pop(true), // Pop the page
                  child: Text(
                    'Leave',
                    style: GoogleFonts.ubuntu(
                        fontWeight: FontWeight.bold, color: kSecondaryColor),
                  ),
                ),
              ],
            );
          },
        )) ??
        false;
  }
}
