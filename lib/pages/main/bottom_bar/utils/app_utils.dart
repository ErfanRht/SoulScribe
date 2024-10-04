import 'package:flutter/material.dart';
import 'dart:core';

part 'extension/boolean_ext.dart';
part 'extension/general_ext.dart';
part 'extension/iterable_ext.dart';
part 'extension/pair_ext.dart';
part 'extension/string_ext.dart';
part 'extension/datetime_ext.dart';

class Utils {
  static double getAnimationOneWayValue(Animation animation) {
    final value = animation.value!;

    if (animation.status == AnimationStatus.dismissed) {
      return 1;
    }
    return animation.status == AnimationStatus.reverse ? 1 - value : value;
  }
}
