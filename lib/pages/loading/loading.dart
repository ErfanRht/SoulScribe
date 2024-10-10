// ignore_for_file: no_wildcard_variable_uses, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/constants/routes.dart';
import 'package:soulscribe/main_controller.dart';
import 'package:soulscribe/models/biometrics.dart';
import 'package:soulscribe/models/quotes.dart';
import 'package:soulscribe/models/entries.dart';
import 'package:soulscribe/models/user/user-name.dart';
import 'package:soulscribe/widgets/copyright.dart';
import 'animations.dart';
import 'components/logo.dart';
import 'components/spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  LoadingAnimationsController loadingAnimationsController =
      Get.put(LoadingAnimationsController());
  String nextRoute = home_route;
  bool isFirstEnter = false;
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: kSecondaryColor,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
    );
    startLoadingAnimations();
    getEntries();
    fetchQuotes(null);
    load();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoadingAnimationsController>(builder: (_) {
      return Scaffold(
          body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff662D8C), Color(0xffED1E79)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
            padding: const EdgeInsets.only(left: 50, right: 45),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const SizedBox(),
                const LoadingLogo(),
                const LoadingSpinkit(),
                AnimatedOpacity(
                  duration: _.animationSpeed,
                  opacity: _.textOpacity,
                  child: const CopyRightWidget(
                    color: kWhiteColor,
                    nameColor: kWhiteColor,
                  ),
                )
              ],
            )),
      ));
    });
  }

  load() async {
    await check();
    pass();
  }

  check() async {
    await checkUserName().then((response) async {
      Get.find<MainController>().updateMainStete(
        newFirstEnterStatus: !response,
      );

      isFirstEnter = !response;
      if (isFirstEnter) {
        setState(() {
          nextRoute = intro_route;
        });
        if (Get.find<MainController>().entires.isEmpty) {
          addEntry(
              title: "A New Beginning",
              content:
                  "Today, I’ve decided to start journaling. I’ve always wanted a space to capture my thoughts, and SoulScribe feels like the perfect tool for it. Right now, I’m feeling a mix of excitement and curiosity—wondering what kind of stories, emotions, and reflections this journal will hold in the future. I’m not sure where this journey will lead, but I’m ready to explore, reflect, and grow. Here’s to new beginnings!",
              dateTime: DateTime.now());
          print("New Entry Automatically added.");
        }
      } else {
        bool auth = await authenticateWithBiometricsStatus();
        setState(() {
          if (auth) {
            nextRoute = auth_route;
          } else {
            nextRoute = home_route;
          }
        });
        getUserName().then((response) {
          Get.find<MainController>().updateMainStete(
            newUserName: response,
          );
        });
      }
    });
  }

  pass() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    Navigator.pushReplacementNamed(context, nextRoute);
  }
}
