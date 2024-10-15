import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/main_controller.dart';
import 'package:soulscribe/widgets/snackbar.dart';

Widget userProfileImage(BuildContext context,
        {required IconData icon, void Function()? onTap}) =>
    GetBuilder<MainController>(
        builder: (_) => GestureDetector(
              onTap: () {
                ShowSnackBar(context,
                    backgroundColor: kSecondaryColor.withOpacity(0.9),
                    success: false,
                    content: "Profile edditing isn't activated yet.");
              },
              child: Center(
                child: Stack(
                  children: [
                    ClipOval(
                      child: Material(
                        color: Colors.transparent,
                        child: _.imageUrl != ""
                            ? Ink.image(
                                image: FileImage(File(_.imageUrl))
                                    as ImageProvider,
                                fit: BoxFit.cover,
                                width: 128,
                                height: 128,
                                child: InkWell(onTap: () {}),
                              )
                            : Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: kSecondaryColor),
                                child: const Icon(
                                  IconlyBold.profile,
                                  color: Colors.white,
                                  size: 100,
                                ),
                              ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 4,
                      child: InkWell(
                        onTap: onTap,
                        child: buildCircle(
                          color: kSecondaryColor,
                          all: 3,
                          child: buildCircle(
                            color: kWhiteColor,
                            all: 8,
                            child: Icon(
                              icon,
                              color: kSecondaryColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
Widget buildCircle({
  required Widget child,
  required double all,
  required Color color,
}) =>
    ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
