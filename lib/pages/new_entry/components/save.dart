import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/models/user/entries.dart';
import 'package:soulscribe/pages/new_entry/controller.dart';
import 'package:soulscribe/widgets/rounded_loading_button.dart';

class NewEntrySaveButton extends StatelessWidget {
  NewEntrySaveButton({super.key});

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewEntryController>(builder: (_) {
      return RoundedLoadingButton(
        height: 55,
        width: MediaQuery.of(context).size.width,
        color: kPrimaryColor,
        successColor: Colors.greenAccent,
        errorColor: kSecondaryColor,
        controller: _btnController,
        onPressed: () async {
          if (_.titleController.text != "" && _.journalController.text != "") {
            await Future.delayed(const Duration(milliseconds: 500));
            _btnController.success();
            addEntry(
                title: _.titleController.text,
                content: _.journalController.text,
                dateTime: _.dateTime);
            await Future.delayed(const Duration(milliseconds: 1250));
            Get.delete<NewEntryController>();
            SystemChrome.setSystemUIOverlayStyle(
              const SystemUiOverlayStyle(
                systemNavigationBarColor:
                    Color(0xffF5F5F5), // Bottom navigation bar color
                systemNavigationBarIconBrightness:
                    Brightness.dark, // Icon color
              ),
            );
            Navigator.pop(context);
          } else {
            await Future.delayed(const Duration(milliseconds: 500));
            _btnController.error();
            await Future.delayed(const Duration(milliseconds: 2250));
            _btnController.reset();
          }
        },
        valueColor: Colors.white,
        child: Text('Save',
            style: GoogleFonts.ubuntu(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700)),
      );
    });
  }
}
