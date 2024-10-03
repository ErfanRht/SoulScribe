// ignore_for_file: no_wildcard_variable_uses, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/constants/routes.dart';
import 'package:soulscribe/main_controller.dart';
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
        systemNavigationBarColor:
            kSecondaryColor, // Bottom navigation bar color
        systemNavigationBarIconBrightness: Brightness.dark, // Icon color
      ),
    );
    startLoadingAnimations();
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
                    color: Colors.white,
                    nameColor: Colors.white,
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
    await checkUserName().then((response) {
      Get.find<MainController>().updateMainStete(
        newFirstEnterStatus: !response,
      );
      setState(() {
        isFirstEnter = !response;
        if (isFirstEnter) {
          nextRoute = intro_route;
        } else {
          // getTasks();
          getUserName().then((response) {
            Get.find<MainController>().updateMainStete(
              newUserName: response,
            );
          });
          // getUserEmail();

          nextRoute = home_route;
        }
      });
    });
  }

  pass() async {
    await Future.delayed(loadingAnimationsController.allAnimationTimes);
    Navigator.pushReplacementNamed(context, nextRoute);
  }
}
