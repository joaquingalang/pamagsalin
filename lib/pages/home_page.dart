import 'package:flutter/material.dart';
import 'package:pamagsalin/utils/constants.dart';
import 'package:pamagsalin/components/gradient/gradient_background.dart';
import 'package:pamagsalin/components/gradient//gradient_text.dart';
import 'package:pamagsalin/components/buttons/round_icon_button.dart';
import 'package:pamagsalin/components/buttons/record_button.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: GradientBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Offset
            const SizedBox(height: 50),

            // AppBar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mayap a abak!',
                  style: kPoppinsBodyMedium,
                ),
                RoundIconButton(
                  padding: EdgeInsets.all(8),
                  onPressed: () {},
                  icon: Icon(Icons.search, color: Colors.white, size: 23),
                ),
              ],
            ),

            // Welcome Message
            GradientText(
              'Speak\nKapampangan.\nUnderstand\nEnglish.',
              style: kPoppinsTitleLarge,
            ),

            // Record Button
            Expanded(child: Center(child: RecordButton(onPressed: () {}))),
          ],
        ),
      ),
    );
  }
}