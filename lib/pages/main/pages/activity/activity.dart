import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/models/entries.dart';
import 'package:soulscribe/pages/main/pages/activity/components/entries_error.dart';
import 'package:soulscribe/pages/main/pages/home/components/date_indicator.dart';
import 'package:soulscribe/pages/main/pages/home/components/day_entries.dart';
import 'package:soulscribe/widgets/circles_background/main_circles_background.dart';
import 'package:soulscribe/widgets/table_calendar/src/customization/calendar_builders.dart';
import 'package:soulscribe/widgets/table_calendar/src/customization/calendar_style.dart';
import 'package:soulscribe/widgets/table_calendar/src/customization/days_of_week_style.dart';
import 'package:soulscribe/widgets/table_calendar/src/customization/header_style.dart';
import 'package:soulscribe/widgets/table_calendar/src/shared/utils.dart';
import 'package:soulscribe/widgets/table_calendar/src/table_calendar.dart';
import 'day_builder.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 115, horizontal: 15),
            child: Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  enabledDayPredicate: (day) {
                    return day.isBefore(DateTime.now());
                  },
                  calendarFormat: _calendarFormat,
                  daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: kSecondaryColor),
                      weekendStyle: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: kSecondaryColor)),
                  onFormatChanged: (format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  },
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month',
                    CalendarFormat.week: 'Week',
                  },
                  headerStyle: HeaderStyle(
                      formatButtonShowsNext: false,
                      leftChevronIcon: const Icon(
                        Icons.chevron_left,
                        color: kPrimaryColor,
                        size: 27.5,
                      ),
                      rightChevronIcon: const Icon(
                        Icons.chevron_right,
                        color: kPrimaryColor,
                        size: 27.5,
                      ),
                      formatButtonDecoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(12)),
                      formatButtonTextStyle: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.bold, color: kWhiteColor),
                      titleTextStyle: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                          color: kPrimaryColor)),
                  availableGestures: AvailableGestures.all,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  onDaySelected: (selectedDay, focusedDay) {
                    if (mounted) {
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                      });
                    }
                  },
                  daysOfWeekHeight: 27.5,
                  rowHeight: 50,
                  calendarStyle: CalendarStyle(
                      defaultTextStyle:
                          GoogleFonts.ubuntu(fontWeight: FontWeight.bold),
                      weekNumberTextStyle:
                          GoogleFonts.ubuntu(fontWeight: FontWeight.bold),
                      weekendTextStyle:
                          GoogleFonts.ubuntu(fontWeight: FontWeight.bold),
                      todayDecoration: const BoxDecoration(
                        color: kSecondaryColor,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: const BoxDecoration(
                        color: kPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                      outsideTextStyle: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor.withOpacity(0.55)),
                      disabledTextStyle: GoogleFonts.ubuntu(
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor.withOpacity(0.55)),
                      rangeHighlightColor: kPrimaryColor),
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      return BuildDayWithEntriesMarker(day: day);
                    },
                    todayBuilder: (context, day, focusedDay) {
                      return BuildDayWithEntriesMarker(day: day, isToday: true);
                    },
                    selectedBuilder: (context, day, focusedDay) {
                      return BuildDayWithEntriesMarker(
                          day: day, isSelected: true);
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    HomePageDateIndicator(
                        key: ValueKey("$_selectedDay 2"),
                        dateTime: _selectedDay),
                    eachDayGetEntries(
                                "${_selectedDay.year}-${_selectedDay.month}-${_selectedDay.day}")
                            .isNotEmpty
                        ? HomePageEachDayEntries(
                            key: ValueKey(_selectedDay),
                            datetime:
                                "${_selectedDay.year}-${_selectedDay.month}-${_selectedDay.day}")
                        : ActivityPageEntriesError(
                            key: ValueKey("$_selectedDay empty"),
                          ),
                  ],
                ),
              ],
            ),
          ),
        ),
        MainCirclesBackground(
          backgroundColor: kPrimaryColor,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 17.5),
            child: Text(
              "Activities",
              textAlign: TextAlign.center,
              style: GoogleFonts.ubuntu(
                  color: kWhiteColor,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
