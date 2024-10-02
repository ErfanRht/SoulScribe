import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/pages/new_entry/components/datepicker.dart';
import 'package:soulscribe/pages/new_entry/components/journal_textfeild.dart';
import 'package:soulscribe/pages/new_entry/components/moodpicker.dart';
import 'package:soulscribe/pages/new_entry/components/title_textfield.dart';
import 'package:soulscribe/widgets/rounded_loading_button.dart';

class NewEntryPage extends StatefulWidget {
  const NewEntryPage({super.key});

  @override
  _NewEntryPageState createState() => _NewEntryPageState();
}

class _NewEntryPageState extends State<NewEntryPage> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'New Journal',
          style: GoogleFonts.ubuntu(
              color: kPrimaryColor, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(
          color: kPrimaryColor,
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            NewEntryTitleTextFeild(),
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
            RoundedLoadingButton(
              height: 55,
              width: MediaQuery.of(context).size.width,
              color: kPrimaryColor,
              successColor: Colors.greenAccent,
              errorColor: Colors.redAccent,
              controller: _btnController,
              onPressed: () {},
              valueColor: Colors.white,
              child: Text('Save',
                  style: GoogleFonts.ubuntu(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700)),
            ),
          ],
        ),
      ),
    );
  }
}
