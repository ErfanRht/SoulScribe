/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class Assets {
  Assets._();

  static const String classicAwesome = 'assets/images/mood/classic_awesome.svg';
  static const String classicBad = 'assets/images/mood/classic_bad.svg';
  static const String classicGood = 'assets/images/mood/classic_good.svg';
  static const String classicTerrible =
      'assets/images/mood/classic_terrible.svg';
  static const String classicVeryGood =
      'assets/images/mood/classic_very_good.svg';
  static const String flatAwesome = 'assets/images/mood/flat_awesome.svg';
  static const String flatBad = 'assets/images/mood/flat_bad.svg';
  static const String flatGood = 'assets/images/mood/flat_good.svg';
  static const String flatTerrible = 'assets/images/mood/flat_terrible.svg';
  static const String flatVeryGood = 'assets/images/mood/flat_very_good.svg';
  static const String hdAwesome = 'assets/images/mood/hd_awesome.svg';
  static const String hdBad = 'assets/images/mood/hd_bad.svg';
  static const String hdGood = 'assets/images/mood/hd_good.svg';
  static const String hdTerrible = 'assets/images/mood/hd_terrible.svg';
  static const String hdVeryGood = 'assets/images/mood/hd_very_good.svg';
  static const String threeDAwesome = 'assets/images/mood/three_d_awesome.svg';
  static const String threeDBad = 'assets/images/mood/three_d_bad.svg';
  static const String threeDGood = 'assets/images/mood/three_d_good.svg';
  static const String threeDTerrible =
      'assets/images/mood/three_d_terrible.svg';
  static const String threeDVeryGood =
      'assets/images/mood/three_d_very_good.svg';

  /// List of all assets
  List<String> get values => [
        classicAwesome,
        classicBad,
        classicGood,
        classicTerrible,
        classicVeryGood,
        flatAwesome,
        flatBad,
        flatGood,
        flatTerrible,
        flatVeryGood,
        hdAwesome,
        hdBad,
        hdGood,
        hdTerrible,
        hdVeryGood,
        threeDAwesome,
        threeDBad,
        threeDGood,
        threeDTerrible,
        threeDVeryGood
      ];
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
