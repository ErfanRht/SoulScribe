import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/models/user/entries.dart';

class HomePageEachDayEntries extends StatefulWidget {
  const HomePageEachDayEntries({super.key, required this.datetime});
  final String datetime;

  @override
  State<HomePageEachDayEntries> createState() => _HomePageEachDayEntriesState();
}

class _HomePageEachDayEntriesState extends State<HomePageEachDayEntries> {
  List<List<String>> entries = [];
  @override
  void initState() {
    super.initState();
    getThisDateEntries();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        reverse: true,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: entries.length,
        itemBuilder: (context, index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            // height: 110,
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
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.ubuntu(
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                      fontSize: 15),
                )
              ],
            ),
          );
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
