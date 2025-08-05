import 'package:flutter/material.dart';
import 'package:pamagsalin/utils/constants.dart';

class GradientText extends StatelessWidget {
  const GradientText(this.text, {this.style});

  final String text;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback:
          (bounds) => LinearGradient(
            colors: [kPink100, kGray100, kGray200],
          ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(text, style: style),
    );
  }
}
