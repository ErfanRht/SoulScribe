import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/widgets/rounded_loading_button.dart';

class NewEntryPage extends StatefulWidget {
  const NewEntryPage({super.key});

  @override
  _NewEntryPageState createState() => _NewEntryPageState();
}

class _NewEntryPageState extends State<NewEntryPage> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _titleController =
      TextEditingController(); // Controller for journal name
  int _charCount = 0;
  int? rating;
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
            TextField(
              controller: _titleController,
              maxLength: 50,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Journal Name...',
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                filled: true,
                fillColor: kSecondaryColor,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      const BorderSide(color: kSecondaryColor, width: 3.0),
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
            ),
            Row(
              children: [
                InkWell(
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
                      setState(() {
                        //selectedDate = picked;
                      });
                    }
                  },
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(17.5),
                        color: kPrimaryColor),
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
                ),
                const SizedBox(
                  width: 15,
                ),
                Container(
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17.5),
                      color: const Color(0xffFFD700)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.mood_rounded,
                        size: 27.5,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Mood",
                        style: GoogleFonts.ubuntu(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.5),
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 17.5),
            Expanded(
              child: Stack(
                children: [
                  TextField(
                    controller: _controller,
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
                      setState(() {
                        _charCount = text.length;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Start writing your thoughts...',
                      hintStyle: TextStyle(
                          color:
                              Colors.white.withOpacity(0.8)), // Hint text color
                      filled: true,
                      fillColor:
                          kSecondaryColor.withOpacity(1), // Background color
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(
                            color: kSecondaryColor, width: 3.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide:
                            const BorderSide(width: 1.0, color: Colors.white),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide:
                            const BorderSide(width: 1.0, color: Colors.white),
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
                            width: _charCount == 0
                                ? 150
                                : _charCount < 1000
                                    ? 50
                                    : 100,
                            height: 50,
                            child: Center(
                              child: Text(
                                _charCount == 0
                                    ? "Character Counter"
                                    : _charCount.toString(),
                                style: GoogleFonts.ubuntu(
                                    fontSize: _charCount == 0 ? 15 : 25,
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
            ),
            const SizedBox(height: 20),
            RoundedLoadingButton(
              height: 55,
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
