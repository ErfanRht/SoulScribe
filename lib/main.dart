import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulscribe/pages/home/home.dart';
import 'package:soulscribe/pages/user_setup/user_setup.dart';
import 'constants/routes.dart';
import 'main_controller.dart';
import 'pages/intro/intro.dart';
import 'pages/loading/loading.dart';

void main() {
  runApp(SoulScript());
}

// ignore: must_be_immutable
class SoulScript extends StatelessWidget {
  SoulScript({super.key});
  MainController mainController = Get.put(MainController());
  final String initRoute = loading_route;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SoulScript',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: initRoute,
      routes: {
        loading_route: (context) => const LoadingScreen(),
        home_route: (context) => const HomePage(),
        setup_route: (context) => const SetupScreen(),
        intro_route: (context) => const IntroPage(),
      },
      home: const IntroPage(),
    );
  }
}
