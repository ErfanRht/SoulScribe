import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconly/iconly.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/pages/main/bottom_bar/bottom_bar_double_bullet/bottom_bar_double_bullet.dart';
import 'package:soulscribe/pages/main/bottom_bar/bottom_bar_item.dart';
import 'package:soulscribe/pages/main/pages/activity/activity.dart';
import 'package:soulscribe/pages/main/pages/home/home.dart';
import 'package:soulscribe/pages/main/pages/quotes/quotes.dart';
import 'package:soulscribe/pages/main/pages/settings/settings.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  static final PageController pageController = PageController();

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
    return Scaffold(
      backgroundColor: const Color(0xffEDF3FA),
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            children: const <Widget>[
              HomePage(),
              QuotesPage(),
              SizedBox(),
              ActivityPage(),
              SettingsPage()
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: BottomBarDoubleBullet(
              bubbleSize: 12.5,
              color: kSecondaryColor,
              circle1Color: kSecondaryColor,
              circle2Color: kSecondaryColor,
              selectedIndex: 3,
              items: [
                BottomBarItem(
                  iconData: IconlyBold.home,
                ),
                BottomBarItem(
                  iconData: IconlyBold.document,
                ),
                BottomBarItem(
                  iconData: Icons.notifications,
                ),
                BottomBarItem(
                  iconData: IconlyBold.activity,
                ),
                BottomBarItem(
                  iconData: IconlyBold.profile,
                ),
              ],
              onSelect: (index) {
                if (index != 2) {
                  pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 50),
                      curve: Curves.easeIn);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
