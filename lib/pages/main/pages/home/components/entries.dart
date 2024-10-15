import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulscribe/main_controller.dart';
import 'package:soulscribe/models/entries.dart';
import 'package:soulscribe/pages/main/pages/home/components/date_indicator.dart';
import 'package:soulscribe/pages/main/pages/home/components/day_entries.dart';

class HomePageEntries extends StatefulWidget {
  const HomePageEntries({super.key});

  @override
  State<HomePageEntries> createState() => _HomePageEntriesState();
}

class _HomePageEntriesState extends State<HomePageEntries> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(builder: (_) {
      return ListView.builder(
        addAutomaticKeepAlives: true,
        dragStartBehavior: DragStartBehavior.down,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: _.entriesDates.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                HomePageDateIndicator(
                  dateTime: dateTimeFormatter(_.entriesDates[index]),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: HomePageEachDayEntries(
                    datetime:
                        "${_.entriesDates[index][0]}-${_.entriesDates[index][1]}-${_.entriesDates[index][2]}",
                  ),
                ),
                const SizedBox(
                  height: 12.5,
                )
              ],
            ),
          );
        },
      );
    });
  }
}
