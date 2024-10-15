part of '../app_utils.dart';

extension BooleanExtensions on bool? {
  /// Returns the inverse of this boolean.
  bool? not() {
    if (this == null) return null;
    return !this!;
  }

  /// Performs a logical `and` operation between this Boolean and the [other] one. Unlike the `&&` operator,
  /// this function does not perform short-circuit evaluation. Both `this` and [other] will always be evaluated.
  bool? and(bool? other) {
    if (this == null || other == null) return null;
    return this! && other;
  }

  /// Performs a logical `or` operation between this Boolean and the [other] one. Unlike the `||` operator,
  //  this function does not perform short-circuit evaluation. Both `this` and [other] will always be evaluated.
  bool? or(bool other) {
    // ignore: unnecessary_null_comparison
    if (this == null || other == null) return null;
    return this! || other;
  }

  /// Performs a logical `xor` operation between this Boolean and the [other] one.
  bool? xor(bool other) {
    // ignore: unnecessary_null_comparison
    if (this == null || other == null) return null;
    return this != other;
  }
}
