// Fade Blur Strategy
import 'dart:ui';

import 'package:flutter/material.dart';
import '../text_reveal_widget.dart';

class FadeBlurStrategy extends BaseAnimationStrategy {
  final double maxBlur;

  const FadeBlurStrategy({this.maxBlur = 8.0})
      : super(); // Make constructor const

  @override
  Widget buildAnimatedCharacter({
    required String character,
    required Animation<double> animation,
    TextStyle? style,
  }) {
    return ValueListenableBuilder<double>(
      valueListenable: animation,
      builder: (context, value, _) => Opacity(
        opacity: value,
        child: ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: (1 - value) * maxBlur,
            sigmaY: (1 - value) * maxBlur,
          ),
          child: Text(character, style: style),
        ),
      ),
    );
  }
}
