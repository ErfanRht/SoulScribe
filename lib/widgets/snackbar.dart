import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:soulscribe/constants/colors.dart';

ShowSnackBar(BuildContext context,
    {Color backgroundColor = kPrimaryColor,
    bool success = true,
    required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating, // Makes it float above content
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 125),
      elevation: 10,
      animation: CurvedAnimation(
        parent: AnimationController(
          vsync: Scaffold.of(context),
          duration: const Duration(milliseconds: 500),
        ),
        curve: Curves.easeInOut,
      ),
      duration: const Duration(milliseconds: 1500),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            success
                ? FontAwesomeIcons.circleCheck
                : FontAwesomeIcons.circleXmark,
            color: kWhiteColor,
            size: 22.5,
          ),
          const SizedBox(width: 10),
          Text(
            content,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: kWhiteColor,
            ),
          ),
        ],
      )));
}
