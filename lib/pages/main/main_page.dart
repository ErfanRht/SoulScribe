import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/pages/main/bottom_bar/bottom_bar_double_bullet/bottom_bar_double_bullet.dart';
import 'package:soulscribe/pages/main/bottom_bar/bottom_bar_item.dart';
import 'package:soulscribe/pages/main/pages/home/home.dart';
import 'package:soulscribe/pages/main/pages/quotes/quotes.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor:
            Color(0xffEDF3FA), // Bottom navigation bar color
        systemNavigationBarIconBrightness: Brightness.dark, // Icon color
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffEDF3FA),
      bottomNavigationBar: BottomBarDoubleBullet(
        bubbleSize: 12.5,
        color: kSecondaryColor,
        circle1Color: kSecondaryColor,
        circle2Color: kSecondaryColor,
        items: [
          BottomBarItem(
            iconData: Icons.home_rounded,
          ),
          BottomBarItem(
            iconData: Icons.format_quote_rounded,
          ),
          BottomBarItem(
            iconData: Icons.notifications,
          ),
          BottomBarItem(
            iconData: Icons.calendar_month,
          ),
          BottomBarItem(
            iconData: Icons.settings,
          ),
        ],
        onSelect: (index) {
          pageController.animateToPage(index,
              duration: const Duration(milliseconds: 500),
              curve: Curves.decelerate);
        },
      ),
      body: PageView(
        controller: pageController,
        children: const <Widget>[
          HomePage(),
          QuotesPage(),
          Center(
              //child: Text('Third Page'),
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
