import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/pages/home/bottom_bar/bottom_bar_double_bullet/bottom_bar_double_bullet.dart';
import 'package:soulscribe/pages/home/bottom_bar/bottom_bar_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  final PageController controller = PageController();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      // appBar: AppBar(title: const Text("")),
      bottomNavigationBar: BottomBarDoubleBullet(
        bubbleSize: 12.5,
        color: kSecondaryColor,
        circle1Color: kSecondaryColor,
        circle2Color: kSecondaryColor,
        items: [
          BottomBarItem(
            iconData: Icons.home_rounded,
            // label: 'Home',
          ),
          BottomBarItem(
            iconData: Icons.format_quote_rounded,
            // label: 'Chat',
          ),
          BottomBarItem(
            iconData: Icons.notifications,
            // label: 'Notification',
          ),
          BottomBarItem(
            iconData: Icons.calendar_month,
            // label: 'Calendar',
          ),
          BottomBarItem(
            iconData: Icons.settings,
            // label: 'Setting',
          ),
        ],
        onSelect: (index) {
          // implement your select function here
        },
      ),
      body: PageView(
        controller: controller,
        children: const <Widget>[
          Center(
            child: Text('First Page'),
          ),
          Center(
            child: Text('Second Page'),
          ),
          Center(
            child: Text('Third Page'),
          ),
          Center(
            child: Text('Four Page'),
          ),
          Center(
            child: Text('Five Page'),
          ),
        ],
      ),
    );
  }
}
