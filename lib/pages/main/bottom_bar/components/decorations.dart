import 'package:flutter/material.dart';
import 'package:soulscribe/constants/colors.dart';
import 'package:soulscribe/pages/main/bottom_bar/components/colors.dart';

decorOnlySolid({Color? color, double? radius}) => BoxDecoration(
    borderRadius: BorderRadius.circular(radius ?? 10), color: color);

decorOnlyBorder({Color? color, double? radius, double? width}) => BoxDecoration(
    border: Border.all(color: color ?? colorGrey5, width: width ?? 0.5),
    borderRadius: BorderRadius.circular(radius ?? 10));

decorOnlyBorderBottom({Color? color, double? width, Color? colorSolid}) =>
    BoxDecoration(
        color: colorSolid,
        border: Border(
            bottom:
                BorderSide(color: color ?? colorGrey5, width: width ?? 0.5)));

decorOnlyBorderTop({Color? color, double? width, Color? colorSolid}) =>
    BoxDecoration(
        color: colorSolid,
        border: Border(
            top: BorderSide(color: color ?? colorGrey5, width: width ?? 0.5)));

decorOnlyBorderLeft({Color? color, double? width, Color? colorSolid}) =>
    BoxDecoration(
        color: colorSolid,
        border: Border(
            left: BorderSide(color: color ?? colorGrey5, width: width ?? 0.5)));

decorOnlyBorderRight({Color? color, double? width, Color? colorSolid}) =>
    BoxDecoration(
        color: colorSolid,
        border: Border(
            right:
                BorderSide(color: color ?? colorGrey5, width: width ?? 0.5)));

decorSolidBorder(
        {Color? colorBorder,
        Color? colorSolid,
        double? radius,
        double? borderWidth}) =>
    BoxDecoration(
        border: Border.all(
            color: colorBorder ?? colorGrey5, width: borderWidth ?? 0.5),
        borderRadius: BorderRadius.circular(radius ?? 10),
        color: colorSolid);

decorSolidRound({bool? isShadow, required double radius, Color? color}) =>
    BoxDecoration(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      boxShadow: (isShadow != true)
          ? null
          : [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 3), // changes position of shadow
              )
            ],
    );

decorShadow() {
  return BoxDecoration(
    color: kWhiteColor,
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.2),
        spreadRadius: 1,
        blurRadius: 7,
        offset: const Offset(0, 2), // changes position of shadow
      ),
    ],
  );
}
