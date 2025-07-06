import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    super.key,
    required this.iconData,
    this.fillColor,
    required this.onPressed,
  });

  final IconData iconData;
  final Color? fillColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: fillColor ?? Theme.of(context).scaffoldBackgroundColor,
      shape: CircleBorder(),
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Icon(iconData, size: 30),
      ),
    );
  }
}