import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/models/entries.dart';
import 'package:soulscribe/pages/new_entry/controller.dart';
import 'package:soulscribe/widgets/rounded_loading_button.dart';
import 'package:soulscribe/widgets/snackbar.dart';

class NewEntrySaveButton extends StatelessWidget {
  NewEntrySaveButton({super.key});

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController _btnController2 =
      RoundedLoadingButtonController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewEntryController>(builder: (_) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _.isEdit
              ? RoundedLoadingButton(
                  height: 55,
                  width: !_.isEdit
                      ? MediaQuery.of(context).size.width - 50
                      : (MediaQuery.of(context).size.width / 2) - 50,
                  color: kSecondaryColor,
                  successColor: Colors.greenAccent,
                  errorColor: kSecondaryColor,
                  controller: _btnController2,
                  onPressed: () async {
                    if (_.titleController.text != "" &&
                        _.journalController.text != "") {
                      await Future.delayed(const Duration(milliseconds: 500));
                      removeEntry(index: _.id);
                      _btnController2.success();

                      await Future.delayed(const Duration(milliseconds: 1250));
                      Get.delete<NewEntryController>();
                      SystemChrome.setSystemUIOverlayStyle(
                        const SystemUiOverlayStyle(
                          systemNavigationBarColor:
                              Color(0xffEDF3FA), // Bottom navigation bar color
                          systemNavigationBarIconBrightness:
                              Brightness.dark, // Icon color
                        ),
                      );
                      ShowSnackBar(context,
                          content: "Journal deleted successfully",
                          backgroundColor:
                              const Color(0xFF4CAF50).withOpacity(0.9));
                      Navigator.pop(context);
                    } else {
                      await Future.delayed(const Duration(milliseconds: 500));
                      _btnController2.error();
                      await Future.delayed(const Duration(milliseconds: 2250));
                      _btnController2.reset();
                    }
                  },
                  valueColor: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        IconlyBold.delete,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text('Delete',
                          style: GoogleFonts.ubuntu(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                )
              : const SizedBox(),
          SizedBox(
            width: _.isEdit ? 15 : 0,
          ),
          RoundedLoadingButton(
            height: 55,
            width: !_.isEdit
                ? MediaQuery.of(context).size.width - 50
                : (MediaQuery.of(context).size.width / 2) - 50,
            color: kPrimaryColor,
            successColor: Colors.greenAccent,
            errorColor: kSecondaryColor,
            controller: _btnController,
            onPressed: () async {
              if (_.titleController.text != "" &&
                  _.journalController.text != "") {
                await Future.delayed(const Duration(milliseconds: 500));
                if (_.isEdit) {
                  removeEntry(index: _.id);
                }
                addEntry(
                    title: _.titleController.text,
                    content: _.journalController.text,
                    dateTime: _.dateTime);
                _btnController.success();
                await Future.delayed(const Duration(milliseconds: 1250));
                Get.delete<NewEntryController>();
                SystemChrome.setSystemUIOverlayStyle(
                  const SystemUiOverlayStyle(
                    systemNavigationBarColor:
                        Color(0xffEDF3FA), // Bottom navigation bar color
                    systemNavigationBarIconBrightness:
                        Brightness.dark, // Icon color
                  ),
                );
                ShowSnackBar(context,
                    content: "Changes saved successfully",
                    backgroundColor: const Color(0xFF4CAF50).withOpacity(0.9));
                Navigator.pop(context);
              } else {
                await Future.delayed(const Duration(milliseconds: 500));
                _btnController.error();
                await Future.delayed(const Duration(milliseconds: 2250));
                _btnController.reset();
              }
            },
            valueColor: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Save',
                    style: GoogleFonts.ubuntu(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700)),
                const SizedBox(
                  width: 10,
                ),
                const Icon(
                  FontAwesomeIcons.solidCircleCheck,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
