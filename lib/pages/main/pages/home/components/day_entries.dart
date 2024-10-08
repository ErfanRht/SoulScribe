import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/constants/data.dart';
import 'package:soulscribe/models/entries.dart';
import 'package:soulscribe/pages/main/main_page.dart';
import 'package:soulscribe/pages/new_entry/controller.dart';
import 'package:soulscribe/pages/new_entry/new-entry.dart';
import 'package:soulscribe/widgets/page_transition/page_transition.dart';
import 'package:typewritertext/typewritertext.dart';

class HomePageEachDayEntries extends StatefulWidget {
  const HomePageEachDayEntries({super.key, required this.datetime});
  final String datetime;

  @override
  State<HomePageEachDayEntries> createState() => _HomePageEachDayEntriesState();
}

class _HomePageEachDayEntriesState extends State<HomePageEachDayEntries>
    with SingleTickerProviderStateMixin {
  List<List<String>> entries = [];
  double opacity = 0, padding = 50;
  OverlayEntry? _overlayEntry;
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 75),
  );
  late final Animation<double> _scaleAnimation =
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
  late final Animation<double> _opacityAnimation =
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);

  @override
  void initState() {
    super.initState();
    getThisDateEntries();
    loadAnimations();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showInfoDialog(BuildContext context, Offset offset,
      {required String title,
      required String content,
      required DateTime dateTime}) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(color: Colors.transparent),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: FadeTransition(
                opacity: _opacityAnimation,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(22.5),
                  margin:
                      const EdgeInsets.symmetric(vertical: 125, horizontal: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: kPrimaryColor.withOpacity(0.25),
                        spreadRadius: 5,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.bold,
                            color: kSecondaryColor,
                            fontSize: 20),
                      ),
                      Text(
                        "${months[dateTime.month - 1]} ${dateTime.day}${dateTime.year != DateTime.now().year ? ", ${dateTime.year}" : ""}",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor.withOpacity(0.5),
                            fontSize: 15),
                      ),
                      const SizedBox(height: 20),
                      TypeWriter.text(
                        content,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 25,
                        style: GoogleFonts.ubuntu(
                            fontWeight: FontWeight.bold,
                            color: kPrimaryColor,
                            fontSize: 15),
                        maintainSize: true,
                        duration: const Duration(milliseconds: 25),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _controller.forward();
  }

  void _hideDialog() {
    if (_overlayEntry != null) {
      _controller.reverse().then((_) {
        _overlayEntry!.remove();
        _overlayEntry = null;
        _controller
            .reset(); // Reset the animation controller so it can be used again
      });
    }
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
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: GestureDetector(
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
                  onLongPressStart: (details) {
                    _showInfoDialog(
                      context,
                      details.globalPosition,
                      title: entries[index][0],
                      content: entries[index][1],
                      dateTime: dateTimeFormatter(
                          entries[index][2].split("-").toList()),
                    );
                  },
                  onLongPressEnd: (_) {
                    _hideDialog();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(17.5),
                    decoration: BoxDecoration(
                      color: kWhiteColor,
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
    gottenEntries = eachDayGetEntries(widget.datetime);
    setState(() {
      entries = gottenEntries;
    });
  }

  String shortText(String text) {
    return text.length > 180 ? '${text.substring(0, 180)}...' : text;
  }
}
