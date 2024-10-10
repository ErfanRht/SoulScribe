import 'package:flutter/material.dart';

Widget smallDivider(Color color) => Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 24,
      width: 1,
      child: VerticalDivider(
        color: color.withOpacity(0.75),
        thickness: 1.5,
      ),
    );
Widget bigDivider(Color color) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7.5),
      child: Divider(
        color: color.withOpacity(0.75),
        thickness: 2.5,
      ),
    );
