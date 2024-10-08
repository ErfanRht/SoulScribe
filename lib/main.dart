import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulscribe/pages/main/main_page.dart';
import 'package:soulscribe/pages/user_setup/user_setup.dart';
import 'package:soulscribe/constants/routes.dart';
import 'package:soulscribe/main_controller.dart';
import 'package:soulscribe/pages/intro/intro.dart';
import 'package:soulscribe/pages/loading/loading.dart';

void main() {
  runApp(SoulScribe());
}

class SoulScribe extends StatelessWidget {
  SoulScribe({super.key});
  MainController mainController = Get.put(MainController());
  final String initRoute = loading_route;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SoulScribe',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: initRoute,
      routes: {
        loading_route: (context) => const LoadingScreen(),
        home_route: (context) => const MainPage(),
        setup_route: (context) => const SetupScreen(),
        intro_route: (context) => const IntroPage(),
      },
    );
  }
}
