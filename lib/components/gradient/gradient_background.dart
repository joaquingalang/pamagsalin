import 'package:flutter/material.dart';
import 'package:pamagsalin/utils/constants.dart';
import 'package:blurrycontainer/blurrycontainer.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Positioned(
          left: -100,
          child: Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              color: kPink100,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              color: kPink100,
              shape: BoxShape.circle,
            ),
          ),
        ),
        BlurryContainer(
          width: screenWidth,
          height: screenHeight,
          padding: EdgeInsets.symmetric(horizontal: 32),
          color: kBlack100.withOpacity(0.75),
          borderRadius: BorderRadius.zero,
          blur: 400,
          child: child,
        ),
      ],
    );
  }
}
