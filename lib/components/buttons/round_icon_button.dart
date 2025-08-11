import 'package:flutter/material.dart';
import 'package:pamagsalin/utils/constants.dart';

class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    super.key,
    required this.icon,
    required this.padding,
    required this.onPressed,
    this.backgroundColor = kPink200,
  });

  final Icon icon;
  final EdgeInsets padding;
  final Color backgroundColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(120),
        ),
        child: icon,
      ),
    );
  }
}