import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'models/emoji_model.dart';
import 'presets.dart';

typedef EmojiBuilder = Widget Function(int, EmojiModel, bool);

/// A fully customizable widget to receive feedback from your users.
/// Can be used to get user's mood or evaluate experience (and more !)
///
/// The widget is a row of emojis. Each emoji is a `SvgPicture` widget.
/// The `EmojiBuilder` function is used to build the emoji.
///
/// The `EmojiBuilder` function takes 3 parameters:
/// - `index`: The index of the emoji in the `emojiPreset` list
/// - `emoji`: The emoji model
/// - `isActive`: Whether the emoji is active or not
///
/// The `emojiPreset` list can be customized with the `EmojiModel` class.
/// If you wish to use custom labels, you can use the `customLabels` attribute
class EmojiFeedback extends StatelessWidget {
  const EmojiFeedback({
    super.key,
    this.rating,
    this.onChanged,
    this.emojiPreset = classicEmojiPreset,
    this.presetBuilder,
    this.showLabel = true,
    this.labelTextStyle,
    this.animDuration = const Duration(milliseconds: 150),
    this.customLabels,
    this.inactiveElementBlendColor,
    this.inactiveElementScale = 0.7,
    this.elementSize,
    this.curve = Curves.linear,
    this.spaceBetweenItems = 10,
    this.labelPadding = const EdgeInsets.only(top: 5.0),
    this.enableFeedback = false,
    this.minRating = 1,
    this.maxRating = 5,
  })  : assert(emojiPreset.length > 0),
        assert(
          customLabels == null || customLabels.length == emojiPreset.length,
          'emojiPreset and customLabels should have the same length',
        ),
        assert(minRating <= maxRating),
        assert(
          rating == null || (rating >= minRating && rating <= maxRating),
          'rating should be null or between minRating and maxRating',
        );

  /// Current rating
  final int? rating;

  /// Function called when an item is selected.
  /// Values goes from 1 to `preset.length`
  ///
  /// For the classicEmojiPresset, which length is 5, the values will go from 0 to 5
  final ValueChanged<int?>? onChanged;

  /// List of emojis
  /// Defaults to `classicEmojiPreset`
  ///
  /// Available presets: `classicEmojiPreset`, `flatEmojiPreset`, `threeDEmojiPreset`
  ///
  /// You can create your own presets with the `EmojiModel` class.
  /// If you wish to use custom labels, you can use the `customLabels` attribute
  final List<EmojiModel> emojiPreset;

  /// Duration of the scale animation
  /// Defaults to `const Duration(milliseconds: 150)`
  final Duration animDuration;

  /// Custom emoji widget builder
  final EmojiBuilder? presetBuilder;

  /// Wether the label should be displayed or not
  /// Defaults to `true`
  final bool showLabel;

  /// Style of the emoji label
  ///
  /// Defaults to `TextStyle(fontSize: 12, color: Colors.black)`
  final TextStyle? labelTextStyle;

  /// Define your custom labels using this attribute.
  /// Useful if you wish to use the predefined emojis with custom labels
  final List<String>? customLabels;

  /// Custom blend color for inactive elements
  /// Defaults to `Colors.grey`
  final Color? inactiveElementBlendColor;

  /// Scale factor of inactiveElements
  /// Range from `0.0` to `1.0`
  /// Defaults to `0.7`
  final double inactiveElementScale;

  /// Space between items
  /// Defaults to `10.0`
  final double spaceBetweenItems;

  /// Size of emoji elements
  /// Default value is calculated so each element occupate the same amount of space
  ///
  /// Formula: `(maxWidth / emojiCount) - spaceBetweenItems`
  final double? elementSize;

  /// Label padding
  /// Defaults to `EdgeInsets.only(top: 5.0)`
  final EdgeInsetsGeometry labelPadding;

  /// Scale animation curve
  /// Defaults to `Curves.linear`
  ///
  /// See [Curves](https://api.flutter.dev/flutter/animation/Curves-class.html)
  final Curve curve;

  /// Enable haptic feedback
  /// Defaults to `false`
  final bool enableFeedback;

  /// Minimum rating
  /// Defaults to `1`
  final int minRating;

  /// Maximum rating
  /// Defaults to `5`
  final int maxRating;

  void _handleTap(int index) {
    final newRating = index + minRating;
    final updatedRating = rating == newRating ? null : newRating;
    onChanged?.call(updatedRating);

    if (enableFeedback) {
      HapticFeedback.lightImpact();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double elementSize = this.elementSize ??
            (constraints.maxWidth / emojiPreset.length) - spaceBetweenItems;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: emojiPreset
              .take(maxRating - minRating + 1)
              .mapIndexed((index, element) => _EmojiItem(
                    emoji: element,
                    index: index,
                    isActive: rating == index + minRating,
                    onTap: _handleTap,
                    builder: presetBuilder,
                    showLabel: showLabel,
                    labelTextStyle: labelTextStyle,
                    customLabel: customLabels?.elementAt(index),
                    inactiveElementBlendColor: inactiveElementBlendColor,
                    inactiveElementScale: inactiveElementScale,
                    elementSize: elementSize,
                    labelPadding: labelPadding,
                    animDuration: animDuration,
                    curve: curve,
                  ))
              .toList(),
        );
      },
    );
  }
}

class _EmojiItem extends StatelessWidget {
  const _EmojiItem({
    required this.emoji,
    required this.index,
    required this.isActive,
    required this.onTap,
    this.builder,
    required this.showLabel,
    this.labelTextStyle,
    this.customLabel,
    this.inactiveElementBlendColor,
    required this.inactiveElementScale,
    required this.elementSize,
    required this.labelPadding,
    required this.animDuration,
    required this.curve,
  });

  final EmojiModel emoji;
  final int index;
  final bool isActive;
  final ValueChanged<int> onTap;
  final EmojiBuilder? builder;
  final bool showLabel;
  final TextStyle? labelTextStyle;
  final String? customLabel;
  final Color? inactiveElementBlendColor;
  final double inactiveElementScale;
  final double elementSize;
  final EdgeInsetsGeometry labelPadding;
  final Duration animDuration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final child = builder?.call(index, emoji, isActive) ??
        SvgPicture.asset(
          emoji.src,
          width: elementSize,
          package: emoji.package,
        );

    return AnimatedScale(
      scale: isActive ? 1 : inactiveElementScale,
      duration: animDuration,
      curve: curve,
      child: Column(
        children: [
          GestureDetector(
            onTap: () => onTap(index),
            child: isActive
                ? child
                : Container(
                    foregroundDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: inactiveElementBlendColor ?? Colors.grey,
                      backgroundBlendMode: BlendMode.saturation,
                    ),
                    child: child,
                  ),
          ),
          if (showLabel)
            Padding(
              padding: labelPadding,
              child: Text(
                customLabel ?? emoji.label,
                style: labelTextStyle,
              ),
            ),
        ],
      ),
    );
  }
}
