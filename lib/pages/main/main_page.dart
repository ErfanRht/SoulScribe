import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/main_controller.dart';
import 'package:soulscribe/pages/main/bottom_bar/bottom_bar_double_bullet/bottom_bar_double_bullet.dart';
import 'package:soulscribe/pages/main/bottom_bar/bottom_bar_item.dart';
import 'package:soulscribe/pages/main/pages/home/home.dart';
import 'package:soulscribe/pages/main/pages/quotes/quotes.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Color(0xffEDF3FA),
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
    );
    return GetBuilder<MainController>(builder: (_) {
      return Scaffold(
        backgroundColor: const Color(0xffEDF3FA),
        body: Stack(
          children: [
            PageView(
              controller: _.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: const <Widget>[
                HomePage(),
                QuotesPage(),
                Center(
                  child: Text('Four Page'),
                ),
                Center(
                  child: Text('Five Page'),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: BottomBarDoubleBullet(
                selectedIndex: _.pageController.page?.round() ?? 0,
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
                  if (index != 2) {
                    _.pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  }
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
