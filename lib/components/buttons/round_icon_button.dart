import 'package:flutter/material.dart';
import 'package:pamagsalin/utils/constants.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    super.key,
    required this.icon,
    required this.padding,
    this.backgroundColor = kPink200,
    this.animationDuration,
    this.animationCurve,
    required this.onPressed,
  });

  final Icon icon;
  final EdgeInsets padding;
  final Color backgroundColor;
  final Duration? animationDuration;
  final Curve? animationCurve;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(120),
        ),
        duration: animationDuration ?? Duration(milliseconds: 100),
        curve: animationCurve ?? Curves.easeIn,
        child: icon,
      ),
    );
  }
}