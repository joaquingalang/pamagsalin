import 'package:flutter/material.dart';
import 'package:pamagsalin/utils/constants.dart';

class TranslationBox extends StatelessWidget {
  const TranslationBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        color: kGray200,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Transform.translate(
                offset: Offset(0, -20),
                child: Icon(
                  Icons.more_horiz,
                  color: kRed300,
                  size: 250,
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Transform.translate(
                offset: Offset(0, 40),
                child: Text(
                  "Hang tight, we're catching every word...",
                  style: TextStyle(color: kGray100),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}