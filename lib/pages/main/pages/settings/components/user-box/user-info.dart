import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/constants/data.dart';
import 'package:soulscribe/pages/main/pages/settings/components/user-box/user-email.dart';
import 'package:soulscribe/pages/main/pages/settings/components/user-box/user-name.dart';

import 'user_profile_image.dart';

class SettingsPageActivityBox extends StatefulWidget {
  const SettingsPageActivityBox({super.key});

  @override
  State<SettingsPageActivityBox> createState() =>
      _SettingsPageActivityBoxState();
}

class _SettingsPageActivityBoxState extends State<SettingsPageActivityBox> {
  List<Color> gradientColors = [
    kPrimaryColor,
    kSecondaryColor,
  ];
  bool showAvg = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.only(top: 75),
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.circular(35),
            boxShadow: [
              BoxShadow(
                  color: kPrimaryColor.withOpacity(0.25),
                  spreadRadius: 0,
                  blurRadius: 12.5,
                  offset: const Offset(0, 15)),
            ],
          ),
          child: const Column(
            children: [
              SizedBox(
                height: 45,
              ),
              UserBoxUserName(),
              UserBoxUserEmail(),
              // bigDivider(kPrimaryColor),
              // Text(
              //   "Activity (Last 6 months)",
              //   style: GoogleFonts.ubuntu(
              //       color: kPrimaryColor,
              //       fontWeight: FontWeight.bold,
              //       fontSize: 25),
              // ),
              // Container(
              //     height: 250,
              //     width: MediaQuery.of(context).size.width,
              //     decoration: BoxDecoration(
              //         color: Colors
              //             .transparent, // Background color of the chart container
              //         borderRadius: BorderRadius.circular(35),
              //         border: Border.all(color: kWhiteColor, width: 4)),
              //     child: Stack(
              //       children: <Widget>[
              //         AspectRatio(
              //           aspectRatio: 1.70,
              //           child: Padding(
              //             padding: const EdgeInsets.symmetric(),
              //             child: LineChart(
              //               showAvg ? avgData() : mainData(),
              //             ),
              //           ),
              //         ),
              //         InkWell(
              //           onTap: () {
              //             setState(() {
              //               showAvg = !showAvg;
              //             });
              //           },
              //           child: Container(
              //             decoration: BoxDecoration(
              //                 color: kSecondaryColor,
              //                 borderRadius: BorderRadius.circular(15)),
              //             width: 60,
              //             height: 34,
              //             child: Center(
              //               child: Text(
              //                 'avg',
              //                 style: GoogleFonts.ubuntu(
              //                   fontSize: 14,
              //                   fontWeight: FontWeight.bold,
              //                   color: showAvg
              //                       ? kWhiteColor.withOpacity(0.5)
              //                       : kWhiteColor,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ],
              //     )),
            ],
          ),
        ),
        userProfileImage(context, icon: Icons.edit, onTap: () {
          // Navigator.push(
          //     context, const ProfilePageEditUserProfile());
        }),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    TextStyle style = GoogleFonts.ubuntu(
        fontWeight: FontWeight.bold, fontSize: 16, color: kPrimaryColor);
    if (value == 3.0 || value == 6.0 || value == 9.0) {
      return Text(
        months[value.toInt()].substring(0, 3).toUpperCase(),
        style: style,
      );
    } else {
      return const SizedBox();
    }
  }

  LineChartData mainData() {
    return LineChartData(
      backgroundColor: Colors.transparent,
      gridData: const FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(12, 4),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      backgroundColor: Colors.transparent,
      gridData: const FlGridData(
        show: false,
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(12, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
