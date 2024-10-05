import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/models/entries.dart';
import 'package:soulscribe/pages/main/main_page.dart';
import 'package:soulscribe/pages/new_entry/controller.dart';
import 'package:soulscribe/pages/new_entry/new-entry.dart';
import 'package:soulscribe/widgets/page_transition/page_transition.dart';

class HomePageEachDayEntries extends StatefulWidget {
  const HomePageEachDayEntries({super.key, required this.datetime});
  final String datetime;

  @override
  State<HomePageEachDayEntries> createState() => _HomePageEachDayEntriesState();
}

class _HomePageEachDayEntriesState extends State<HomePageEachDayEntries> {
  List<List<String>> entries = [];
  double opacity = 0, padding = 50;
  @override
  void initState() {
    super.initState();
    getThisDateEntries();
    loadAnimations();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        reverse: true,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return AnimatedOpacity(
            duration: const Duration(milliseconds: 550),
            opacity: opacity,
            child: AnimatedPadding(
              duration: const Duration(milliseconds: 550),
              padding: EdgeInsets.only(bottom: padding),
              child: InkWell(
                onTap: () {
                  Get.put(NewEntryController());
                  Get.find<NewEntryController>().titleController.text =
                      entries[index][0];
                  Get.find<NewEntryController>().journalController.text =
                      entries[index][1];
                  Get.find<NewEntryController>().updateNewEntryController(
                      newDateTime: dateTimeFormatter(
                          entries[index][2].split("-").toList()),
                      newJournalCharCount: entries[index][1].length,
                      newId: entries[index][3],
                      isBeingEdited: true);
                  Navigator.push(
                      context,
                      PageTransition(
                          duration: const Duration(milliseconds: 350),
                          reverseDuration: const Duration(milliseconds: 350),
                          childCurrent: const MainPage(),
                          type: PageTransitionType.scale,
                          fullscreenDialog: true,
                          maintainStateData: false,
                          alignment: Alignment.bottomCenter,
                          child: NewEntryPage()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  padding: const EdgeInsets.all(17.5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                        entries[index][1].length > 75 ? 17.5 : 15),
                    boxShadow: [
                      BoxShadow(
                          color: kPrimaryColor.withOpacity(0.25),
                          spreadRadius: 0,
                          blurRadius: 12.5,
                          offset: const Offset(0, 15)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entries[index][0],
                        style: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.bold,
                            color: kSecondaryColor,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        shortText(entries[index][1]),
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                            fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  loadAnimations() async {
    await Future.delayed(const Duration(milliseconds: 850));
    setState(() {
      opacity = 1;
      padding = 0;
    });
  }

  getThisDateEntries() async {
    List<List<String>> gottenEntries = [];
    gottenEntries = await eachDayGetEntries(widget.datetime);
    setState(() {
      entries = gottenEntries;
    });
  }

  String shortText(String text) {
    return text.length > 180 ? '${text.substring(0, 180)}...' : text;
  }
}
